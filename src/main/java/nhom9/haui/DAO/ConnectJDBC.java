package nhom9.haui.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectJDBC {
    private String dbname = "SportShopDB";
    private String username = "root";
    private String password = "123abc";
    private String connURL = "jdbc:mysql://localhost:3306/" + dbname + "?useSSL=false&serverTimezone=UTC";

    public Connection getConnection() {
        try {
            // Đăng ký driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(connURL, username, password);
        } catch(Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Đảm bảo đóng kết nối sau khi sử dụng
    public void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();  // Đóng kết nối
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
