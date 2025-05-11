package nhom9.haui.Products;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nhom9.haui.Model.Product;
import nhom9.haui.Model.Promotions;  // Import model Promotions
import nhom9.haui.jdbc.ConnectJDBC;

/**
 * Servlet implementation class ProductsList
 */
@WebServlet("/ProductList")
public class ProductsList extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductsList() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        List<Product> productList = new ArrayList<>();

        try (Connection cnn = new ConnectJDBC().getConnection();
             PreparedStatement pst = cnn.prepareStatement(
                     "SELECT p.*, pr.* FROM Products p " +
                     "LEFT JOIN Promotions pr ON p.promotion_id = pr.id");
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                // Lấy thông tin từ bảng Products
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getInt("category_id"),
                        rs.getObject("promotion_id") != null ? rs.getInt("promotion_id") : null,
                        rs.getString("name"),
                        rs.getString("code"),
                        rs.getInt("price"),
                        rs.getInt("quantity"),
                        rs.getString("thumbnail"),
                        rs.getString("description"),
                        rs.getString("created_at")
                );

                // Lấy thông tin từ bảng Promotions nếu có
                if (rs.getObject("promotion_id") != null) {
                    Promotions promotion = new Promotions(
                            rs.getInt("promotion_id"),
                            rs.getString("pr.name"),
                            rs.getString("pr.description"),
                            rs.getDouble("pr.discount_percent"),
                            rs.getDate("pr.start_date"),
                            rs.getDate("pr.end_date")
                    );
                    p.setPromotion(promotion); // Set promotion vào product
                }

                productList.add(p);
            }

            // Lưu danh sách sản phẩm vào session
            request.getSession().setAttribute("productList", productList);

            // Chuyển hướng tới trang Home.jsp
            response.sendRedirect(request.getContextPath() + "/Products/Home.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi khi truy vấn CSDL!");
        }
    }
}
