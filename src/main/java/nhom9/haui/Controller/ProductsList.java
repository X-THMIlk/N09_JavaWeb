package nhom9.haui.Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nhom9.haui.DAO.IProductDAO;
import nhom9.haui.DAO.ProductDAO;
import nhom9.haui.Model.Product;

@WebServlet("/ProductList")
public class ProductsList extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductsList() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        IProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.getAllProducts();

        // Lưu danh sách sản phẩm vào session
        request.getSession().setAttribute("productList", productList);

        // Chuyển hướng tới trang Home.jsp
        response.sendRedirect(request.getContextPath() + "/Products/Home.jsp");
    }
}
