package nhom9.haui.Controller;
import nhom9.haui.DAO.ICartDAO;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nhom9.haui.DAO.CartDAO;

@WebServlet("/ProductCard")
public class ProductCard extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ProductCard() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String quantity = request.getParameter("quantity");
        String price = request.getParameter("price");
        String image = request.getParameter("image");
        String code = request.getParameter("code");
        String username = "quangvu0407";  // Lấy username từ session hoặc yêu cầu đăng nhập.

        // Khởi tạo CartDAO để thêm sản phẩm vào giỏ hàng
        ICartDAO cartDAO = new CartDAO();
        boolean isAdded = cartDAO.addProductToCart(Integer.parseInt(id), name, Integer.parseInt(quantity), Integer.parseInt(price), image, username);

        if (isAdded) {
            System.out.println("Đã thêm sản phẩm vào giỏ hàng!");
            response.sendRedirect(request.getContextPath() + "/ProductCartList");
        } else {
            response.getWriter().println("Lỗi khi thêm sản phẩm vào giỏ hàng!");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
