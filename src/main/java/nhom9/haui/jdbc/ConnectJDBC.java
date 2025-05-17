package nhom9.haui.jdbc;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;


public class ConnectJDBC {
	private String dbname = "SportShopDB";
	private String username = "root";
	private String password = "123456";
	private String connURL = "jdbc:mysql://localhost:3306/" + dbname + "?useSSL=false&serverTimezone=UTC";
	
	public Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			return DriverManager.getConnection(connURL, username, password);
		} catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}