package nhom9.haui.Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nhom9.haui.DAO.ProductDAO;
import nhom9.haui.DAO.CommentDAO;
import nhom9.haui.Model.Comments;
import nhom9.haui.Model.Product;

@WebServlet("/Products/ProductDetail")
public class ProductDetail extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ProductDetail() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(Integer.parseInt(id));  // Lấy sản phẩm từ DAO

        CommentDAO commentDAO = new CommentDAO();
        List<Comments> commentList = commentDAO.getCommentsByProductId(id);  // Lấy bình luận từ DAO

        // Gửi dữ liệu sang trang JSP
        if (product != null) {
            request.getSession().setAttribute("product", product);
            request.getSession().setAttribute("commentList", commentList);
            response.sendRedirect(request.getContextPath() + "/Products/ProductDetail.jsp");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
