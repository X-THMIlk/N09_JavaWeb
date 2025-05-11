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
import nhom9.haui.Model.Admin;
import nhom9.haui.Model.Product;
import nhom9.haui.Model.Users;

/**
 * Servlet implementation class ProductUser
 */
@WebServlet("/ProductUser")
public class ProductUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	List<Users> userList = new ArrayList<>();
    	List<Admin> adminList = new ArrayList<>();
    	try (Connection cnn = new ConnectJDBC().getConnection();
    	     PreparedStatement pst = cnn.prepareStatement("SELECT * FROM Users");
    	     ResultSet rs = pst.executeQuery()) {

    	    while (rs.next()) {
    	        Users p = new Users(
    	        	rs.getInt("id"),
    	            rs.getString("username"),
    	            rs.getString("email"),
    	            rs.getString("password"),
    	            rs.getString("phone"),
    	            rs.getString("address")
    	        );
    	        userList.add(p);
    	    }

            request.getSession().setAttribute("userList", userList);

            response.sendRedirect(request.getContextPath() + "/Products/Login.jsp");

    	} catch (SQLException e) {
    	    e.printStackTrace();
    	    response.getWriter().println("Lỗi khi truy vấn CSDL!");
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
