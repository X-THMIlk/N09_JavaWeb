<%@ page import="java.util.List"%>
<%@ page import="nhom9.haui.Model.Cart"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="nhom9.haui.Model.Users" %>
<%@ page import="nhom9.haui.Model.Admin" %>
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
	rel="stylesheet">
<script>
function showOrderForm() {
    const checkboxes = document.querySelectorAll('input[name="selectedIds"]:checked');
    if (checkboxes.length === 0) {
        alert("Vui lòng chọn ít nhất một sản phẩm để đặt hàng.");
        return;
    }

    document.getElementById("cartList").style.display = "none";

    // Lấy danh sách ID sản phẩm đã chọn
    let selectedIds = [];
    checkboxes.forEach(checkbox => {
        selectedIds.push(checkbox.value);
    });

    console.log("Các id đã chọn:");
    selectedIds.forEach(id => {
        console.log(id);
    });

    // Tạo form đặt hàng động
    let orderForm = document.createElement('form');
    orderForm.method = "post";
    orderForm.action = "${pageContext.request.contextPath}/ProductOrderDetail";
    orderForm.onsubmit = function() { return validateForm(); };

    // Thêm các input ẩn chứa selectedIds vào form
    selectedIds.forEach(id => {
        const hiddenInput = document.createElement("input");
        hiddenInput.type = "hidden";
        hiddenInput.name = "selectedIds";
        hiddenInput.value = id;
        orderForm.appendChild(hiddenInput);
    });

    // Tạo các trường nhập thông tin giao hàng
    orderForm.innerHTML += `
        <div class="container mt-4">
            <h3 class="mt-4">Nhập thông tin giao hàng</h3>
            <div class="mb-3">
                <label for="phone" class="form-label">Số điện thoại</label>
                <input type="text" class="form-control" id="phone" name="phone" required>
            </div>
            <div class="mb-3">
                <label for="address" class="form-label">Địa chỉ giao hàng</label>
                <input type="text" class="form-control" id="address" name="address" required>
            </div>
            <div class="text-end">
                <button type="submit" class="btn btn-primary">Xác nhận đơn hàng</button>
            </div>
        </div>
    `;

    // Thêm form vào body để hiển thị và submit
    document.body.appendChild(orderForm);
}

    function validateForm() {
        const phone = document.getElementById("phone").value.trim();
        const address = document.getElementById("address").value.trim();

        // Kiểm tra số điện thoại
        const phoneRegex = /^[0-9]{9}$/;
        if (!phoneRegex.test(phone)) {
            alert("Số điện thoại phải gồm đúng 9 chữ số.");
            return false;
        }

        // Kiểm tra địa chỉ
        if (address.length <= 6) {
            alert("Địa chỉ phải có ít nhất 7 ký tự.");
            return false;
        }

        return true;
    }
    
    window.onload = function() {
        const form = document.getElementById("orderForm");
        if (form) {
            form.addEventListener("submit", function(event) {
                // Gọi hàm kiểm tra trước khi gửi form
                if (!checkSelectionBeforeSubmit(event)) {
                    event.preventDefault();  // Ngừng gửi form nếu kiểm tra không hợp lệ
                }
            });
        }
    };
    
    function checkSelectionBeforeSubmit(){
        event.preventDefault();  // Ngăn chặn form gửi ngay lập tức
        const checkboxes = document.querySelectorAll('input[name="selectedIds"]:checked');
        if (checkboxes.length === 0) {
            alert("Vui lòng chọn ít nhất một sản phẩm để đặt hàng.");
            return;
        }

        document.getElementById("cartList").style.display = "none";

        // Lấy danh sách ID sản phẩm đã chọn
        let selectedIds = [];
        checkboxes.forEach(checkbox => {
            selectedIds.push(checkbox.value);
        });

        console.log("Các id đã chọn:");
        selectedIds.forEach(id => {
            console.log(id);
        });

        // Tạo form đặt hàng động
        let orderForm = document.createElement('form');
        orderForm.method = "post";
        orderForm.action = "${pageContext.request.contextPath}/ProductOrderDetail";
        orderForm.onsubmit = function() { return validateForm(); };

        // Thêm các input ẩn chứa selectedIds vào form
        selectedIds.forEach(id => {
            const hiddenInput = document.createElement("input");
            hiddenInput.type = "hidden";
            hiddenInput.name = "selectedIds";
            hiddenInput.value = id;
            orderForm.appendChild(hiddenInput);
        });

        // Thêm form vào body để hiển thị và submit
        document.body.appendChild(orderForm);
        orderForm.submit();  // Submit form sau khi hoàn tất các thao tác
    }

</script>

</head>
<style>
.container td a {
	text-decoration: none;
}

.container form {
	margin-bottom: 20px;
}
</style>
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
					src="${pageContext.request.contextPath}/image/iconCart.jpg"></a></li>
			<li class="bnt_logout"><a href="../index.jsp">Log Out</a></li>
		</ul>
	</nav>

	<%
	List<Cart> cartList = (List<Cart>) session.getAttribute("cartList");
	if (cartList == null) {
		cartList = new java.util.ArrayList<>();
	}
	
    Users user = (Users) session.getAttribute("user");

    boolean hasPhoneAndAddress = false;

    if (user != null) {
        hasPhoneAndAddress = (user.getPhone() != null && !user.getPhone().isEmpty()) &&
                             (user.getAddress() != null && !user.getAddress().isEmpty());
    } else if (admin != null) {
        hasPhoneAndAddress = (admin.getPhone() != null && !admin.getPhone().isEmpty()) &&
                             (admin.getAddress() != null && !admin.getAddress().isEmpty());
    }
	%>

	<div id="cartList" class="container mt-4">
		<h2 class="mb-4">Danh sách đơn hàng</h2>

		<form action="ProductCart.jsp" method="post">
			<table class="table table-bordered table-striped">
				<thead class="table-dark">
					<tr>
						<th>Chọn</th>
						<th>Mã sản phẩm</th>
						<th>Tên sản phẩm</th>
						<th>Số lượng</th>
						<th>Giá</th>
						<th>Ảnh</th>
						<th>Hành động</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Cart p : cartList) {
					%>
					<tr>
						<td><input type="checkbox" name="selectedIds"
							value="<%=p.getId()%>"></td>
						<td><%=p.getProductId()%></td>
						<td><%=p.getProductName()%></td>
						<td><%=p.getQuantity()%></td>
						<td><%=p.getPrice()%> VNĐ</td>
						<td><img
							src="${pageContext.request.contextPath}/image/<%=p.getImage()%>"
							width="80"></td>
						<td><a
							href="${pageContext.request.contextPath}/ProductDeleteCart?id=<%=p.getId()%>">Xóa</a></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<div class="text-end">
				<% if (!hasPhoneAndAddress) { %>
					<button type="button" onclick="showOrderForm()"
						class="btn btn-success">Đặt hàng</button>
			    <% } else if (user != null || admin != null) { %>
			        <p>Thông tin giao hàng đã có sẵn. Bạn có thể tiến hành đặt hàng.</p>
			        <form id="orderForm" action="ProductOrderDetail" method="post">
			            <input type="hidden" name="phone" value="<%= user != null ? user.getPhone() : admin.getPhone() %>">
			            <input type="hidden" name="address" value="<%= user != null ? user.getAddress() : admin.getAddress() %>">
			            <button type="button" class="btn btn-primary" onclick="checkSelectionBeforeSubmit();">Xác nhận đơn hàng</button>
			        </form>
			    <% } %>
			</div>
		</form>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
