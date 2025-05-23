<%@ page import="java.util.List"%>
<%@ page import="nhom9.haui.Model.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ</title>
<link rel="stylesheet" href="Home.css">
</head>
<body>
	<nav class="navbar">
		<a href="Home.jsp"><img
			src="${pageContext.request.contextPath}/image/logo.jpg" alt="Logo"></a>
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
				</ul>
			</li>
			<%
			}
			%>
			<li><a href="${pageContext.request.contextPath}/Products/OrderList">Đơn hàng</a></li>
			<li><a href="Contact.jsp">Liên hệ</a></li>
			<li class="search-form">
				<form action="${pageContext.request.contextPath}/ProductSearch"
					method="post">
					<input type="text" name="product" placeholder="Search Products..." />
					<button type="submit">Search</button>
				</form>
			</li>
			<li><a href="${pageContext.request.contextPath}/ProductCartList"><img
					alt="" src="${pageContext.request.contextPath}/image/iconCart.jpg"></a>
			<li class="bnt_logout"><a href="../ProductLogOut">Log Out</a></li>
			<li class="user">
			    <a href="${pageContext.request.contextPath}/Products/PersonalProfile.jsp">
			        <img alt="" src="${pageContext.request.contextPath}/image/user.jpg">
			    </a>
			</li>
		</ul>
	</nav>

	<h1>Bóng</h1>
	<div class="filter-buttons">
		<a href="Home.jsp?category=1">Bóng đá</a> <a
			href="Home.jsp?category=2">Bóng chuyền</a> <a
			href="Home.jsp?category=3">Bóng rổ</a> <a href="Home.jsp?category=4">Bóng
			futsal</a>
	</div>

	<!-- Danh sách sản phẩm -->
	<div class="content">
		<%
		List<Product> productList = (List<Product>) session.getAttribute("productList");
		String categoryParam = request.getParameter("category");
		int selectedCategory = (categoryParam != null) ? Integer.parseInt(categoryParam) : 1;

		String shoeCategoryParam = request.getParameter("shoeCategory");
		int selectedShoeCategory = (shoeCategoryParam != null) ? Integer.parseInt(shoeCategoryParam) : 5;

		if (productList != null) {
			for (Product product : productList) {
				if (product.getCategoryId() == selectedCategory) {
		%>
		<div class="item">
			<div class="image-container">
				<a href="${pageContext.request.contextPath}/Products/ProductDetail?id=<%=product.getId()%>"> <img
					src="${pageContext.request.contextPath}/image/<%= product.getThumbnail() %>"
					alt="">
				</a>
				<%
				if (product.getPromotion() != null && product.getPromotion().getDiscountPercent() > 0) {
				%>
				<div class="discount-badge">
					-<%=product.getPromotion().getDiscountPercent()%>%
				</div>
				<%
				}
				%>
			</div>
			<a href="${pageContext.request.contextPath}/Products/ProductDetail?id=<%=product.getId()%>"><%=product.getName()%></a> 
			<p><%=String.format("%,d", product.getPrice())%>
				VND
			</p>
		</div>

		<%
		}
		}
		} else {
		%>
		<p>Không có sản phẩm để hiển thị.</p>
		<%
		}
		%>
	</div>

	<h1 class="football">Giày Thể Thao</h1>
	<div class="filter1-buttons">
		<a href="Home.jsp?shoeCategory=5">Giày pickleball</a> <a
			href="Home.jsp?shoeCategory=6">Giày đá bóng</a> <a
			href="Home.jsp?shoeCategory=7">Giày cầu lông</a>
	</div>
	<div class="content">
		<%
		if (productList != null) {
			for (Product product : productList) {
				if (product.getCategoryId() == selectedShoeCategory) {
		%>
		<div class="item">
			<div class="image-container">
				<a href="${pageContext.request.contextPath}/Products/ProductDetail?id=<%=product.getId()%>"> <img
					src="${pageContext.request.contextPath}/image/<%= product.getThumbnail() %>"
					alt="">
				</a>
				<%
				if (product.getPromotion() != null && product.getPromotion().getDiscountPercent() > 0) {
				%>
				<div class="discount-badge">
					-<%=product.getPromotion().getDiscountPercent()%>%
				</div>
				<%
				}
				%>
			</div>
			<a href="${pageContext.request.contextPath}/Products/ProductDetail?id=<%=product.getId()%>"><%=product.getName()%></a>
			<p><%=String.format("%,d", product.getPrice())%>
				VND
			</p>
		</div>
		<%
		}
		}
		} else {
		%>
		<p>Không có sản phẩm để hiển thị.</p>
		<%
		}
		%>
	</div>

	<h1>Thiết bị tập</h1>
	<div class="content">
		<%
		if (productList != null) {
			for (Product product : productList) {
				if (product.getCategoryId() == 8) {
		%>
		<div class="item">
			<div class="image-container">
				<a href="${pageContext.request.contextPath}/Products/ProductDetail?id=<%=product.getId()%>"> <img
					src="${pageContext.request.contextPath}/image/<%= product.getThumbnail() %>"
					alt="">
				</a>
				<%
				if (product.getPromotion() != null && product.getPromotion().getDiscountPercent() > 0) {
				%>
				<div class="discount-badge">
					-<%=product.getPromotion().getDiscountPercent()%>%
				</div>
				<%
				}
				%>
			</div>
			<a href="${pageContext.request.contextPath}/Products/ProductDetail?id=<%=product.getId()%>"><%=product.getName()%></a>
			<p><%=String.format("%,d", product.getPrice())%>
				VND
			</p>
		</div>
		<%
		}
		}
		} else {
		%>
		<p>Không có sản phẩm để hiển thị.</p>
		<%
		}
		%>
	</div>
	<!-- Liên hệ -->
	<div class="contact">
		<h2>GỌI MUA HÀNG (08:30 - 21:30)</h2>
		<p>
			<strong>Hotline:</strong> 1800 0021
		</p>
		<p>Tất cả các ngày trong tuần</p>

		<h3>Liên hệ về thông tin đơn hàng</h3>
		<p>
			<strong>Email:</strong> donglucshopvn@gmail.com
		</p>

		<h3>Liên hệ về chính sách đại lý, dự án</h3>
		<div class="icon-group">
			<img src="${pageContext.request.contextPath}/image/logo.jpg" alt="Logo" width="50px">
			<img src="${pageContext.request.contextPath}/image/icon1.jpg" alt="Icon1" width="50px">
			<img src="${pageContext.request.contextPath}/image/icon2.jpg" alt="Icon2" width="50px">
			<img src="${pageContext.request.contextPath}/image/icon3.jpg" alt="Icon3" width="50px">
			<img src="${pageContext.request.contextPath}/image/icon4.jpg" alt="Icon4" width="50px">
			<img src="${pageContext.request.contextPath}/image/icon5.jpg" alt="Icon5" width="50px">
		</div>
	</div>

</body>
</html>