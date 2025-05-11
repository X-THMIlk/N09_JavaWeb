package nhom9.haui.DAO;

import nhom9.haui.Model.Admin;
import nhom9.haui.Model.Users;

public interface ILoginDAO {
    Users loginUser(String email, String password);
    Admin loginAdmin(String email, String password);
}