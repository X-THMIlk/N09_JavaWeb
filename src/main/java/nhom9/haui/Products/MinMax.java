package nhom9.haui.Products;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nhom9.haui.jdbc.ConnectJDBC;

/**
 * Servlet implementation class MinMax
 */
@WebServlet("/Products/MinMax")
public class MinMax extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MinMax() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try (Connection conn = new ConnectJDBC().getConnection()) {

			// Lấy min max của category_id
			try (PreparedStatement pstCategory = conn.prepareStatement("SELECT MIN(id) AS minId, MAX(id) AS maxId FROM Categories");
				 ResultSet rsCategory = pstCategory.executeQuery()) {

				if (rsCategory.next()) {
					request.getSession().setAttribute("minCategoryId", rsCategory.getInt("minId"));
					request.getSession().setAttribute("maxCategoryId", rsCategory.getInt("maxId"));
				}
			}

			// Lấy min max của promotion_id
			try (PreparedStatement pstPromotion = conn.prepareStatement("SELECT MIN(id) AS minId, MAX(id) AS maxId FROM Promotions");
				 ResultSet rsPromotion = pstPromotion.executeQuery()) {

				if (rsPromotion.next()) {
					request.getSession().setAttribute("minPromotionId", rsPromotion.getInt("minId"));
					request.getSession().setAttribute("maxPromotionId", rsPromotion.getInt("maxId"));
				}
			}
			response.sendRedirect(request.getContextPath() + "/Products/ProductAddForm.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
			response.getWriter().println("Lỗi khi truy vấn min/max từ CSDL!");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
