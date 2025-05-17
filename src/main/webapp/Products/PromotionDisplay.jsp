<%@ page import="java.util.List"%>
<%@ page import="nhom9.haui.Model.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách sản phẩm khuyến mãi</title>
<link rel="stylesheet" href="Home.css">
</head>
<body>
    <nav class="navbar">
        <a href="Home.jsp"><img src="${pageContext.request.contextPath}/image/logo.jpg" alt="Logo"></a>
        <ul class="menu">
            <li><a href="${pageContext.request.contextPath}/ProductList">Trang chủ</a></li>
            <%
                nhom9.haui.Model.Admin admin = (nhom9.haui.Model.Admin) session.getAttribute("admin");
                if (admin != null) {
            %>
            <li class="dropdown"><a href="#">Sản phẩm</a>
                <ul class="dropdown-content">
                    <li><a href="${pageContext.request.contextPath}/Products/ProductCatage">Danh sách sản phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/Products/PromotionProductList">Danh sách khuyến mãi</a></li>
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
            <li><a href="${pageContext.request.contextPath}/ProductCartList"><img alt="" src="${pageContext.request.contextPath}/image/iconCart.jpg"></a></li>
            <li class="bnt_logout"><a href="../index.jsp">Log Out</a></li>
			<li class="user">
			    <a href="${pageContext.request.contextPath}/Products/PersonalProfile.jsp">
			        <img alt="" src="${pageContext.request.contextPath}/image/user.jpg">
			    </a>
			</li>
        </ul>
    </nav>

	<div style="position: relative; margin-top: 20px;">
	    <h1 style="text-align: center; margin: 0;">Danh sách sản phẩm đang khuyến mãi</h1>
	    <a href="${pageContext.request.contextPath}/Products/MinMax"
	       style="position: absolute; right: 0; top: 50%; transform: translateY(-50%);
	              padding: 8px 16px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 4px;"
	       onclick="return confirm('Bạn muốn thêm sản phẩm mới?');">
	        + Thêm sản phẩm
	    </a>
	</div>

    <table border="1" cellpadding="8" cellspacing="0" style="width: 100%; margin-top: 10px;">
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

        <%
            List<Product> productList = (List<Product>) request.getAttribute("productList");
            if (productList != null && !productList.isEmpty()) {
                for (Product product : productList) {
        %>
        <tr>
            <td><%= product.getId() %></td>
            <td><%= product.getName() %></td>
            <td><%= product.getCode() %></td>
            <td><%= product.getCategoryId() %></td>
            <td><%= (product.getPromotion() != null) ? product.getPromotion().getId() : "NULL" %></td>
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
            <td>
                <a href="${pageContext.request.contextPath}/Products/ProductEditForm?id=<%= product.getId() %>" onclick="return confirm('Bạn sửa sản phẩm này?');">Sửa</a>
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
            Integer currentPageAttr = (Integer) request.getAttribute("currentPage");
            Integer totalPagesAttr = (Integer) request.getAttribute("totalPages");

            int currentPage = (currentPageAttr != null) ? currentPageAttr : 1;
            int totalPages = (totalPagesAttr != null) ? totalPagesAttr : 1;

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
