<%@ page import="java.util.List"%>
<%@ page import="nhom9.haui.Model.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa sản phẩm</title>
    <link rel="stylesheet" href="Home.css">
    <style>
        .form-container {
            width: 60%;
            margin: 30px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
        label {
            display: inline-block;
            width: 150px;
            margin-bottom: 10px;
        }
        input[type="text"], input[type="number"], textarea {
            width: 70%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<%@ include file="ProductCatage.jsp" %>

<%
    Product product = (Product) request.getAttribute("product");
    if (product == null) {
%>
    <p style="text-align:center; color:red;">Không tìm thấy sản phẩm để chỉnh sửa.</p>
<%
    } else {
%>

<div class="form-container">
    <h2>Sửa thông tin sản phẩm</h2>
    <form action="${pageContext.request.contextPath}/Products/ProductEdit" method="post">
        <!-- Ẩn ID để cập nhật -->
        <input type="hidden" name="id" value="<%= product.getId() %>">

        <label for="name">Tên sản phẩm:</label>
        <input type="text" name="name" id="name" value="<%= product.getName() %>" required><br>

        <label for="code">Mã sản phẩm:</label>
        <input type="text" name="code" id="code" value="<%= product.getCode() %>" required><br>

        <label for="description">Mô tả:</label>
        <textarea name="description" id="description" rows="4" required><%= product.getDescription() %></textarea><br>

        <label for="price">Giá:</label>
        <input type="number" name="price" id="price" value="<%= product.getPrice() %>" required><br>

        <label for="quantity">Số lượng:</label>
        <input type="number" name="quantity" id="quantity" value="<%= product.getQuantity() %>" required><br>

        <label for="thumbnail">Tên file ảnh:</label>
        <input type="text" name="thumbnail" id="thumbnail" value="<%= product.getThumbnail() %>" required><br>

        <label for="category_id">Mã danh mục:</label>
        <input type="number" name="category_id" id="category_id" value="<%= product.getCategoryId() %>" required><br>
        
        <label for="category_id">Mã Khuyến mãi:</label>
        <input type="number" name="idPromotion" id="idPromotion" value="<%= product.getPromotionId() %>" required><br>

        <div style="text-align: center;">
            <input type="submit" value="Cập nhật sản phẩm">
        </div>
    </form>
</div>

<%
    }
%>

</body>
</html>
