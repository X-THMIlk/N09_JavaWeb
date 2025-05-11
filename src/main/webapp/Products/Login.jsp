<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng Nhập</title>
<link rel="stylesheet" href="login.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

<style>
    body {
        margin: 0;
        padding: 0;
        background-image: url('./image/imgHome.jpg');
        background-size: cover;
        background-position: center;
        height: 100vh;
        display: flex;
        align-items: center;
        font-family: 'Times New Roman', Times, serif;
    }
</style>

<script>
    function togglePassword() {
        const passwordInput = document.getElementById("password");
        const type = passwordInput.getAttribute("type") === "password" ? "text" : "password";
        passwordInput.setAttribute("type", type);
    }
</script>

<body>
    <div class="login-container">
        <div class="login-header">
            <h2>TÀI KHOẢN</h2>
            <span class="close-btn">&times;</span>
        </div>
        <form action="${pageContext.request.contextPath}/ProductLogin" method="post">
            <h3>ĐĂNG NHẬP</h3>

            <label for="username">Email</label>
            <input type="text" placeholder="Email" name="username">

            <label for="password">Password</label>
            <div style="position: relative;">
                <input type="password" id="password" name="password" placeholder="Password" style="padding-right: 40px;" />
                <span onclick="togglePassword()" 
                      style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer;">
                    <i class="fa-solid fa-eye" id="toggleIcon"></i>
                </span>
            </div>
			
            <button type="submit">ĐĂNG NHẬP</button>

        </form>
    </div>
</body>
</html>
