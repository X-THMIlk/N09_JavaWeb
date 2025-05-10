package nhom9.haui.Products;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nhom9.haui.jdbc.ConnectJDBC;

@WebServlet("/Products/ProductEdit")
public class ProductEdit extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Lấy dữ liệu từ form
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String code = request.getParameter("code");
            String description = request.getParameter("description");
            int price = Integer.parseInt(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String thumbnail = request.getParameter("thumbnail");
            int categoryId = Integer.parseInt(request.getParameter("category_id"));

            // Kết nối và cập nhật CSDL
            try (Connection conn = new ConnectJDBC().getConnection()) {
                String sql = "UPDATE Products SET category_id = ?, name = ?, code = ?, price = ?, quantity = ?, thumbnail = ?, description = ? WHERE id = ?";
                PreparedStatement pst = conn.prepareStatement(sql);

                pst.setInt(1, categoryId);
                pst.setString(2, name);
                pst.setString(3, code);
                pst.setInt(4, price);
                pst.setInt(5, quantity);
                pst.setString(6, thumbnail);
                pst.setString(7, description);
                pst.setInt(8, id);

                int rows = pst.executeUpdate();

                if (rows > 0) {
                    // Thành công → quay về danh sách
                    response.sendRedirect(request.getContextPath() + "/Products/ProductCatage");
                } else {
                    response.getWriter().println("Không thể cập nhật sản phẩm (id không tồn tại?).");
                }
            }
        } catch (NumberFormatException e) {
            response.getWriter().println("Dữ liệu nhập không hợp lệ: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi SQL khi cập nhật sản phẩm: " + e.getMessage());
        }
    }
}
