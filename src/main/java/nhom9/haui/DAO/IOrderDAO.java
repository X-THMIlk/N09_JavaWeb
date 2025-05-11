package nhom9.haui.DAO;

import nhom9.haui.Model.Cart;
import nhom9.haui.Model.Order;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;

public interface IOrderDAO {

    /**
     * Tạo đơn hàng với mỗi sản phẩm trong danh sách được chọn.
     *
     * @param customerName tên khách hàng
     * @param email email khách
     * @param phone số điện thoại
     * @param address địa chỉ
     * @param cartList danh sách cart trong session
     * @param selectedIds danh sách id cart được chọn
     * @param orderTime thời điểm đặt hàng
     */
    void createOrderPerItem(String customerName, String email, String phone,
                            String address, List<Cart> cartList, String[] selectedIds,
                            LocalDateTime orderTime) throws SQLException;

    /**
     * Lấy toàn bộ danh sách đơn hàng (gồm thông tin sản phẩm).
     *
     * @return danh sách Order
     */
    List<Order> getAllOrders();
}
