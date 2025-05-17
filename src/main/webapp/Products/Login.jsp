<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Form</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">
<link rel="stylesheet" href="login.css">
</head>
<style>
body{
	background-image: url('${pageContext.request.contextPath}/image/imgHome.jpg');
}
</style>
<body>
    <form action="${pageContext.request.contextPath}/ProductLogin" method="post">
        <h3>Login</h3>

        <label for="username">Email</label>
        <input type="text" placeholder="Email" name="username">

        <label for="password">Password</label>
        <input type="password" placeholder="Password" name="password">

        <button type="submit">Log In</button>
        <a href="${pageContext.request.contextPath}/Products/Register.jsp" class="register-link">Đăng ký</a>
        <p class="social-text">Login with a social media account</p>
        <div class="social-icons">
            <button class="social-icon fb"><i class="fa-brands fa-facebook"></i></button>
            <button class="social-icon tw"><i class="fa-brands fa-twitter"></i></button>
            <button class="social-icon in"><i class="fa-brands fa-instagram"></i></button>
        </div>
    </form>
</body>
</html>
