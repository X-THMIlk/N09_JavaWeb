package nhom9.haui.Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nhom9.haui.DAO.ProductDAO;

@WebServlet("/Products/ProductsDelete")
public class ProductsDelete extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ProductsDelete() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uid = request.getParameter("id");
        int productId = Integer.parseInt(uid);
        
        ProductDAO productDAO = new ProductDAO();
        boolean success = productDAO.deleteProductById(productId);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/Products/ProductCatage");
        } else {
            response.getWriter().println("Lỗi khi xóa sản phẩm!");
        }
    }
}
