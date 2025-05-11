<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="nhom9.haui.Model.Order" %>
<%@ page import="nhom9.haui.Model.Admin" %>
<%@ page import="nhom9.haui.Model.Users" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #999;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f0f0f0;
        }

        h2 {
            text-align: center;
        }
    </style>
    <link rel="stylesheet" href="Home.css">
</head>
<body>
	<nav class="navbar">
		<a href="Home.jsp"><img
			src="${pageContext.request.contextPath}/image/logo.jpg" alt="Logo"></a>
		<ul class="menu">
			<li><a href="${pageContext.request.contextPath}/ProductList">Trang chủ</a></li>
			<%
			Admin admin = (Admin) session.getAttribute("admin");
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
    <h2>Danh sách chi tiết đơn hàng</h2>

    <table>
        <tr>
            <th>Tên sản phẩm</th>
            <th>Số lượng</th>
            <th>Tên khách hàng</th>
            <th>Email</th>
            <th>SĐT</th>
            <th>Địa chỉ</th>
            <th>Ngày đặt</th>
            <th>Tổng tiền</th>
            <th>Đã thanh toán</th>
            <th>Hành động</th>
        </tr>

        <%
        Users user = (Users) session.getAttribute("user");
        List<Order> orderList = (List<Order>) session.getAttribute("orderList");
        	if(admin!= null){
            if (orderList != null) {
                for (Order order : orderList) {
        %>
				<tr>
				    <td><%= order.getName() %></td>
				    <td><%= order.getQuantity() %></td>
				    <td><%= order.getCustomerName() %></td>
				    <td><%= order.getEmail() %></td>
				    <td><%= order.getPhone() %></td>
				    <td><%= order.getAddress() %></td>
				    <td><%= order.getOrderDate() %></td>
				    <td><%= order.getTotal() %></td>
				    <td><%= order.getPaidAmount() %></td>
				    <td>
				        <form action="${pageContext.request.contextPath}/Products/ProductDeleteOrder" method="post" onsubmit="return confirm('Bạn có chắc muốn xóa đơn hàng này không?');">
				            <input type="hidden" name="orderId" value="<%= order.getId() %>"/>
				            <button type="submit">Hủy đơn</button>
				        </form>
				    </td>
				</tr>
        <%
                	}
            	}
        	}
        	else{
        		for(Order order: orderList){
        			if(user.getUsername().equals(order.getCustomerName())){
        %>
				<tr>
				    <td><%= order.getName() %></td>
				    <td><%= order.getQuantity() %></td>
				    <td><%= order.getCustomerName() %></td>
				    <td><%= order.getEmail() %></td>
				    <td><%= order.getPhone() %></td>
				    <td><%= order.getAddress() %></td>
				    <td><%= order.getOrderDate() %></td>
				    <td><%= order.getTotal() %></td>
				    <td><%= order.getPaidAmount() %></td>
				    <td>
				        <form action="${pageContext.request.contextPath}/Products/ProductDeleteOrder" method="post" onsubmit="return confirm('Bạn có chắc muốn xóa đơn hàng này không?');">
				            <input type="hidden" name="orderId" value="<%= order.getId() %>"/>
				            <button type="submit">Hủy đơn</button>
				        </form>
				    </td>
				</tr>
        <%
        			}
        		}
        	}
        %>
    </table>
</body>
</html>