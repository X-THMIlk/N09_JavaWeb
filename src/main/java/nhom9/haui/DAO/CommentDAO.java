package nhom9.haui.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import nhom9.haui.Model.Comments;

public class CommentDAO implements ICommentDAO{

    public boolean addComment(String email, String content, String productId, int userId) {
        boolean isSuccess = false;
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String commentDate = now.format(formatter);

        try (Connection cnn = new ConnectJDBC().getConnection()) {
            String insertSql = "INSERT INTO Comments (email, content, comment_date, product_id, user_id) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement pst = cnn.prepareStatement(insertSql)) {
                pst.setString(1, email);
                pst.setString(2, content);
                pst.setString(3, commentDate);
                pst.setInt	(4, Integer.parseInt(productId));
                pst.setInt(5, userId);
                
                int rowsAffected = pst.executeUpdate();
                if (rowsAffected > 0) {
                    isSuccess = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }
    
    public List<Comments> getCommentsByProductId(String productId) {
        List<Comments> commentList = new ArrayList<>();
        try (Connection cnn = new ConnectJDBC().getConnection()) {
            String sql = "SELECT c.*, u.username FROM Comments c JOIN Users u ON c.user_id = u.id WHERE c.product_id = ?";
            try (PreparedStatement pst = cnn.prepareStatement(sql)) {
                pst.setString(1, productId);
                try (ResultSet rs = pst.executeQuery()) {
                    while (rs.next()) {
                        Comments comment = new Comments(
                                rs.getInt("id"),
                                rs.getString("email"),
                                rs.getString("content"),
                                rs.getDate("comment_date"),
                                rs.getInt("product_id"),
                                rs.getInt("user_id"),
                                rs.getString("username")
                        );
                        commentList.add(comment);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commentList;
    }
}
