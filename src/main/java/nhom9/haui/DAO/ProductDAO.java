package nhom9.haui.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import nhom9.haui.Model.Product;
import nhom9.haui.Model.Promotions;

public class ProductDAO {

    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT p.*, pr.* FROM Products p LEFT JOIN Promotions pr ON p.promotion_id = pr.id";
        
        try (Connection conn = new ConnectJDBC().getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            
            while (rs.next()) {
                // Lấy thông tin từ bảng Products
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getInt("category_id"),
                        rs.getObject("promotion_id") != null ? rs.getInt("promotion_id") : null,
                        rs.getString("name"),
                        rs.getString("code"),
                        rs.getInt("price"),
                        rs.getInt("quantity"),
                        rs.getString("thumbnail"),
                        rs.getString("description"),
                        rs.getString("created_at")
                );

                // Lấy thông tin từ bảng Promotions nếu có
                if (rs.getObject("promotion_id") != null) {
                    Promotions promotion = new Promotions(
                            rs.getInt("promotion_id"),
                            rs.getString("pr.name"),
                            rs.getString("pr.description"),
                            rs.getDouble("pr.discount_percent"),
                            rs.getDate("pr.start_date"),
                            rs.getDate("pr.end_date")
                    );
                    p.setPromotion(promotion); // Set promotion vào product
                }

                productList.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return productList;
    }
    public List<Product> searchProductsByKeyword(String keyword) {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM Products WHERE name LIKE ? COLLATE utf8mb4_unicode_ci";

        try (Connection conn = new ConnectJDBC().getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, "%" + keyword + "%");

            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product(
                            rs.getInt("id"),
                            rs.getInt("category_id"),
                            rs.getObject("promotion_id") != null ? rs.getInt("promotion_id") : null,
                            rs.getString("name"),
                            rs.getString("code"),
                            rs.getInt("price"),
                            rs.getInt("quantity"),
                            rs.getString("thumbnail"),
                            rs.getString("description"),
                            rs.getString("created_at")
                    );
                    productList.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }
    
    public boolean deleteProductById(int productId) {
        Connection cnn = null;

        try {
            cnn = new ConnectJDBC().getConnection();
            cnn.setAutoCommit(false); // Bắt đầu transaction

            // Xóa comment
            String deleteCommentsSql = "DELETE FROM Comments WHERE product_id = ?";
            try (PreparedStatement pst = cnn.prepareStatement(deleteCommentsSql)) {
                pst.setInt(1, productId);
                pst.executeUpdate();
            }

            // Xóa chi tiết đơn hàng
            String deleteOrderDetailsSql = "DELETE FROM OrderDetails WHERE product_id = ?";
            try (PreparedStatement pst = cnn.prepareStatement(deleteOrderDetailsSql)) {
                pst.setInt(1, productId);
                pst.executeUpdate();
            }

            // Xóa khỏi giỏ hàng
            String deleteCartSql = "DELETE FROM Cart WHERE product_id = ?";
            try (PreparedStatement pst = cnn.prepareStatement(deleteCartSql)) {
                pst.setInt(1, productId);
                pst.executeUpdate();
            }

            // Xóa sản phẩm chính
            String deleteProductSql = "DELETE FROM Products WHERE id = ?";
            try (PreparedStatement pst = cnn.prepareStatement(deleteProductSql)) {
                pst.setInt(1, productId);
                pst.executeUpdate();
            }

            cnn.commit(); // Commit nếu mọi thứ ok
            return true;
        } catch (SQLException e) {
            if (cnn != null) {
                try {
                    cnn.rollback(); // Rollback nếu có lỗi
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            if (cnn != null) {
                try {
                    cnn.setAutoCommit(true);
                    cnn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    public Product getProductById(int id) {
        Product product = null;
        try (Connection conn = new ConnectJDBC().getConnection()) {
            String sql = "SELECT * FROM Products WHERE id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                product = new Product();
                product.setId(rs.getInt("id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setName(rs.getString("name"));
                product.setCode(rs.getString("code"));
                product.setPrice(rs.getInt("price"));
                product.setQuantity(rs.getInt("quantity"));
                product.setThumbnail(rs.getString("thumbnail"));
                product.setDescription(rs.getString("description"));
                product.setCreatedAt(rs.getString("created_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

        // Phương thức thêm sản phẩm mới
        public boolean addProduct(Product product) {
            String sql = "INSERT INTO Products (Promotion_id, category_id, name, code, price, quantity, thumbnail, description, created_at) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            try (Connection conn = new ConnectJDBC().getConnection();
                 PreparedStatement pst = conn.prepareStatement(sql)) {
                 
                pst.setInt(1, product.getPromotionId());
                pst.setInt(2, product.getCategoryId());
                pst.setString(3, product.getName());
                pst.setString(4, product.getCode());
                pst.setInt(5, product.getPrice());
                pst.setInt(6, product.getQuantity());
                pst.setString(7, product.getThumbnail());
                pst.setString(8, product.getDescription());
                pst.setDate(9, new Date(System.currentTimeMillis()));

                int rows = pst.executeUpdate();
                return rows > 0;

            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        }
}
