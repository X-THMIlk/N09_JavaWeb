package nhom9.haui.Model;

import java.util.Date;

public class Order {
    private int id;
    private String customerName;
    private String email;
    private String phone;
    private String address;
    private Date orderDate;
    private int total;
    private int paidAmount;
    private String name;
    private int quantity;
    private String status;

    // Constructor
    public Order(int id, String customerName, String email, String phone, String address, Date orderDate, int total, String status,  int paidAmount, String name, int quantity) {
        this.id = id;
        this.customerName = customerName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.orderDate = orderDate;
        this.total = total;
        this.status = status;
        this.paidAmount = paidAmount;
        this.name = name;
        this.quantity = quantity;
    }

    // Getter and Setter Methods
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(int paidAmount) {
        this.paidAmount = paidAmount;
    }

    public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
    public String toString() {
        return "Order [id=" + id + ", customerName=" + customerName + ", email=" + email + ", phone=" + phone
                + ", address=" + address + ", orderDate=" + orderDate + ", total=" + total + ", paidAmount="
                + paidAmount + "]";
    }
}
