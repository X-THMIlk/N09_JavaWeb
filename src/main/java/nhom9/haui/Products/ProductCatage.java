// ProductCatage.java (Servlet)
package nhom9.haui.Products;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import nhom9.haui.Model.Product;
import nhom9.haui.Model.Promotions;
import nhom9.haui.jdbc.ConnectJDBC;

@WebServlet("/Products/ProductCatage")
public class ProductCatage extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int ITEMS_PER_PAGE = 5; // Number of products per page for pagination

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int currentPage = 1; // Default page is 1
        String pageParam = request.getParameter("page"); // Read page parameter from URL

        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam); // Parse the page number if valid
            } catch (NumberFormatException e) {
                currentPage = 1; // Fall back to first page if parsing fails
            }
        }

        int offset = (currentPage - 1) * ITEMS_PER_PAGE; // Calculate database offset for LIMIT clause

        ArrayList<Product> productList = new ArrayList<>();
        int totalItems = 0; // Will hold the total number of products

        try (Connection conn = new ConnectJDBC().getConnection()) {
            // Count total products to calculate pagination
            String countSql = "SELECT COUNT(*) FROM Products";
            try (Statement countStmt = conn.createStatement();
                 ResultSet rs = countStmt.executeQuery(countSql)) {
                if (rs.next()) {
                    totalItems = rs.getInt(1); // Read the count result
                }
            }

            // Calculate total pages based on totalItems and items per page
            int totalPages = (int) Math.ceil((double) totalItems / ITEMS_PER_PAGE);

            // Get paginated list of products using LIMIT and OFFSET
            String sql = "SELECT * FROM Products ORDER BY id DESC LIMIT ? OFFSET ?";
            try (PreparedStatement pst = conn.prepareStatement(sql)) {
                pst.setInt(1, ITEMS_PER_PAGE); // Number of products to fetch
                pst.setInt(2, offset);         // Offset to start fetching from

                ResultSet rs = pst.executeQuery();

                // Iterate through the result and build product list
                while (rs.next()) {
                    Product product = new Product(
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
                    // Optional: Load promotion details if needed later
                    productList.add(product);
                }
            }

            // Set attributes for JSP to use for rendering
            request.setAttribute("productList", productList);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

            // Forward the request to JSP for view rendering
            RequestDispatcher rd = request.getRequestDispatcher("/Products/ProductCatage.jsp");
            rd.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            // Show error message if something goes wrong with DB access
            response.getWriter().println("Lỗi khi truy xuất sản phẩm!");
        }
    }
}
