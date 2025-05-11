<%@ page import="java.util.List"%>
<%@ page import="nhom9.haui.Model.Product"%>
<%@ page import="nhom9.haui.Model.Comments"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ</title>
<link rel="stylesheet" href="ProductDetail.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT"
	crossorigin="anonymous">
</head>
<body>
	<nav class="navbarmenu">
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
					<li><a href="CategoryList.jsp">Danh mục sản phẩm</a></li>
				</ul></li>
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
	<%
	Product selectedProduct = (Product) session.getAttribute("product");
	List<Comments> commentList = (List<Comments>) session.getAttribute("commentList");
	%>
	<div class="container mt-4">
		<div class="row mb-4 border p-3 rounded shadow-sm">
			<div class="col-md-6">
				<%
				if (selectedProduct != null) {
				%>
				<img
					src="${pageContext.request.contextPath}/image/<%= selectedProduct.getThumbnail() %>"
					alt="Hình ảnh sản phẩm" class="img-fluid rounded">
				<%
				} else {
				%>
				<p>Không tìm thấy sản phẩm này.</p>
				<%
				}
				%>
			</div>
			<div class="col-md-4">
				<h4><%=selectedProduct.getName()%></h4>
				<p><%=selectedProduct.getDescription()%></p>
				<p>
					<strong>Giá:</strong><%=selectedProduct.getPrice()%>
					VND
				</p>
				<p>
					Số lượng hiện có:
					<%=selectedProduct.getQuantity()%></p>
				<div class="counter-container">
					<button onclick="decrease()">−</button>
					<div id="number" class="number-display">1</div>
					<button onclick="increase()">+</button>
				</div>
				<p>Mã giảm giá: 
				    <%
				        if (selectedProduct.getPromotion() != null && selectedProduct.getPromotion().getDiscountPercent() > 0) {
				    %>
				        <%= selectedProduct.getPromotion().getDiscountPercent() %>
				        <p> Mô tả: <%= selectedProduct.getPromotion().getDescription() %></p>
				    <%
				        } else {
				    %>
				        Không có <!-- Nếu không có mã giảm giá, hiển thị "Không có" -->
				    <%
				        }
				    %>
</p>
				<a href="#" onclick="addToCart()" class="btn btn-primary">Thêm
					vào giỏ</a>
			</div>
					<form action="${pageContext.request.contextPath}/Products/AddComment" method="post">
					    <input type="hidden" name="product_id" value="${product.id}" />
					    <div class="mt-3 d-flex">
					        <input type="text" name="comment" class="form-control w-75 me-2" placeholder="Nhập bình luận của bạn..." required />
					        <button type="submit" class="btn btn-success">Bình luận</button>
					    </div>
					</form>

				    <h5>Bình luận:</h5>
				    <%
				        if (commentList != null && !commentList.isEmpty()) {
				            for (Comments comment : commentList) {
				    %>
				        <div class="border rounded p-2 mb-2">
				            <strong><%= comment.getUser_name() %>:</strong>
				            <p><%= comment.getContent() %></p>
				            <hr>
				        </div>
				    <%
				            }
				        } else {
				    %>
				        <p>Chưa có bình luận nào.</p>
				    <%
				        }
				    %>
				</div>
		</div>
	</div>
	<div class="contact">
    <h2>GỌI MUA HÀNG (08:30 - 21:30)</h2>
    <p><strong>Hotline:</strong> 1800 0021</p>
    <p>Tất cả các ngày trong tuần</p>
    
    <h3>Liên hệ về thông tin đơn hàng</h3>
    <p><strong>Email:</strong> donglucshopvn@gmail.com</p>
    
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
	<script>
		let count = 1;

		function updateDisplay() {
			document.getElementById("number").innerText = count;
		}

		function increase() {
			if (count < <%=selectedProduct.getQuantity()%>
		) {
				count++;
				updateDisplay();
			}

		}

		function decrease() {
			if (count > 1) {
				count--;
				updateDisplay();
			}
		}

		function addToCart() {
		    const id = <%=selectedProduct.getId()%>;
		    <% if (selectedProduct.getPromotion() != null) { %>
	        let discountPercent = <%= selectedProduct.getPromotion().getDiscountPercent() %>;
	        if (discountPercent > 0) {
	            // Tính giá sau khi áp dụng giảm giá
	            price = <%= selectedProduct.getPrice() %> * (100-discountPercent) * count / 100;
	        } else {
	            // Giá không giảm giá
	            price = <%= selectedProduct.getPrice() %> * count;
	        }
	    <% } else { %>
	        // Nếu không có chương trình giảm giá
	        price = <%= selectedProduct.getPrice() %> * count;
	    <% } %>
		    const name = "<%=selectedProduct.getName()%>";
		    const thumbnail = "<%=selectedProduct.getThumbnail()%>";
		    
		    // Hiển thị thông báo
		    alert("Đã thêm '" + name + "' vào giỏ hàng!");
		    console.log("Gửi dữ liệu: id =", id, "price =", price, "name =", name, "thumbnail =", thumbnail, "count =", count);

		    // Chuyển hướng tới trang giỏ hàng với các tham số
		    window.location.href = "${pageContext.request.contextPath}/ProductCard?id=" + id + "&name=" + encodeURIComponent(name) + "&quantity=" + count + "&price=" + price + "&image=" + encodeURIComponent(thumbnail) +"&code="+ "<%=selectedProduct.getId()%>";
		}
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO"
		crossorigin="anonymous"></script>
</body>
</html>