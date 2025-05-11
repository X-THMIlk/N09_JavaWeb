package nhom9.haui.Controller;

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

import nhom9.haui.DAO.ConnectJDBC;
import nhom9.haui.Model.Product;
import nhom9.haui.Model.Promotions;

/**
 * Servlet implementation class ProductCatage
 */
@WebServlet("/Products/ProductCatage")
public class ProductCatage extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> productList = new ArrayList<>();

        // Lấy tham số page từ request, nếu không có sẽ mặc định là 1
        int page = 1;
        int recordsPerPage = 12; // Số sản phẩm trên mỗi trang

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        // Tính toán offset
        int offset = (page - 1) * recordsPerPage;

        try (Connection cnn = new ConnectJDBC().getConnection();
             PreparedStatement pst = cnn.prepareStatement(
                     "SELECT p.*, pr.* FROM Products p " +
                             "LEFT JOIN Promotions pr ON p.promotion_id = pr.id " +
                             "LIMIT ? OFFSET ?")) {

            // Thêm LIMIT và OFFSET vào câu truy vấn SQL
            pst.setInt(1, recordsPerPage);
            pst.setInt(2, offset);

            ResultSet rs = pst.executeQuery();

            // Lấy danh sách sản phẩm từ CSDL
            while (rs.next()) {
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

                // Lấy thông tin khuyến mãi nếu có
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

            // Lấy tổng số sản phẩm để tính tổng số trang
            PreparedStatement countStmt = cnn.prepareStatement("SELECT COUNT(*) FROM Products");
            ResultSet countRs = countStmt.executeQuery();
            int totalRecords = 0;
            if (countRs.next()) {
                totalRecords = countRs.getInt(1);
            }

            // Tính toán tổng số trang
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

            // Lưu danh sách sản phẩm và thông tin phân trang vào request
            request.setAttribute("productList", productList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            // Chuyển hướng đến trang ProductCatage.jsp
            request.getRequestDispatcher("/Products/ProductCatage.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi khi truy vấn CSDL!");
        }
    }
}
