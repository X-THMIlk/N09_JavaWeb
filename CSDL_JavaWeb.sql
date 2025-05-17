-- Create database
CREATE DATABASE SportShopDB;
USE SportShopDB;

-- Users table
CREATE TABLE Users (
    id INT PRIMARY KEY AUTO_INCREMENT,	
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100),
    password VARCHAR(100),
    phone VARCHAR(100),
    address VARCHAR(100)
);

-- Admins table
CREATE TABLE Admins (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE,
    email VARCHAR(100),
    password VARCHAR(100),
    phone VARCHAR(100),
    address VARCHAR(100),
    level INT -- 0 = staff, 1 = super admin
);

-- Product categories
CREATE TABLE Categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

-- Promotions table
CREATE TABLE Promotions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    description TEXT,
    discount_percent DECIMAL(5,2),
    start_date DATE,
    end_date DATE
);

-- Products table
CREATE TABLE Products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT,
    promotion_id INT, -- can be NULL
    name VARCHAR(100),
    code VARCHAR(50) UNIQUE,
    price INT,
	quantity INT DEFAULT 0,
    thumbnail VARCHAR(255),
    description LONGTEXT,
    created_at DATE,
    FOREIGN KEY (category_id) REFERENCES Categories(id),
    FOREIGN KEY (promotion_id) REFERENCES Promotions(id)
);
-- Shopping Cart
CREATE TABLE Cart (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    product_name VARCHAR(100),
    quantity INT,
    price INT,
    image VARCHAR(255),
    username VARCHAR(50),
    FOREIGN KEY (product_id) REFERENCES Products(id)
);

-- Orders table
CREATE TABLE Orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    order_date DATETIME,
    total INT,
    paid_amount INT,
    status ENUM('Chờ xác nhận', 'Đang giao', 'Hoàn thành', 'Đã hủy') DEFAULT 'Chờ xác nhận'
);
-- Order Details
CREATE TABLE OrderDetails (
    order_id INT,
    product_id INT,
    price INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    FOREIGN KEY (product_id) REFERENCES Products(id)
);

-- Comments
CREATE TABLE Comments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100),
    content VARCHAR(500),
    comment_date DATE,
    product_id INT,
    user_id INT,
    admin_id INT,
    FOREIGN KEY (product_id) REFERENCES Products(id),
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (admin_id) REFERENCES Admins(id)
);	

-- Insert sample users
INSERT INTO Users (username, email, password, phone, address) VALUES
('tranquang', 'trantuyenquang0407@gmail.com', 'pass123', '0987654321', '123 Nguyen Trai, Ha Noi'),
('janesmith', 'jane@gmail.com', 'password', '0123456789', '456 Le Loi, Ho Chi Minh'),
('johndoe', 'johndoe@example.com', '123456', '0981122334', '789 Tran Hung Dao, Da Nang'),
('nguyenvana', 'nguyenvana@gmail.com', 'abc123', '0912345678', '10 Le Thanh Tong, Ha Noi'),
('phamthib', 'phamthib@gmail.com', 'qwerty', '0933222111', '20 Tran Phu, Hai Phong'),
('levanc', 'levanc@gmail.com', 'letmein', '0977555888', '15 Phan Chu Trinh, Hue'),
('hoangthid', 'hoangthid@gmail.com', 'passw0rd', '0900111222', '8 Bach Dang, Da Nang'),
('tranvane', 'tranvane@gmail.com', '123abc', '0988777666', '100 Nguyen Van Cu, Can Tho'),
('nguyenvanb', 'nguyenvanb@gmail.com', 'hello123', '0966554433', '50 Le Lai, Da Nang'),
('lethic', 'lethic@gmail.com', 'letme1n', '0911777666', '25 Hai Ba Trung, Ha Noi'),
('phamh', 'phamh@gmail.com', 'phamh2025', '0933445566', '88 Tran Quang Khai, Hue'),
('dangtn', 'dangtn@gmail.com', 'dangtn456', '0922334455', '12 Le Duan, Ho Chi Minh');


