package nhom9.haui.DAO;

import java.util.List;
import nhom9.haui.Model.Cart;

public interface ICartDAO {
    boolean addProductToCart(int productId, String productName, int quantity, int price, String image, String username);
    List<Cart> getCartList(String username);
}
