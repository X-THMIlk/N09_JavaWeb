<%@ page import="java.util.List"%>
<%@ page import="nhom9.haui.Model.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ</title>
<link rel="stylesheet" href="Home.css">
</head>
<body>
    <nav class="navbar">
        <a href="Home.jsp"><img src="${pageContext.request.contextPath}/image/logo.jpg" alt="Logo"></a>
        <ul class="menu">
            <li><a href="Home.jsp">Trang chủ</a></li>
            <%
                nhom9.haui.Model.Admin admin = (nhom9.haui.Model.Admin) session.getAttribute("admin");
                if (admin != null) {
            %>
            <li class="dropdown"><a href="#">Sản phẩm</a>
                <ul class="dropdown-content">
                    <li><a href="${pageContext.request.contextPath}/Products/ProductCatage">Danh sách sản phẩm</a></li>
                    <li><a href="CategoryList.jsp">Danh mục sản phẩm</a></li>
                </ul></li>
            <% } %>
            <li><a href="${pageContext.request.contextPath}/Products/OrderList">Đơn hàng</a></li>
            <li><a href="Contact.jsp">Liên hệ</a></li>
            <li class="search-form">
                <form action="${pageContext.request.contextPath}/ProductSearch" method="post">
                    <input type="text" name="product" placeholder="Search Products..." />
                    <button type="submit">Search</button>
                </form>
            </li>
            <li><a href="${pageContext.request.contextPath}/ProductCartList"><img alt="" src="${pageContext.request.contextPath}/image/iconCart.jpg"></a>
            <li class="bnt_logout"><a href="../index.jsp">Log Out</a></li>
        </ul>
    </nav>
<h1>Danh sách sản phẩm</h1>

<table border="1" cellpadding="8" cellspacing="0" style="width: 100%; margin-top: 10px;">
    <tr>
        <th>ID</th>
        <th>Danh mục</th>
        <th>Mã khuyến mãi</th>
        <th>Tên</th>
        <th>Mã sản phẩm</th>
        <th>Giá</th>
        <th>Số lượng</th>
        <th>Ảnh</th>
        <th>Mô tả</th>
        <th>Ngày tạo</th>
        <th>Khuyến mãi (%)</th>
        <th>Thao tác</th>
    </tr>

    <% 
        List<Product> productList = (List<Product>) request.getAttribute("productList");
        if (productList != null && !productList.isEmpty()) {
            for (Product product : productList) {
    %>
    <tr>
        <td><%= product.getId() %></td>
        <td><%= product.getCategoryId() %></td>
        <td><%= (product.getPromotion() != null) ? product.getPromotion().getId() : "NULL" %></td>
        <td><%= product.getName() %></td>
        <td><%= product.getCode() %></td>
        <td><%= String.format("%,d", product.getPrice()) %> VND</td>
        <td><%= product.getQuantity() %></td>
        <td style="text-align: center;">
            <img src="${pageContext.request.contextPath}/image/<%= product.getThumbnail() %>" width="80px" />
        </td>
        <td><%= product.getDescription() %></td>
        <td><%= product.getCreatedAt() %></td>
        <td>
            <%= (product.getPromotion() != null) ? ("-" + product.getPromotion().getDiscountPercent() + "%") : "Không có" %>
        </td>
        <td><a href="ProductEdit.jsp?id=<%= product.getId() %>">Thêm</a> |
            <a href="ProductEdit.jsp?id=<%= product.getId() %>">Sửa</a> |
            <a href="${pageContext.request.contextPath}/Products/ProductsDelete?id=<%= product.getId() %>" onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">Xóa</a>
        </td>
    </tr>
    <% 
            }
        } else {
    %>
    <tr><td colspan="12">Không có sản phẩm để hiển thị.</td></tr>
    <% 
        }
    %>
</table>

<div style="margin-top: 20px; text-align: center;">
    <%
        int currentPage = (Integer) request.getAttribute("currentPage");
        int totalPages = (Integer) request.getAttribute("totalPages");
        for (int i = 1; i <= totalPages; i++) {
            if (i == currentPage) {
    %>
                <strong><%= i %></strong>
    <% 
            } else {
    %>
                <a href="${pageContext.request.contextPath}/Products/ProductCatage?page=<%= i %>"><%= i %></a>
    <% 
            }
            if (i < totalPages) out.print(" | ");
        }
    %>
</div>

</body>
</html>
