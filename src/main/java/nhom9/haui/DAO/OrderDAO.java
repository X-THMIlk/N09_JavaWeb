package nhom9.haui.DAO;

import nhom9.haui.Model.Cart;
import nhom9.haui.Model.Order;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public void createOrderPerItem(String customerName, String email, String phone,
                                   String address, List<Cart> cartList, String[] selectedIds,
                                   LocalDateTime orderTime) throws SQLException {

        String formattedOrderTime = orderTime.toString().replace("T", " ");
        
        for (String selectedId : selectedIds) {
            int cartId = Integer.parseInt(selectedId);
            // Tìm sản phẩm tương ứng trong danh sách cart
            for (Cart item : cartList) {
                if (item.getId() == cartId) {
                    double totalAmount = item.getPrice();

                    try (Connection conn = new ConnectJDBC().getConnection()) {
                        conn.setAutoCommit(false);

                        // 1. Thêm đơn hàng
                        String insertOrder = "INSERT INTO Orders (customer_name, email, phone, address, order_date, total, paid_amount) " +
                                "VALUES (?, ?, ?, ?, ?, ?, ?)";
                        int orderId = 0;

                        try (PreparedStatement pst = conn.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS)) {
                            pst.setString(1, customerName);
                            pst.setString(2, email);
                            pst.setString(3, phone);
                            pst.setString(4, address);
                            pst.setString(5, formattedOrderTime);
                            pst.setDouble(6, totalAmount);
                            pst.setDouble(7, 0); // chưa thanh toán
                            pst.executeUpdate();

                            try (ResultSet generatedKeys = pst.getGeneratedKeys()) {
                                if (generatedKeys.next()) {
                                    orderId = generatedKeys.getInt(1);
                                }
                            }
                        }

                        // 2. Thêm chi tiết đơn hàng
                        String insertDetail = "INSERT INTO OrderDetails (order_id, product_id, price) VALUES (?, ?, ?)";
                        try (PreparedStatement pstDetail = conn.prepareStatement(insertDetail)) {
                            pstDetail.setInt(1, orderId);
                            pstDetail.setInt(2, item.getProductId());
                            pstDetail.setDouble(3, item.getPrice());
                            pstDetail.executeUpdate();
                        }

                        // 3. Xóa khỏi giỏ hàng
                        String deleteCart = "DELETE FROM Cart WHERE id = ?";
                        try (PreparedStatement pstDelete = conn.prepareStatement(deleteCart)) {
                            pstDelete.setInt(1, cartId);
                            pstDelete.executeUpdate();
                        }

                        conn.commit();
                    } catch (SQLException e) {
                        e.printStackTrace();
                        throw e; 
                    }

                    break;
                }
            }
        }
    }
    
    public List<Order> getAllOrders() {
        List<Order> orderList = new ArrayList<>();
        String query = "SELECT o.id, o.customer_name, o.email, o.phone, o.address, o.order_date, o.total, o.paid_amount, p.name, p.price, pr.discount_percent " +
                       "FROM Orders o " +
                       "JOIN OrderDetails od ON o.id = od.order_id " +
                       "JOIN Products p ON od.product_id = p.id " +
                       "LEFT JOIN Promotions pr ON p.promotion_id = pr.id";

        try (Connection conn = new ConnectJDBC().getConnection();
             PreparedStatement pst = conn.prepareStatement(query);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String customerName = rs.getString("customer_name");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                Date orderDate = rs.getDate("order_date");
                int total = rs.getInt("total");
                int paidAmount = rs.getInt("paid_amount");
                String productName = rs.getString("name");
                int discount = rs.getInt("discount_percent");
                int price = rs.getInt("price");
                int quantity = 0;
                if(discount == 0) {
                    quantity += total / price;
                } else {
                    quantity += total / (price * (100 - discount) / 100);
                }

                // Tạo đối tượng Order và thêm vào danh sách
                Order order = new Order(id, customerName, email, phone, address, orderDate, total, paidAmount, productName, quantity);
                orderList.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderList;
    }
}
