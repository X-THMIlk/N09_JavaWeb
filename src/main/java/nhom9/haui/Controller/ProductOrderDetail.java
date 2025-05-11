package nhom9.haui.Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nhom9.haui.DAO.ConnectJDBC;
import nhom9.haui.DAO.OrderDAO;
import nhom9.haui.Model.Admin;
import nhom9.haui.Model.Cart;
import nhom9.haui.Model.Users;

@WebServlet("/ProductOrderDetail")
public class ProductOrderDetail extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ProductOrderDetail() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String[] selectedIds = request.getParameterValues("selectedIds");

        if (selectedIds == null || selectedIds.length == 0) {
            response.sendRedirect(request.getContextPath() + "/ProductCartList");
            return;
        }

        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        Admin admin = (Admin) session.getAttribute("admin");

        String customerName = "";
        String email = "";

        if (user != null) {
            if (phone != null && !phone.isEmpty() && !phone.equals(user.getPhone())) {
                user.setPhone(phone);
            }
            if (address != null && !address.isEmpty() && !address.equals(user.getAddress())) {
                user.setAddress(address);
            }

            // Cập nhật thông tin người dùng
            try (Connection cnn = new ConnectJDBC().getConnection()) {
                String sql = "UPDATE Users SET phone = ?, address = ? WHERE id = ?";
                try (PreparedStatement pst = cnn.prepareStatement(sql)) {
                    pst.setString(1, user.getPhone());
                    pst.setString(2, user.getAddress());
                    pst.setInt(3, user.getId());
                    pst.executeUpdate();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Lỗi khi cập nhật thông tin!");
                return;
            }

            customerName = user.getUsername();
            email = user.getEmail();

        } else if (admin != null) {
            customerName = admin.getUsername();
            email = admin.getEmail();

            if (phone == null || phone.isEmpty()) phone = admin.getPhone();
            if (address == null || address.isEmpty()) address = admin.getAddress();
        }

        List<Cart> cartList = (List<Cart>) session.getAttribute("cartList");
        LocalDateTime orderTime = LocalDateTime.now();

        // Gọi DAO để xử lý đơn hàng
        try {
            OrderDAO dao = new OrderDAO();
            dao.createOrderPerItem(customerName, email, phone, address, cartList, selectedIds, orderTime);
            response.sendRedirect(request.getContextPath() + "/Products/OrderList");
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi khi tạo đơn hàng!");
        }
    }
}
