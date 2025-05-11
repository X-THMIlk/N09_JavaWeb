package nhom9.haui.Controller;
import nhom9.haui.DAO.IProductDAO;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nhom9.haui.DAO.ProductDAO;
import nhom9.haui.Model.Product;

@WebServlet("/ProductSearch")
public class ProductSearch extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String keyword = request.getParameter("product");

        IProductDAO productSearchDAO = new ProductDAO();
        List<Product> productList = productSearchDAO.searchProductsByKeyword(keyword);

        System.out.println("Danh sách sản phẩm tìm được: " + keyword + " " + productList.size());
        for (Product p : productList) {
            System.out.println(p.getName());
        }

        // Lưu danh sách sản phẩm vào session
        request.getSession().setAttribute("productList", productList);

        // Chuyển hướng tới trang tìm kiếm sản phẩm
        response.sendRedirect(request.getContextPath() + "/Products/ProductSearch.jsp");
    }
}
