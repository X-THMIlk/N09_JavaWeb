<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="nhom9.haui.Model.Admin" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liên hệ</title>
    <link rel="stylesheet" href="Contact.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <!-- Giữ nguyên navbar -->
	<nav class="navbarmenu">
		<a href="Home.jsp"><img
			src="${pageContext.request.contextPath}/image/logo.jpg" alt="Logo"></a>
		<ul class="menu">
			<li><a href="Home.jsp">Trang chủ</a></li>
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
			    <a href="${pageContext.request.contextPath}/Products/PersonalProfile">
			        <img alt="" src="${pageContext.request.contextPath}/image/user.jpg">
			    </a>
			</li>
		</ul>
	</nav>

    <!-- Nội dung Liên hệ -->
    <div class="container mt-5">
        <h2 class="text-center mb-4">Liên hệ với chúng tôi</h2>
        <div class="row">
            <div class="col-md-6">
                <h4>Thông tin liên hệ</h4>
                <p><strong>Địa chỉ:</strong> Số 298 Cầu Diễn, Bắc Từ Liêm, Hà Nội</p>
                <p><strong>Email:</strong> donglucshopvn@gmail.com</p>
                <p><strong>Điện thoại:</strong> 1800 0021 (8:30 - 21:30)</p>
                <p><strong>Website:</strong> www.donglucshop.vn</p>
                <p><strong>Facebook:</strong> facebook.com/donglucshop</p>
            </div>
            <div class="col-md-6">
                <h4>Gửi phản hồi</h4>
                <form method="post" action="#">
                    <div class="mb-3">
                        <label for="name" class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" id="name" placeholder="Nhập họ tên">
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email của bạn</label>
                        <input type="email" class="form-control" id="email" placeholder="Nhập email">
                    </div>
                    <div class="mb-3">
                        <label for="message" class="form-label">Nội dung</label>
                        <textarea class="form-control" id="message" rows="4" placeholder="Nhập nội dung liên hệ"></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Gửi liên hệ</button>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
