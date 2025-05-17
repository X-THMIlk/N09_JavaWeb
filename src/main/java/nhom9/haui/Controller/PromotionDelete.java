package nhom9.haui.Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nhom9.haui.DAO.IProductDAO;
import nhom9.haui.DAO.ProductDAO;

/**
 * Servlet implementation class PromotionDelete
 */
@WebServlet("/Products/PromotionDelete")
public class PromotionDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PromotionDelete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uid = request.getParameter("id");
        int productId = Integer.parseInt(uid);
        
        IProductDAO productDAO = new ProductDAO();
        boolean success = productDAO.deleteProductById(productId);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/Products/PromotionProductList");
        } else {
            response.getWriter().println("Lỗi khi xóa sản phẩm!");
        }
    }
}