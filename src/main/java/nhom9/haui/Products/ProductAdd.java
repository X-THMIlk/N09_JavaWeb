package nhom9.haui.Products;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nhom9.haui.jdbc.ConnectJDBC;

@WebServlet("/Products/ProductAdd")
public class ProductAdd extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String code = request.getParameter("code");
        String description = request.getParameter("description");
        int price = Integer.parseInt(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String thumbnail = request.getParameter("thumbnail");
        int categoryId = Integer.parseInt(request.getParameter("category_id"));
        int idPromotion = Integer.parseInt(request.getParameter("idPromotion"));

        Date createdAt = new Date(System.currentTimeMillis());

        try (Connection conn = new ConnectJDBC().getConnection()) {
            String sql = "INSERT INTO Products (Promotion_id, category_id, name, code, price, quantity, thumbnail, description, created_at) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1,  idPromotion);
            pst.setInt(2, categoryId);
            pst.setString(3, name);
            pst.setString(4, code);
            pst.setInt(5, price);
            pst.setInt(6, quantity);
            pst.setString(7, thumbnail);
            pst.setString(8, description);
            pst.setDate(9, createdAt);

            int rows = pst.executeUpdate();
            if (rows > 0) {
                response.sendRedirect(request.getContextPath() + "/Products/ProductCatage");
            } else {
                response.getWriter().println("Không thể thêm sản phẩm.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi khi thêm sản phẩm: " + e.getMessage());
        }
    }
}