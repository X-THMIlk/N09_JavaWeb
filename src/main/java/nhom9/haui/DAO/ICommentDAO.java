package nhom9.haui.DAO;

import nhom9.haui.Model.Comments;

import java.util.List;

public interface ICommentDAO {
    // Phương thức thêm bình luận
    boolean addComment(String email, String content, String productId, int userId);

    // Phương thức lấy bình luận theo productId
    List<Comments> getCommentsByProductId(String productId);
}
