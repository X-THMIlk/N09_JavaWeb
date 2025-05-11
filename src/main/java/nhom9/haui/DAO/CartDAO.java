package nhom9.haui.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import nhom9.haui.Model.Cart;

public class CartDAO implements ICartDAO{

    public boolean addProductToCart(int productId, String productName, int quantity, int price, String image, String username) {
        String sql = "INSERT INTO Cart (product_id, product_name, quantity, price, image, username) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = new ConnectJDBC().getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            
            pst.setInt(1, productId);
            pst.setString(2, productName);
            pst.setInt(3, quantity);
            pst.setInt(4, price);
            pst.setString(5, image);
            pst.setString(6, username);
            
            int rows = pst.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Cart> getCartList(String username) {
        List<Cart> cartList = new ArrayList<>();
        String selectSql = "SELECT * FROM Cart WHERE username = ?";  // Lọc theo username

        try (Connection cnn = new ConnectJDBC().getConnection();
             PreparedStatement pst = cnn.prepareStatement(selectSql)) {

            pst.setString(1, username);  // Gán username vào câu truy vấn
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Cart cartItem = new Cart(
                    rs.getInt("id"),
                    rs.getInt("product_id"),
                    rs.getString("product_name"),
                    rs.getInt("quantity"),
                    rs.getInt("price"),
                    rs.getString("image"),
                    rs.getString("username")
                );
                cartList.add(cartItem);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cartList;
    }
}