-- Insert sample admins
INSERT INTO Admins (username, email, password, phone, address, level) VALUES
('admin1', 'admin1@example.com', '123456', '123456789', 'Ha Noi', 1),
('admin2', 'admin2@example.com', '123456', '123456789', 'Ha Noi', 0);

-- Insert product categories
INSERT INTO Categories (name) VALUES
('Football'),
('Volleyball'),
('Basketball'),
('Futsal'),
('Shoe'),
('SoccerShoe'),
('BadmintionShoe'),
('Device');

-- Insert promotions
INSERT INTO Promotions (name, description, discount_percent, start_date, end_date) VALUES
('Black Friday', 'Big discount for Black Friday', 20.00, '2025-11-25', '2025-11-29'),
('New Year Sale', 'Happy new year discount', 15.00, '2025-12-31', '2026-01-02');

-- Insert products
INSERT INTO Products (category_id, promotion_id, name, code, price,quantity,  thumbnail, description, created_at) VALUES
(1, 1, 'Football', 'P001', 20, 5,'football1.jpg', 'High quality, suitable for all ages.', '2025-04-20'),
(1, NULL, 'Bóng đá FIFA BASIC UHV 2.153 Terra', 'P002', 220000, 10, 'football1.jpg', 'Bóng đá chất lượng cao - mẫu 1.', '2025-04-01'),
(1, NULL, 'Bóng đá may số 2 da PVC Terra', 'P003', 240000, 12, 'football2.jpg', 'Bóng đá chất lượng cao - mẫu 2.', '2025-04-02'),
(1, 1, 'Bóng đá may số 3 da PVC Terra', 'P004', 260000, 8, 'football3.jpg', 'Bóng đá mẫu 3 đang được khuyến mãi.', '2025-04-03'),
(1, NULL, 'Bóng đá may số 4 da PVC Terra', 'P005', 280000, 5, 'football4.jpg', 'Bóng đá chất lượng cao - mẫu 4.', '2025-04-04'),
(1, 2, 'Bóng đá dán số 5 VICTORY UMG 3.147', 'P006', 300000, 6, 'football5.jpg', 'Mẫu bóng đá 5 giảm giá dịp năm mới.', '2025-04-05'),
(1, NULL, 'Bóng đá số 4 giải chuyên nghiệp', 'P007', 200000, 15, 'football6.jpg', 'Bóng đá chất lượng cao - mẫu 6.', '2025-04-06'),
(1, NULL, 'Bóng đá số 4 giải chuyên nghiệp', 'P008', 180000, 9, 'football7.jpg', 'Bóng đá chất lượng cao - mẫu 7.', '2025-04-07'),
(1, NULL, 'Bóng đá số 5 giải chuyên nghiệp', 'P009', 350000, 4, 'football8.jpg', 'Bóng đá chất lượng cao - mẫu 8.', '2025-04-08'),
(2, NULL, 'Bóng chuyền da PU tiêu chuẩn', 'P010', 250000, 8, 'volleyball1.jpg', 'Bóng chuyền chất lượng cao, độ bền tốt.', '2025-04-10'),
(2, 2, 'Bóng chuyền áo thi đấu chính hãng', 'P011', 300000, 6, 'volleyball2.jpg', 'Dành cho thi đấu cấp trường, cấp quận.', '2025-04-11'),
(2, NULL, 'Bóng chuyền luyện tập học sinh', 'P012', 180000, 10, 'volleyball3.jpg', 'Phù hợp luyện tập trong trường học.', '2025-04-12'),
(2, 1, 'Bóng chuyền da tổng hợp mẫu 2025', 'P013', 270000, 7, 'volleyball4.jpg', 'Thiết kế mới, nhẹ và bền.', '2025-04-13'),
(2, NULL, 'Bóng chuyền trẻ em', 'P014', 150000, 12, 'volleyball5.jpg', 'Kích thước và trọng lượng phù hợp trẻ nhỏ.', '2025-04-14'),
(2, NULL, 'Bóng chuyền cao su mềm', 'P015', 200000, 9, 'volleyball6.jpg', 'Dùng cho tập luyện tại nhà.', '2025-04-15'),
(2, 2, 'Bóng chuyền ngoài trời chống nước', 'P016', 320000, 5, 'volleyball7.jpg', 'Chống nước, bám tay tốt.', '2025-04-16'),
(2, NULL, 'Bóng chuyền cao cấp ProMaster', 'P017', 350000, 4, 'volleyball8.jpg', 'Dành cho vận động viên chuyên nghiệp.', '2025-04-17'),
(3, 1, 'Bóng rổ da cao cấp số 7', 'P018', 320000, 7, 'basketball1.jpg', 'Bóng rổ thi đấu chất lượng cao.', '2025-04-18'),
(3, NULL, 'Bóng rổ học sinh số 5', 'P019', 200000, 9, 'basketball2.jpg', 'Dành cho học sinh và người mới bắt đầu.', '2025-04-19'),
(3, NULL, 'Bóng rổ ngoài trời siêu bền', 'P020', 280000, 6, 'basketball3.jpg', 'Chất liệu da tổng hợp, chống mài mòn.', '2025-04-20'),
(3, 2, 'Bóng rổ chống trượt tay', 'P021', 300004, 5, 'basketball4.jpg', 'Thiết kế vân đặc biệt cho độ bám cao.', '2025-04-21'),
(3, NULL, 'Bóng rổ trẻ em mini', 'P022', 140000, 12, 'basketball5.jpg', 'Phù hợp với trẻ nhỏ và thiếu niên.', '2025-04-22'),
(3, NULL, 'Bóng rổ tập luyện cơ bản', 'P023', 220000, 11, 'basketball6.jpg', 'Dành cho tập luyện kỹ thuật.', '2025-04-23'),
(3, 1, 'Bóng rổ Pro Active số 6', 'P024', 300000, 6, 'basketball7.jpg', 'Cho thi đấu bán chuyên.', '2025-04-24'),
(3, NULL, 'Bóng rổ trong nhà da mịn', 'P025', 200006, 7, 'basketball8.jpg', 'Cảm giác mềm, kiểm soát tốt.', '2025-04-25'),
(4, 2, 'Bóng futsal chuẩn FIFA', 'P026', 290000, 8, 'futsal1.jpg', 'Bóng nhẹ, độ nảy thấp phù hợp thi đấu trong nhà.', '2025-04-26'),
(4, NULL, 'Bóng futsal luyện tập', 'P027', 220000, 10, 'futsal2.jpg', 'Dành cho luyện tập cá nhân và CLB.', '2025-04-27'),
(4, NULL, 'Bóng futsal da mềm', 'P028', 240000, 7, 'futsal3.jpg', 'Giúp kiểm soát bóng tốt hơn khi thi đấu.', '2025-04-28'),
(4, 1, 'Bóng futsal chuyên nghiệp Terra', 'P029', 330000, 6, 'futsal4.jpg', 'Dành cho giải chuyên nghiệp.', '2025-04-29'),
(4, NULL, 'Bóng futsal trẻ em', 'P030', 190000, 11, 'futsal5.jpg', 'Kích thước nhỏ, trọng lượng nhẹ.', '2025-04-30'),
(4, NULL, 'Bóng futsal tập sút cơ bản', 'P031', 210000, 9, 'futsal6.jpg', 'Dùng để luyện sút và kiểm soát.', '2025-05-01'),
(4, 2, 'Bóng futsal Pro Skill', 'P032', 270000, 5, 'futsal7.jpg', 'Tăng khả năng rê bóng, kiểm soát kỹ thuật.', '2025-05-02'),
(5, 2, 'Giày Pickleball Pro X1', 'P101', 450000, 15, 'Shoe1.jpg', 'Giày bền, nhẹ, phù hợp cho người chơi chuyên nghiệp.', '2025-04-10'),
(5, NULL, 'Giày Pickleball AirFlex', 'P102', 500000, 20, 'Shoe2.jpg', 'Thoải mái với công nghệ đệm khí.', '2025-04-12'),
(5, 1, 'Giày Pickleball SpeedGrip', 'P103', 470000, 10, 'Shoe3.jpg', 'Đế chống trượt cao cấp giúp di chuyển nhanh.', '2025-04-15'),
(5, NULL, 'Giày Pickleball Classic Fit', 'P104', 400000, 25, 'Shoe4.jpg', 'Phiên bản cơ bản, giá cả hợp lý.', '2025-04-18'),
(5, 2, 'Giày Pickleball Elite Pro', 'P105', 550000, 12, 'Shoe5.jpg', 'Thiết kế cao cấp, hỗ trợ cổ chân.', '2025-04-19'),
(5, NULL, 'Giày Pickleball LightMax', 'P106', 430000, 18, 'Shoe6.jpg', 'Cực nhẹ với lưới thoáng khí.', '2025-04-21'),
(5, 2, 'Giày Pickleball PowerDrive', 'P107', 520000, 14, 'Shoe7.jpg', 'Tối ưu sức mạnh và hỗ trợ thi đấu.', '2025-04-23'),
(6, 1, 'Giày đá bóng SpeedMaster', 'S001', 600000, 20, 'soccerShoe1.jpg', 'Tốc độ tối đa, thiết kế ôm chân.', '2025-04-05'),
(6, NULL, 'Giày đá bóng PowerKick', 'S002', 580000, 18, 'soccerShoe2.jpg', 'Tăng lực sút, hỗ trợ cổ chân.', '2025-04-07'),
(6, 2, 'Giày đá bóng AirStrike', 'S003', 620000, 15, 'soccerShoe3.jpg', 'Lớp đệm khí, thoáng khí và êm ái.', '2025-04-09'),
(6, NULL, 'Giày đá bóng Control Pro', 'S004', 550000, 22, 'soccerShoe4.jpg', 'Kiểm soát bóng vượt trội, thiết kế chắc chắn.', '2025-04-11'),
(6, 2, 'Giày đá bóng StormBlade', 'S005', 650000, 10, 'soccerShoe5.jpg', 'Chuyên nghiệp, phù hợp sân cỏ tự nhiên.', '2025-04-13'),
(6, NULL, 'Giày đá bóng EcoRunner', 'S006', 500000, 25, 'soccerShoe6.jpg', 'Thân thiện môi trường, giá cả hợp lý.', '2025-04-15'),
(6, 1, 'Giày đá bóng FlexFit', 'S007', 570000, 17, 'soccerShoe7.jpg', 'Linh hoạt, thích hợp cho mọi vị trí thi đấu.', '2025-04-17'),
(6, NULL, 'Giày đá bóng Classic Shot', 'S008', 480000, 30, 'soccerShoe1.jpg', 'Phong cách cổ điển, phù hợp luyện tập.', '2025-04-20'),
(7, 1, 'Giày cầu lông FeatherLight', 'B001', 420000, 20, 'badmintionShoe1.jpg', 'Siêu nhẹ, phù hợp thi đấu chuyên nghiệp.', '2025-04-06'),
(7, NULL, 'Giày cầu lông GripZone', 'B002', 450000, 18, 'badmintionShoe2.jpg', 'Đế chống trượt, hỗ trợ bước di chuyển nhanh.', '2025-04-08'),
(7, 2, 'Giày cầu lông AirStep', 'B003', 480000, 15, 'badmintionShoe3.jpg', 'Thoáng khí và đệm êm, giảm chấn tốt.', '2025-04-10'),
(7, NULL, 'Giày cầu lông ProFit', 'B004', 500000, 22, 'badmintionShoe4.jpg', 'Vừa vặn với form chân người châu Á.', '2025-04-12'),
(7, 2, 'Giày cầu lông SmashBoost', 'B005', 550000, 12, 'badmintionShoe5.jpg', 'Tăng lực nhảy và di chuyển ngang.', '2025-04-14'),
(7, NULL, 'Giày cầu lông ComfortLine', 'B006', 400000, 28, 'badmintionShoe6.jpg', 'Êm ái, thoải mái khi tập luyện dài hạn.', '2025-04-16'),
(7, 1, 'Giày cầu lông SpeedDrive', 'B007', 520000, 17, 'badmintionShoe7.jpg', 'Dành cho vận động viên yêu cầu tốc độ.', '2025-04-18'),
(7, NULL, 'Giày cầu lông BasicFit', 'B008', 380000, 35, 'badmintionShoe8.jpg', 'Mẫu cơ bản, phù hợp cho người mới chơi.', '2025-04-21'),
(8, 1, 'Máy chạy bộ điện DL-Pro X200', 'D001', 3500000, 5, 'device1.jpg', 'Máy chạy bộ đa năng, có màn hình LCD và chế độ luyện tập thông minh.', '2025-04-08'),
(8, NULL, 'Xe đạp tập thể dục DL-Bike Fit M1', 'D002', 2800000, 7, 'device2.jpg', 'Thiết kế nhỏ gọn, phù hợp với không gian gia đình.', '2025-04-10'),
(8, 2, 'Ghế tập tạ DL-Bench 500', 'D003', 1500000, 10, 'device3.jpg', 'Ghế tập tạ điều chỉnh được nhiều tư thế, khung thép chắc chắn.', '2025-04-12'),
(8, NULL, 'Máy kéo xô DL-LatPull PRO', 'D004', 3200000, 4, 'device4.jpg', 'Thiết bị hỗ trợ tập nhóm cơ lưng và tay hiệu quả.', '2025-04-14');

