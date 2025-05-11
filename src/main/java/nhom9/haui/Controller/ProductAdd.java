package nhom9.haui.Controller;

import nhom9.haui.DAO.ProductDAO;
import nhom9.haui.Model.Product;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

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

        // Tạo đối tượng Product
        Product product = new Product(0, categoryId, idPromotion, name, code, price, quantity, thumbnail, description, null);

        ProductDAO productDAO = new ProductDAO();
        boolean isAdded = productDAO.addProduct(product);

        if (isAdded) {
            response.sendRedirect(request.getContextPath() + "/Products/ProductCatage");
        } else {
            response.getWriter().println("Không thể thêm sản phẩm.");
        }
    }
}
