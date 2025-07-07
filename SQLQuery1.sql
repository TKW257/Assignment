USE [master]
GO


CREATE DATABASE [Assignment] 
GO

USE [Assignment]
GO
CREATE TABLE [User] (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    password_hash NVARCHAR(255) NOT NULL,
    address NVARCHAR(MAX),
    phone_number NVARCHAR(20),
    created_at DATETIME DEFAULT GETDATE()
);
CREATE TABLE [Categories] (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    category_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX)
);
CREATE TABLE [Products] (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX),
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    category_id INT,
    image_url NVARCHAR(255),
    FOREIGN KEY (category_id) REFERENCES [Categories](category_id)
);
CREATE TABLE [Order] (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    status NVARCHAR(50) DEFAULT 'pending',
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (user_id) REFERENCES [User](user_id)
);
CREATE TABLE [Order_detail] (
    order_detail_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES [Order](order_id),
    FOREIGN KEY (product_id) REFERENCES [Products](product_id)
);
CREATE TABLE [Payments] (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT NOT NULL,
    payment_date DATETIME DEFAULT GETDATE(),
    payment_method NVARCHAR(50),
    amount DECIMAL(10, 2) NOT NULL,
    payment_status NVARCHAR(50) DEFAULT 'unpaid',
    FOREIGN KEY (order_id) REFERENCES [Order](order_id)
);