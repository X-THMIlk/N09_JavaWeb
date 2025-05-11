<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng ký</title>
<link rel="stylesheet" href="register.css">
</head>
<body>
    <div class="register-container">
        <h2>TÀI KHOẢN <span onclick="window.location.href='http://localhost:8080/Nhom9_JavaWeb/index.jsp'">X</span></h2>
        <h1>ĐĂNG KÝ</h1>

        <form action="${pageContext.request.contextPath}/Controller/RegisterServlet" method="post" onsubmit="return validateForm()">
            <label>@Username</label>
            <input type="text" name="userName" required placeholder="@Username">

            <label>Email</label>
            <input type="email" name="email" id="email" required placeholder="Email">

            <label>Password</label>
            <input type="password" name="password" id="password" required placeholder="Password">

            <label>Confirm Password</label>
            <input type="password" name="confirmPassword" id="confirmPassword" required placeholder="Confirm Password">
            <div id="error-message" class="error-message"></div>
            
            <div class="otp-container">
                <input type="text" name="otp" id="otp" class="otp-input" placeholder="Nhập mã OTP" maxlength="6" pattern="[0-9]{6}" required>
                <button type="button" id="send-otp" class="otp-button" onclick="sendOTP()">Gửi mã</button>
            </div>
            <div id="timer"></div>
            <button type="button" id="resend-otp" onclick="sendOTP()">Gửi lại OTP</button>

            <button type="submit" class="btn-submit">ĐĂNG KÝ</button>
        </form>
        <a href="http://localhost:8080/Nhom9_JavaWeb/index.jsp" class="back-link">Trở về</a>
    </div>

    <script>
        let timer;
        let timeLeft = 120;
        let otpSent = false;

        function startTimer() {
            document.getElementById("send-otp").disabled = true;
            document.getElementById("resend-otp").disabled = true;
            timer = setInterval(() => {
                timeLeft--;
                document.getElementById("timer").innerText = `Gửi lại sau: ${timeLeft}s`;
                if (timeLeft <= 0) {
                    clearInterval(timer);
                    document.getElementById("send-otp").disabled = false;
                    document.getElementById("resend-otp").disabled = false;
                    document.getElementById("timer").innerText = "";
                    document.getElementById("resend-otp").style.display = "block";
                    timeLeft = 120;
                }
            }, 1000);
        }

        function sendOTP() {
            const email = document.getElementById("email").value;
            if (!email) {
                alert("Vui lòng nhập Email trước khi gửi mã OTP!");
                return;
            }
            fetch('${pageContext.request.contextPath}/Controller/RegisterServlet?action=sendOtp&email=' + encodeURIComponent(email), {
                method: 'GET'
            })
            .then(response => response.text())
            .then(data => {
                if (data === "success") {
                    otpSent = true;
                    startTimer();
                    document.getElementById("resend-otp").style.display = "none";
                    alert("Mã OTP đã được gửi đến " + email);
                } else {
                    alert("Lỗi gửi OTP. Vui lòng thử lại!");
                }
            })
            .catch(error => console.error('Error:', error));
        }

        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            var otp = document.getElementById("otp").value;
            var errorMessage = document.getElementById("error-message");

            if (password !== confirmPassword) {
                errorMessage.innerText = "Mật khẩu xác nhận không khớp, vui lòng nhập lại!";
                return false;
            } else if (!otpSent || !otp) {
                errorMessage.innerText = "Vui lòng nhận và nhập mã OTP!";
                return false;
            } else {
                errorMessage.innerText = "";
                return true;
            }
        }
    </script>
</body>
</html>