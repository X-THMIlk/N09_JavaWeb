<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
    body {
        margin: 0;
        padding: 0;
        background-image: url('./image/imgHome.jpg');
        /* ảnh nền */
        background-size: cover;
        background-position: center;
        height: 100vh;
        display: flex;
        align-items: center;
        font-family: 'Times New Roman', Times, serif;
    }

    .navbar {
        width: 100%;
        background-color: rgba(0, 0, 0, 0.6);
        color: white;
        padding: 15px 30px;
        display: flex;
        align-items: center;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1000;
    }
    
    .navbar img {
        margin-right: 20%;
        width: 50px;
        font-weight: bold;
    }   

    .navbar ul{
        margin-bottom: 20px;
        list-style: none;
        width: 60%;
    }
    .navbar li{
        text-decoration: none;
        display: inline-block;
        margin-right: 5%;
    }

    .navbar a{
        font-size: 25px;
        text-decoration: none;
        color: white;
        transition: color 0.3s red;
    }
    .navbar a:hover{
        color: red;
    }
    .button-container {
        margin-left: 10%;
        text-align: center;
        background-color: rgba(114, 91, 91, 0.8);
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    }

    .button-container h1 {
        margin-bottom: 30px;
        color: #333;
    }

    .button {
        display: inline-block;
        margin: 10px;
        padding: 15px 30px;
        font-size: 16px;
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .button:hover {
        background-color: #b30030;
    }
</style>

<script>
    function confirmAndRedirect() {
        if (confirm("Chuyển đến trang Đăng ký?")) {
            window.location.href = '${pageContext.request.contextPath}/Products/Register.jsp';
        }
    }
</script>

<body>
    <nav class="navbar">
        <a href="index.html"><img src="./image/logo.jpg" alt=""></a>
        <ul class="menu">
          <li><a href="${pageContext.request.contextPath}/ProductList">Trang chủ</a></li>
          <li><a href="#">Sản phẩm</a></li>
          <li><a href="#">Liên hệ</a></li>
        </ul>
    </nav>

    <div class="button-container">
        <button class="button" onclick="confirmAndRedirect()">Đăng ký</button>
        <!-- Dùng JavaScript để chuyển trang -->
        <button class="button" onclick="window.location.href='${pageContext.request.contextPath}/Products/Login.jsp';">Đăng nhập</button>
    </div>
</body>

</html>
