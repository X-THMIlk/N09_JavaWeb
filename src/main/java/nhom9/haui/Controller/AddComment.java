package nhom9.haui.Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import nhom9.haui.DAO.CommentDAO;
import nhom9.haui.Model.Admin;
import nhom9.haui.Model.Users;

@WebServlet("/Products/AddComment")
public class AddComment extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddComment() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String content = request.getParameter("comment");
        String product_id = request.getParameter("product_id");
        Users user = (Users) request.getSession().getAttribute("user");
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        String email = "";
        int id;

        if (admin != null) {
            email = admin.getEmail();
            id = admin.getId();
        } else if (user != null) {
            email = user.getEmail();
            id = user.getId();
        } else {
            response.sendRedirect(request.getContextPath() + "/Login.jsp");
            return;
        }

        // Tạo đối tượng CommentDAO để thêm bình luận
        CommentDAO commentDAO = new CommentDAO();
        boolean isAdded = commentDAO.addComment(email, content, product_id, id);

        if (isAdded) {
            System.out.println("Đã thêm comment!");
            response.sendRedirect(request.getContextPath() + "/Products/ProductDetail?id=" + product_id);
        } else {
            response.getWriter().println("Lỗi khi thêm bình luận!");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
