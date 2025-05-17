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

@WebServlet("/Products/PromotionProductList")
public class PromotionProductList extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> productList = new ArrayList<>();

        int page = 1;
        int recordsPerPage = 12;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        int offset = (page - 1) * recordsPerPage;

        try (Connection cnn = new ConnectJDBC().getConnection();
             PreparedStatement pst = cnn.prepareStatement(
                     "SELECT p.*, pr.id AS pr_id, pr.name AS pr_name, pr.description AS pr_description, " +
                             "pr.discount_percent, pr.start_date, pr.end_date " +
                             "FROM Products p " +
                             "INNER JOIN Promotions pr ON p.promotion_id = pr.id " +
                             "LIMIT ? OFFSET ?")) {

            pst.setInt(1, recordsPerPage);
            pst.setInt(2, offset);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("id"),
                        rs.getInt("category_id"),
                        rs.getInt("promotion_id"),
                        rs.getString("name"),
                        rs.getString("code"),
                        rs.getInt("price"),
                        rs.getInt("quantity"),
                        rs.getString("thumbnail"),
                        rs.getString("description"),
                        rs.getString("created_at")
                );

                Promotions promotion = new Promotions(
                        rs.getInt("pr_id"),
                        rs.getString("pr_name"),
                        rs.getString("pr_description"),
                        rs.getDouble("discount_percent"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date")
                );
                p.setPromotion(promotion);

                productList.add(p);
            }

            // Đếm tổng số sản phẩm có khuyến mãi
            PreparedStatement countStmt = cnn.prepareStatement(
                    "SELECT COUNT(*) FROM Products p INNER JOIN Promotions pr ON p.promotion_id = pr.id");
            ResultSet countRs = countStmt.executeQuery();
            int totalRecords = 0;
            if (countRs.next()) {
                totalRecords = countRs.getInt(1);
            }

            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

            request.setAttribute("productList", productList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/Products/PromotionProductList.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi khi truy vấn CSDL!");
        }
    }
}
