package nhom9.haui.Controller;

import nhom9.haui.DAO.OrderDAO;
import nhom9.haui.Model.Order;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Products/OrderList")
public class OrderList extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public OrderList() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy danh sách đơn hàng từ DAO
        OrderDAO orderDAO = new OrderDAO();
        List<Order> orderList = orderDAO.getAllOrders();
        System.out.println("Số lượng đơn hàng: " + orderList.size());
        
        // Đặt danh sách đơn hàng vào request để chuyển tiếp tới JSP
        request.getSession().setAttribute("orderList", orderList);

        response.sendRedirect(request.getContextPath() + "/Products/OrderDetail.jsp");
    }
}
