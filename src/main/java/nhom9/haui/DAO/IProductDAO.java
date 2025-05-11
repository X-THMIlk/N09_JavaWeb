package nhom9.haui.DAO;

import nhom9.haui.Model.Product;

import java.util.List;

public interface IProductDAO {

    /**
     * Lấy tất cả sản phẩm (có thể bao gồm khuyến mãi nếu có).
     */
    List<Product> getAllProducts();

    /**
     * Tìm kiếm sản phẩm theo từ khóa.
     * @param keyword từ khóa tìm kiếm
     * @return danh sách sản phẩm khớp
     */
    List<Product> searchProductsByKeyword(String keyword);

    /**
     * Xóa sản phẩm theo ID (bao gồm cả dữ liệu liên quan như comments, giỏ hàng, đơn hàng).
     * @param productId ID sản phẩm
     * @return true nếu xóa thành công
     */
    boolean deleteProductById(int productId);

    /**
     * Lấy thông tin chi tiết sản phẩm theo ID.
     * @param id ID sản phẩm
     * @return đối tượng Product
     */
    Product getProductById(int id);

    /**
     * Thêm sản phẩm mới.
     * @param product đối tượng sản phẩm cần thêm
     * @return true nếu thêm thành công
     */
    boolean addProduct(Product product);
}