-- Insert cart items
INSERT INTO Cart (product_id, product_name, quantity, price, image, username) VALUES
(1, 'Football', 2, 20, 'football1.jpg', 'tranquang');

-- Insert orders
INSERT INTO Orders (customer_name, email, phone, address, order_date, total, paid_amount, status) VALUES
('Nguyen Van A', 'vana@gmail.com', '0912345678', '123 Le Loi, Ha Noi', '2025-05-10 10:00:00', 700000, 0, 'Chờ xác nhận'),
('Tran Thi B', 'thib@gmail.com', '0987654321', '456 Tran Hung Dao, Ha Noi', '2025-05-11 15:30:00', 1150000, 0, 'Chờ xác nhận'),
('Le Van C', 'levanc@gmail.com', '0909123456', '789 Kim Ma, Ha Noi', '2025-05-12 09:20:00', 200000, 0, 'Chờ xác nhận'),
('Pham Thi D', 'phamd@gmail.com', '0977123456', '321 Xuan Thuy, Ha Noi', '2025-05-13 18:45:00', 350000, 0, 'Chờ xác nhận');

-- Insert order details
INSERT INTO OrderDetails (order_id, product_id, price) VALUES
(1, 1, 20);

-- Insert comments
INSERT INTO Comments (email, content, comment_date, product_id, user_id, admin_id) VALUES
('trantuyenquang0407@gmail.com', 'Great product, I will buy more!', '2025-04-25', 1, 1, null),
('jane@example.com', 'Very comfortable and durable shoes.', '2025-04-26', 4, 2, null);

