use ASMquablibanhang
DROP TABLE IF EXISTS Customer, Employee, Product;
DROP TABLE Users;
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    UserName NVARCHAR(100) UNIQUE NOT NULL,
    Passwordd NVARCHAR(100) NOT NULL
);
-- Tạo bảng Customer
CREATE TABLE Customer (
    customerID INT PRIMARY KEY ,
    namee VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    addresss TEXT
);

-- Tạo bảng Employee
CREATE TABLE Employee (
    employeeID INT PRIMARY KEY ,
    namee VARCHAR(100) NOT NULL,
    position VARCHAR(50),
    phone VARCHAR(15),
    email VARCHAR(100) 
);

-- Tạo bảng Product
CREATE TABLE Product (
    productID INT PRIMARY KEY ,
    namee VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

-- Tạo bảng Orders
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    orderID INT PRIMARY KEY,
    customerID INT NOT NULL,
    employeeID INT NOT NULL,
    orderDate DATETIME,  -- ✅ Đúng kiểu để lưu ngày giờ trong SQL Server
    FOREIGN KEY (customerID) REFERENCES Customer(customerID) ON DELETE CASCADE,
    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID) ON DELETE CASCADE
);
ALTER TABLE Orders
ADD orderDate DATETIME;
EXEC sp_columns Orders;

-- Xóa bảng cũ nếu cần (chỉ nếu bạn đang làm bài thực hành hoặc không cần giữ dữ liệu cũ)
DROP TABLE IF EXISTS Orders;

-- Tạo lại bảng
CREATE TABLE Orders (
    orderID INT IDENTITY(1,1) PRIMARY KEY,
    customerID INT,
    employeeID INT,
    orderDate DATETIME
);

-- Tạo bảng OrderDetail
DROP TABLE IF EXISTS OrderDetail;
CREATE TABLE OrderDetail (
    orderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    orderID INT NOT NULL,
    productID INT NOT NULL,
    quantity INT NOT NULL,
    totalPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (orderID) REFERENCES Orders(orderID) ON DELETE CASCADE,
    FOREIGN KEY (productID) REFERENCES Product(productID) ON DELETE CASCADE
);
-- Tạo bảng Payment
DROP TABLE IF EXISTS Payment;

CREATE TABLE Payment (
    paymentID INT PRIMARY KEY,
    orderID INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    paymentDate DATETIME, -- dùng DATETIME thay vì TIMESTAMP nếu dùng SQL Server
    paymentMethod VARCHAR(50),
    FOREIGN KEY (orderID) REFERENCES Orders(orderID) ON DELETE CASCADE
);
INSERT INTO Customer (customerID, namee, email, phone, addresss) VALUES
(1, 'Pham Tien Dung', 'tiendungpham@example.com', '0987654321', 'Hồ Chí Minh'),
(2, 'Nguyen Chau Quoc Thinh', 'quocthinh@example.com', '0978123456', 'Bình Định'),
(3, 'Tran Trieu Phu', 'phu@example.com', '0965432187', 'Đà Nẵng');

INSERT INTO Employee (employeeID, namee, position, phone, email) VALUES
(1, 'Nguyen Thao Ly', 'Quản lý', '0901122334', 'thaoly@example.com'),
(2, 'Hoàng Thị Nga', 'Nhân viên bán hàng', '0912233445', 'hoangthingae@example.com'),
(3, 'Bùi Minh Thang', 'Nhân viên kho', ' \', 'buiminhthang@example.com');

INSERT INTO Product (productID, namee, price, stock) VALUES
(1, 'Laptop Dell', 15000000.00, 10),
(2, 'iPhone 13', 20000000.00, 15),
(3, 'Samsung Galaxy S21', 18000000.00, 20),
(4, 'Chuột Logitech', 500000.00, 50);
SELECT * FROM Payment;

INSERT INTO Orders (orderID, customerID, employeeID, orderDate) VALUES
(1, 1, 2, '2024-04-02 10:30:00'),
(2, 2, 1, '2024-04-02 14:45:00'),
(3, 3, 3, '2024-04-02 16:00:00');
SELECT * FROM Orders

INSERT INTO Orders(orderID, customerID, employeeID, orderDate) 
VALUES 
(1, 1, 2, DEFAULT),
(2, 2, 1, DEFAULT),
(3, 3, 3, DEFAULT);


INSERT INTO OrderDetail (orderID, productID, quantity, totalPrice)
VALUES (1, 1, 1, 15000000.00),
       (1, 4, 2, 1000000.00),
       (2, 2, 1, 20000000.00),
       (3, 3, 1, 18000000.00);
SELECT * FROM OrderDetail

INSERT INTO Payment (paymentID, orderID, amount, paymentDate, paymentMethod) 
VALUES
(1, 1, 500000, '2025-04-04 10:30:00', 'Credit Card'),
(2, 2, 1200000, '2025-04-04 12:15:00', 'Cash'),
(3, 3, 3500000, '2025-04-04 15:45:00', 'Bank Transfer');

SELECT * FROM Payment;
EXEC sp_columns Payment;

UPDATE Product 
SET price = 14000000 
WHERE productID = 1;

UPDATE Customer
SET phone = '0911223344'
WHERE customerID = 1;

DELETE FROM Customer
WHERE customerID = 2;

SELECT namee, email
FROM Customer;

UPDATE Employee
SET position = 'Supervisor'
WHERE employeeID = 2;

DELETE FROM Employee
WHERE employeeID = 1;

SELECT namee, position
FROM Employee;

UPDATE Product
SET stock = stock - 1
WHERE productID = 1;

DELETE FROM Product
WHERE stock = 0;

SELECT namee, price
FROM Product
WHERE price > 5000000;

UPDATE Orders
SET orderDate = CURRENT_TIMESTAMP
WHERE orderID = 1;

DELETE FROM Orders
WHERE orderID = 2;

SELECT orderID, orderDate
FROM Orders;

UPDATE OrderDetail
SET quantity = 3
WHERE orderDetailID = 1;

DELETE FROM OrderDetail
WHERE orderDetailID = 2;

SELECT orderID, productID, quantity, totalPrice
FROM OrderDetail;

UPDATE Payment
SET paymentMethod = 'Bank Transfer'
WHERE paymentID = 1;

DELETE FROM Payment
WHERE paymentID = 2;

SELECT orderID, amount, paymentDate
FROM Payment;

SELECT Orders.orderID, Customer.namee AS CustomerName, Employee.namee AS EmployeeName, Orders.orderDate
FROM Orders
JOIN Customer ON Orders.customerID = Customer.customerID
JOIN Employee ON Orders.employeeID = Employee.employeeID;

