package nhom9.haui.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import nhom9.haui.Model.Admin;
import nhom9.haui.Model.Users;

public class LoginDAO {

    public Users loginUser(String email, String password) {
        try (Connection cnn = new ConnectJDBC().getConnection()) {
            String sql = "SELECT * FROM Users WHERE email = ? AND password = ?";
            try (PreparedStatement pst = cnn.prepareStatement(sql)) {
                pst.setString(1, email);
                pst.setString(2, password);
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        return new Users(
                            rs.getInt("id"),
                            rs.getString("username"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("phone"),
                            rs.getString("address")
                        );
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Admin loginAdmin(String email, String password) {
        try (Connection cnn = new ConnectJDBC().getConnection()) {
            String sql = "SELECT * FROM Admins WHERE email = ? AND password = ?";
            try (PreparedStatement pst = cnn.prepareStatement(sql)) {
                pst.setString(1, email);
                pst.setString(2, password);
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        return new Admin(
                            rs.getInt("id"),
                            rs.getString("username"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("phone"),
                            rs.getString("address"),
                            rs.getInt("level")
                        );
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
