package nhom9.haui.Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nhom9.haui.DAO.ConnectJDBC;
import nhom9.haui.Model.Product;

@WebServlet("/Products/PromotionEditForm")
public class PromotionEditForm extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy id sản phẩm từ request parameter
        int id = Integer.parseInt(request.getParameter("id"));
        
        try (Connection conn = new ConnectJDBC().getConnection()) {
            String sql = "SELECT * FROM Products WHERE id = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();
            
            if (rs.next()) {
                // Tạo đối tượng Product từ dữ liệu truy vấn
                Product product = new Product(id, id, id, sql, sql, id, id, sql, sql, sql);
                product.setId(rs.getInt("id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setPromotionId(rs.getInt("promotion_id"));
                product.setName(rs.getString("name"));
                product.setCode(rs.getString("code"));
                product.setPrice(rs.getInt("price"));
                product.setQuantity(rs.getInt("quantity"));
                product.setThumbnail(rs.getString("thumbnail"));
                product.setDescription(rs.getString("description"));
                product.setCreatedAt(rs.getString("created_at"));
                
                // Đưa sản phẩm vào request attribute để truyền vào JSP
                request.setAttribute("product", product);
                
                // Chuyển hướng đến trang chỉnh sửa
                request.getRequestDispatcher("/Products/PromotionEditForm.jsp").forward(request, response);
            } else {
                response.getWriter().println("Không tìm thấy sản phẩm với id: " + id);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi khi truy vấn sản phẩm: " + e.getMessage());
        }
    }
}
