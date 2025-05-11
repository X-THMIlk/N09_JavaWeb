package nhom9.haui.Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import nhom9.haui.DAO.ConnectJDBC;
import nhom9.haui.DAO.SendEmail;

@WebServlet("/Controller/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegisterServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("sendOtp".equals(action)) {
            String email = request.getParameter("email");
            if (email != null && !email.trim().isEmpty()) {
                String otp = generateOTP();
                HttpSession session = request.getSession();
                session.setAttribute("otp", otp);
                session.setAttribute("otpTime", System.currentTimeMillis() + 60000); // 60 giây hết hạn
                String emailContent = "<h2>Mã OTP của bạn</h2>" +
                                     "<p>Mã OTP của bạn là: <strong>" + otp + "</strong></p>" +
                                     "<p>Mã này sẽ hết hạn sau 60 giây. Vui lòng không chia sẻ mã này cho bất kỳ ai.</p>";
                if (SendEmail.sendEmail(email, "Mã OTP - SportShop", emailContent)) {
                    response.getWriter().write("success");
                } else {
                    response.getWriter().write("error");
                }
            } else {
                response.getWriter().write("error");
            }
            return;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userName = request.getParameter("userName").trim();
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String otp = request.getParameter("otp");

        // Kiểm tra mật khẩu khớp
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/Products/Register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra độ dài mật khẩu
        if (password.length() < 6) {
            request.setAttribute("errorMessage", "Mật khẩu phải có ít nhất 6 ký tự!");
            request.getRequestDispatcher("/Products/Register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra OTP
        String storedOtp = (String) session.getAttribute("otp");
        Long otpTime = (Long) session.getAttribute("otpTime");
        if (storedOtp == null || otpTime == null || !storedOtp.equals(otp) || System.currentTimeMillis() > otpTime) {
            request.setAttribute("errorMessage", "Mã OTP không hợp lệ hoặc đã hết hạn!");
            request.getRequestDispatcher("/Products/Register.jsp").forward(request, response);
            return;
        }

        try (Connection conn = new ConnectJDBC().getConnection()) {
            if (conn == null) {
                request.setAttribute("errorMessage", "Lỗi hệ thống! Không thể kết nối cơ sở dữ liệu.");
                request.getRequestDispatcher("/Products/Register.jsp").forward(request, response);
                return;
            }

            // Kiểm tra username hoặc email đã tồn tại
            String checkSql = "SELECT id FROM users WHERE username = ? OR email = ?";
            try (PreparedStatement ps = conn.prepareStatement(checkSql)) {
                ps.setString(1, userName);
                ps.setString(2, email);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        request.setAttribute("errorMessage", "Username hoặc Email đã tồn tại!");
                        request.getRequestDispatcher("/Products/Register.jsp").forward(request, response);
                        return;
                    }
                }
            }

            // Lưu tài khoản mới vào CSDL
            String insertSql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
                ps.setString(1, userName);
                ps.setString(2, email);
                ps.setString(3, password); // Lưu mật khẩu plaintext (nên mã hóa trong thực tế)
                int rows = ps.executeUpdate();
                if (rows == 0) {
                    request.setAttribute("errorMessage", "Đăng ký thất bại! Vui lòng thử lại.");
                    request.getRequestDispatcher("/Products/Register.jsp").forward(request, response);
                    return;
                }
            }

            // Xóa OTP sau khi sử dụng thành công
            session.removeAttribute("otp");
            session.removeAttribute("otpTime");

            // Chuyển sang trang đăng nhập
            response.sendRedirect(request.getContextPath() + "/Products/Login.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi cơ sở dữ liệu! Vui lòng thử lại.");
            request.getRequestDispatcher("/Products/Register.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống! Vui lòng thử lại.");
            request.getRequestDispatcher("/Products/Register.jsp").forward(request, response);
        }
    }

    private String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000); // Tạo số ngẫu nhiên 6 chữ số
        return String.valueOf(otp);
    }
}