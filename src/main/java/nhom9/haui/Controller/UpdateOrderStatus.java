package nhom9.haui.Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nhom9.haui.DAO.IOrderDAO;
import nhom9.haui.DAO.OrderDAO;

/**
 * Servlet implementation class UpdateOrderStatus
 */
@WebServlet("/Products/UpdateOrderStatus")
public class UpdateOrderStatus extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");
        System.out.print(status);
        // Gọi DAO để cập nhật trạng thái đơn hàng
        IOrderDAO orderDAO = new OrderDAO();
        orderDAO.updateStatus(orderId, status);

        response.sendRedirect(request.getContextPath() + "/Products/OrderList"); // hoặc jsp chi tiết đơn hàng
    }
}