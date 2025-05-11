package nhom9.haui.Model;

public class Product {
	private int id;
	private int categoryId;
	private Integer promotionId;
	private String name;
	private String code;
	private int price;
	private int quantity;
	private String thumbnail;
	private String description;
	private String createdAt;
	private Promotions promotion;

	// Các phương thức getter và setter khác...

	public Promotions getPromotion() {
		return promotion;
	}
	
	public Product() {
	    // constructor rỗng
	}

	public void setPromotion(Promotions promotion) {
		this.promotion = promotion;
	}

	public Product(int id, int categoryId, Integer promotionId, String name, String code, int price, int quantity,
			String thumbnail, String description, String createdAt) {
		this.id = id;
		this.categoryId = categoryId;
		this.promotionId = promotionId;
		this.name = name;
		this.code = code;
		this.price = price;
		this.quantity = quantity;
		this.thumbnail = thumbnail;
		this.description = description;
		this.createdAt = createdAt;
	}

	// Getters và Setters
	public int getCategoryId() {
		return categoryId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public Integer getPromotionId() {
		return promotionId;
	}

	public void setPromotionId(Integer promotionId) {
		this.promotionId = promotionId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
}
