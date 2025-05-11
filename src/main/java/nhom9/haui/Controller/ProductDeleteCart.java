package nhom9.haui.Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nhom9.haui.DAO.ConnectJDBC;

/**
 * Servlet implementation class ProductDeleteCart
 */
@WebServlet("/ProductDeleteCart")
public class ProductDeleteCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductDeleteCart() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Connection cnn = new ConnectJDBC().getConnection();

			String uid = request.getParameter("id");
			String deleteSql = "DELETE FROM Cart WHERE id = ?;";
			PreparedStatement pst = cnn.prepareStatement(deleteSql);
			pst.setInt(1, Integer.parseInt(uid));
			pst.executeUpdate();

			pst.close();
			cnn.close();
			// Quay lại trang chi tiết sản phẩm
			response.sendRedirect(request.getContextPath() + "/ProductCartList");

		} catch (SQLException e) {
			e.printStackTrace();
			response.getWriter().println("Lỗi khi xóa sản phẩm vào giỏ hàng!");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