ALTER TABLE Products MODIFY name VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- Sample select queries
SELECT * FROM Users;
SELECT * FROM Admins;
SELECT * FROM Categories;		
SELECT * FROM Promotions;
SELECT * FROM Products;
SELECT * FROM Cart;	
SELECT * FROM Orders;	
SELECT * FROM OrderDetails;
SELECT * FROM Comments;

DROP TABLE IF EXISTS Comments;
-- Xóa bảng OrderDetails (có khóa ngoại đến Orders và Products)
DROP TABLE IF EXISTS OrderDetails;
-- Xóa bảng Orders (có khóa ngoại đến Users)
DROP TABLE IF EXISTS Orders;
-- Xóa bảng Cart (có khóa ngoại đến Products và Users)
DROP TABLE IF EXISTS Cart;
-- Xóa bảng Products (có khóa ngoại đến Categories và Promotions)
DROP TABLE IF EXISTS Products;
-- Xóa bảng Promotions
DROP TABLE IF EXISTS Promotions;
-- Xóa bảng Categories
DROP TABLE IF EXISTS Categories;
-- Xóa bảng Admins
DROP TABLE IF EXISTS Admins;
-- Xóa bảng Users
DROP TABLE IF EXISTS Users;

SHOW FULL COLUMNS FROM Products;
	
ALTER TABLE Products
MODIFY COLUMN promotion_id INT NULL;