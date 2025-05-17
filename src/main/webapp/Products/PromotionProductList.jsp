<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="nhom9.haui.Model.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách sản phẩm khuyến mãi</title>
    <link rel="stylesheet" href="Home.css">
</head>
<body>

    <nav class="navbar">
        <a href="Home.jsp">
            <img src="${pageContext.request.contextPath}/image/logo.jpg" alt="Logo">
        </a>
        <ul class="menu">
            <li><a href="${pageContext.request.contextPath}/ProductList">Trang chủ</a></li>
            <c:if test="${not empty sessionScope.admin}">
                <li class="dropdown"><a href="#">Sản phẩm</a>
                    <ul class="dropdown-content">
                        <li><a href="${pageContext.request.contextPath}/Products/ProductCatage">Danh sách sản phẩm</a></li>
                        <li><a href="${pageContext.request.contextPath}/Products/PromotionProductList">Danh sách khuyến mãi</a></li>
                    </ul>
                </li>
            </c:if>
            <li><a href="${pageContext.request.contextPath}/Products/OrderList">Đơn hàng</a></li>
            <li><a href="${pageContext.request.contextPath}/Contact.jsp">Liên hệ</a></li>
            <li class="search-form">
                <form action="${pageContext.request.contextPath}/ProductSearch" method="post">
                    <input type="text" name="product" placeholder="Search Products..." />
                    <button type="submit">Search</button>
                </form>
            </li>
            <li><a href="${pageContext.request.contextPath}/ProductCartList">
                <img src="${pageContext.request.contextPath}/image/iconCart.jpg" alt="Giỏ hàng">
            </a></li>
            <li class="bnt_logout"><a href="../index.jsp">Log Out</a></li>
            <li class="user">
                <a href="${pageContext.request.contextPath}/Products/PersonalProfile.jsp">
                    <img src="${pageContext.request.contextPath}/image/user.jpg" alt="User">
                </a>
            </li>
        </ul>
    </nav>

    <div style="position: relative; margin-top: 20px;">
        <h1 style="text-align: center; margin: 0;">Danh sách sản phẩm đang khuyến mãi</h1>
        <a href="${pageContext.request.contextPath}/Products/MinMaxPromotion"
	       style="position: absolute; right: 0; top: 50%; transform: translateY(-50%);
	              padding: 8px 16px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 4px;"
	       onclick="return confirm('Bạn muốn thêm sản phẩm mới?');">
	        + Thêm sản phẩm khuyến mãi
	    </a>
    </div>

    <table border="1" cellpadding="8" cellspacing="0" style="width: 100%; margin-top: 10px;">
    <thead>
    <tr>
        <th>ID</th>
        <th>Tên</th>
        <th>Mã sản phẩm</th>
        <th>Giá gốc</th>
        <th>Khuyến mãi (%)</th>
        <th>Giá sau KM</th>
        <th>Ảnh</th>
        <th>Mô tả</th>
        <th>Ngày tạo</th>
        <th>Số lượng</th>
        <th>Thao tác</th>
    </tr>
</thead>
<tbody>
    <c:choose>
        <c:when test="${not empty productList}">
            <c:forEach var="product" items="${productList}">
                <tr>
                    <td>${product.id}</td>
                    <td>${product.name}</td>
                    <td>${product.code}</td>
                    <td><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" /> VND</td>
                    <td>- ${product.promotion.discountPercent}%</td>
                    <td><fmt:formatNumber value="${product.price * (100 - product.promotion.discountPercent) / 100}" type="number" groupingUsed="true" /> VND</td>
                    <td style="text-align: center;">
                        <img src="${pageContext.request.contextPath}/image/${product.thumbnail}" width="80px" />
                    </td>
                    <td>${product.description}</td>
                    <td>${product.createdAt}</td>
                    <td>${product.quantity}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/Products/PromotionEditForm?id=${product.id}" 
                           onclick="return confirm('Bạn có chắc muốn sửa sản phẩm này không?');">Sửa</a>
                        <a href="${pageContext.request.contextPath}/Products/PromotionDelete?id=${product.id}" 
                           onclick="return confirm('Bạn có chắc muốn x óa sản phẩm này không?');">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <tr><td colspan="11" style="text-align: center;">Không có sản phẩm khuyến mãi.</td></tr>
        </c:otherwise>
    </c:choose>
</tbody>

</table>
    <!-- PHÂN TRANG -->
    <div style="margin-top: 20px; text-align: center;">
        <c:set var="currentPage" value="${currentPage != null ? currentPage : 1}" />
        <c:set var="totalPages" value="${totalPages != null ? totalPages : 1}" />

        <c:forEach begin="1" end="${totalPages}" var="i">
            <c:choose>
                <c:when test="${i == currentPage}">
                    <strong>${i}</strong>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/Products/PromotionProductList?page=${i}">${i}</a>
                </c:otherwise>
            </c:choose>
            <c:if test="${i < totalPages}"> | </c:if>
        </c:forEach>
    </div>

</body>
</html>
