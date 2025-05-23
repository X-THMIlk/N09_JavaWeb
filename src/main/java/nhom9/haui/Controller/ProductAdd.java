<<<<<<< HEAD:src/main/java/nhom9/haui/Controller/ProductAdd.java
package nhom9.haui.Controller;
import nhom9.haui.DAO.IProductDAO;
import nhom9.haui.DAO.ProductDAO;
import nhom9.haui.Model.Product;

import java.io.IOException;
=======
package nhom9.haui.Products;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;
>>>>>>> c941d708bd6fe42efee07efc3f97872f8574e845:src/main/java/nhom9/haui/Products/ProductAdd.java
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

<<<<<<< HEAD:src/main/java/nhom9/haui/Controller/ProductAdd.java
=======
import nhom9.haui.jdbc.ConnectJDBC;

>>>>>>> c941d708bd6fe42efee07efc3f97872f8574e845:src/main/java/nhom9/haui/Products/ProductAdd.java
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
<<<<<<< HEAD:src/main/java/nhom9/haui/Controller/ProductAdd.java
        int idPromotion = Integer.parseInt(request.getParameter("idPromotion"));

        // Tạo đối tượng Product
        Product product = new Product(0, categoryId, idPromotion, name, code, price, quantity, thumbnail, description, null);

        IProductDAO productDAO = new ProductDAO();
        boolean isAdded = productDAO.addProduct(product);

        if (isAdded) {
            response.sendRedirect(request.getContextPath() + "/Products/ProductCatage");
        } else {
            response.getWriter().println("Không thể thêm sản phẩm.");
        }
    }
}
=======

        Date createdAt = new Date(System.currentTimeMillis());

        try (Connection conn = new ConnectJDBC().getConnection()) {
            String sql = "INSERT INTO Products (category_id, name, code, price, quantity, thumbnail, description, created_at) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, categoryId);
            pst.setString(2, name);
            pst.setString(3, code);
            pst.setInt(4, price);
            pst.setInt(5, quantity);
            pst.setString(6, thumbnail);
            pst.setString(7, description);
            pst.setDate(8, createdAt);

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
>>>>>>> c941d708bd6fe42efee07efc3f97872f8574e845:src/main/java/nhom9/haui/Products/ProductAdd.java
