<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="nhom9.haui.Model.Users" %>
<%@ page import="nhom9.haui.Model.Admin" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Personal Profile</title>
    <link rel="stylesheet" href="Home.css">
</head>
<body>
    <nav class="navbar">
        <a href="Home.jsp"><img src="${pageContext.request.contextPath}/image/logo.jpg" alt="Logo"></a>
        <ul class="menu">
            <li><a href="${pageContext.request.contextPath}/ProductList">Trang chủ</a></li>
            <% 
                Admin admin = (Admin) session.getAttribute("admin");
                if (admin != null) {
            %>
            <li class="dropdown"><a href="#">Sản phẩm</a>
                <ul class="dropdown-content">
                    <li><a href="${pageContext.request.contextPath}/Products/ProductCatage">Danh sách sản phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/Products/PromotionProductList">Danh sách khuyến mãi</a></li>
                </ul></li>
            <% 
                }
            %>
            <li><a href="${pageContext.request.contextPath}/Products/OrderList">Đơn hàng</a></li>
            <li><a href="Contact.jsp">Liên hệ</a></li>
            <li class="search-form">
                <form action="${pageContext.request.contextPath}/ProductSearch" method="post">
                    <input type="text" name="product" placeholder="Search Products..." />
                    <button type="submit">Search</button>
                </form>
            </li>
            <li><a href="${pageContext.request.contextPath}/ProductCartList"><img alt="" src="${pageContext.request.contextPath}/image/iconCart.jpg"></a>
            <li class="bnt_logout"><a href="../ProductLogOut">Log Out</a></li>
            <li class="user">
                <a href="${pageContext.request.contextPath}/Products/PersonalProfile">
                    <img alt="" src="${pageContext.request.contextPath}/image/user.jpg">
                </a>
            </li>
        </ul>
    </nav>

    <%
        Users user = (Users) session.getAttribute("user");  // Lấy user từ session
    %>

    <% if (admin != null) { %>
        <h2>Thông Tin Admin</h2>
        <p><strong>Tên: </strong><%= admin.getUsername() %></p>
        <p><strong>Email: </strong><%= admin.getEmail() %></p>
        <p><strong>Số điện thoại: </strong><%= admin.getPhone() %></p>
        <p><strong>Địa chỉ: </strong><%= admin.getAddress() %></p>

    <% } else if (user != null) { %>
        <h2>Thông Tin Người Dùng</h2>
        <p><strong>Tên: </strong><%= user.getUsername() %></p>
        <p><strong>Email: </strong><%= user.getEmail() %></p>
        <p><strong>Số điện thoại: </strong><%= user.getPhone() %></p>
        <p><strong>Địa chỉ: </strong><%= user.getAddress() %></p>

    <% } else { %>
        <h2>Thông tin người dùng không tồn tại!</h2>
    <% } %>
</body>
</html>
