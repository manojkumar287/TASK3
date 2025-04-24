-- 1. Create the database
CREATE DATABASE ECOMMERCE_DATA;

-- 2. Use the database
USE ECOMMERCE_DATA;

-- 3. Create the Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Location VARCHAR(50)
);

-- 4. Insert data into the Customers table
INSERT INTO Customers (FirstName, LastName, Email, Location)
VALUES
    ('Manoj', 'Kumar', 'manoj.kumar@gmail.com', 'Hyderabad'),
    ('Vishal', 'Reddy', 'vishal.reddy@gmail.com', 'Bangalore'),
    ('Sriram', 'Sharma', 'sriram.sharma@gmail.com', 'Chennai'),
    ('Prachothan', 'Chowdary', 'prachothan.chowdary@gmail.com', 'Delhi'),
    ('Aravind', 'Rao', 'aravind.rao@gmail.com', 'Mumbai');

-- 5. Create the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- 6. Insert data into the Products table
INSERT INTO Products (ProductName, Category, Price)
VALUES
    ('Laptop', 'Electronics', 1200.00),
    ('T-Shirt', 'Clothing', 25.00),
    ('Smartphone', 'Electronics', 800.00),
    ('Book', 'Books', 15.00),
    ('Jeans', 'Clothing', 50.00);

-- 7. Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- 8. Insert data into the Orders table
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES
    (1, '2024-01-10', 1200.00),
    (2, '2024-01-15', 100.00),
    (3, '2024-02-01', 815.00),
    (1, '2024-02-10', 2400.00),
    (5, '2024-03-01', 50.00);

-- 9. Create the OrderDetails table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 10. Insert data into the OrderDetails table
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES
    (1, 1, 1, 1200.00),
    (2, 2, 4, 25.00),
    (3, 3, 1, 800.00),
    (3, 4, 1, 15.00),
    (4, 1, 2, 1200.00),
    (5, 5, 1, 50.00);

-- 11.  Create an index.
CREATE INDEX idx_customer_id ON Orders(CustomerID);
 SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;






-- 1. Select all customers from Hyderabad
SELECT * FROM Customers WHERE Location = 'Hyderabad';



-- 2. Select product names and prices, ordered by price in descending order
SELECT ProductName, Price FROM Products ORDER BY Price DESC;


-- 3. Group orders by customer and show the total amount for each customer
SELECT c.FirstName, c.LastName, SUM(o.TotalAmount) AS TotalOrderAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;


-- b. USING JOINS (INNER, LEFT, RIGHT)

-- 4. INNER JOIN: Get order details with customer names
SELECT o.OrderID, c.FirstName, c.LastName, o.OrderDate, o.TotalAmount
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID;


-- 5. LEFT JOIN: Get all customers and their orders (if any)
SELECT c.FirstName, c.LastName, o.OrderID, o.OrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 6. RIGHT JOIN: Get all orders and the customer details.
--   Note: In MySQL, RIGHT JOIN is used similarly to LEFT JOIN when the tables are in reversed order.
SELECT c.FirstName, c.LastName, o.OrderID, o.OrderDate
FROM Orders o
RIGHT JOIN Customers c ON o.CustomerID = c.CustomerID;


-- 7. Subquery to find products with a price greater than the average price
SELECT ProductName, Price
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

-- 8. Subquery to find customers who have placed orders
SELECT FirstName, LastName
FROM Customers
WHERE CustomerID IN (SELECT DISTINCT CustomerID FROM Orders);

-- d. Use aggregate functions (SUM, AVG)

-- 9. Calculate the total revenue from all orders
SELECT SUM(TotalAmount) AS TotalRevenue FROM Orders;

-- 10. Calculate the average order value
SELECT AVG(TotalAmount) AS AverageOrderValue FROM Orders;

-- e. Creating views for analysis

-- 11. View for customer order history
CREATE VIEW CustomerOrderHistory AS
SELECT c.FirstName, c.LastName, o.OrderID, o.OrderDate, o.TotalAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 12. View for product sales summary
CREATE VIEW ProductSalesSummary AS
SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantitySold, SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;

-- f. Optimizing queries with indexes

-- 13.  Query to show the use of the index created in the previous step.
--  Show orders for a specific customer.  This query will use the index on CustomerID
SELECT OrderID, OrderDate, TotalAmount
FROM Orders
WHERE CustomerID = 1;

-- 14.  Show details of orders and customer.
SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName
FROM Orders o JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Location = 'Hyderabad';
--  To optimize this query, you might consider adding an index on the Location column of the Customers table.
CREATE INDEX idx_customer_location ON Customers(Location);

