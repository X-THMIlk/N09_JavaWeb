package nhom9.haui.Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nhom9.haui.DAO.ConnectJDBC;

@WebServlet("/Products/ProductDeleteOrder")
public class ProductDeleteOrder extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ProductDeleteOrder() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");

        if (orderIdStr == null || orderIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/Products/OrderList");
            return;
        }

        int orderId = Integer.parseInt(orderIdStr);

        try (Connection conn = new ConnectJDBC().getConnection()) {

            // Xóa chi tiết đơn hàng trước
            String deleteDetails = "DELETE FROM OrderDetails WHERE order_id = ?";
            try (PreparedStatement pstDetails = conn.prepareStatement(deleteDetails)) {
                pstDetails.setInt(1, orderId);
                pstDetails.executeUpdate();
            }

            // Sau đó xóa đơn hàng chính
            String deleteOrder = "DELETE FROM Orders WHERE id = ?";
            try (PreparedStatement pstOrder = conn.prepareStatement(deleteOrder)) {
                pstOrder.setInt(1, orderId);
                pstOrder.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi khi xóa đơn hàng!");
            return;
        }

        // Sau khi xóa, chuyển hướng về danh sách đơn hàng
        response.sendRedirect(request.getContextPath() + "/Products/OrderList");
    }
}
