<%@ page import="java.util.List"%>
<%@ page import="nhom9.haui.Model.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm sản phẩm</title>
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

        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
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
            background-color: #28a745;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<%@ include file="ProductCatage.jsp" %>

<div class="form-container">
    <h2>Thêm sản phẩm mới</h2>
    <form action="${pageContext.request.contextPath}/Products/ProductAdd" method="post">
    
		<%
		    Integer minPromotionId = (Integer) session.getAttribute("minPromotionId");
		    Integer maxPromotionId = (Integer) session.getAttribute("maxPromotionId");
		%>
		
		<label for="promotion_id">
		    Mã khuyến mãi:
		    <% if (minPromotionId != null && maxPromotionId != null) { %>
		        (Từ <%= minPromotionId %> → <%= maxPromotionId %>)
		    <% } else { %>
		        (Không xác định được giới hạn)
		    <% } %>
		</label>
		<input type="number" name="idPromotion" id="idPromotion" required><br>
		    	
        <label for="name">Tên sản phẩm:</label>
        <input type="text" name="name" id="name" required><br>

        <label for="code">Mã sản phẩm:</label>
        <input type="text" name="code" id="code" required><br>

        <label for="description">Mô tả:</label>
        <textarea name="description" id="description" rows="4" required></textarea><br>

        <label for="price">Giá:</label>
        <input type="number" name="price" id="price" required><br>

        <label for="quantity">Số lượng:</label>
        <input type="number" name="quantity" id="quantity" value="0" required><br>

        <label for="thumbnail">Tên file ảnh (VD: ao1.jpg):</label>
        <input type="text" name="thumbnail" id="thumbnail" required><br>

        <%
    Integer minCategoryId = (Integer) session.getAttribute("minCategoryId");
    Integer maxCategoryId = (Integer) session.getAttribute("maxCategoryId");
%>

<label for="category_id">
    Mã danh mục:
    <% if (minCategoryId != null && maxCategoryId != null) { %>
        (Từ <%= minCategoryId %> → <%= maxCategoryId %>)
    <% } else { %>
        (Không xác định được giới hạn)
    <% } %>
</label>
        <input type="number" name="category_id" id="category_id" required><br>

        <div style="text-align: center;">
            <input type="submit" value="Thêm sản phẩm">
        </div>
        </form>
</div>

</body>
</html>
