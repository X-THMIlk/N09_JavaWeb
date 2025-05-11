package nhom9.haui.Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import nhom9.haui.DAO.ILoginDAO;
import nhom9.haui.DAO.LoginDAO;
import nhom9.haui.Model.Admin;
import nhom9.haui.Model.Users;

@WebServlet("/ProductLogin")
public class ProductLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ProductLogin() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        ILoginDAO authDAO = new LoginDAO();

        Users user = authDAO.loginUser(username, password);
        if (user != null) {
            request.getSession().setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/ProductList");
            return;
        }

        Admin admin = authDAO.loginAdmin(username, password);
        if (admin != null) {
            request.getSession().setAttribute("admin", admin);
            response.sendRedirect(request.getContextPath() + "/ProductList");
            return;
        }

        // Nếu không đúng thông tin
        request.setAttribute("error", "Sai tài khoản hoặc mật khẩu!");
        response.sendRedirect(request.getContextPath() + "/Products/Login.jsp");
    }
}
