-- 1. DATABASE CREATION
CREATE DATABASE sales_project_advanced;
USE sales_project_advanced;

-- 2. TABLE CREATION
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 3. CUSTOMER DATA INSERTION
INSERT INTO customers VALUES
(1, 'Naveen', 'Chennai', 'naveen@gmail.com'),
(2, 'Ram', 'Erode', 'ram@gmail.com'),
(3, 'Vijay', 'Coimbatore', 'vijay@gmail.com'),
(4, 'Priya', 'Salem', 'priya@gmail.com'),
(5, 'Arun', 'Chennai', 'arun@gmail.com'),
(6, 'Divya', 'Trichy', 'divya@gmail.com'),
(7, 'Karthik', 'Erode', 'karthik@gmail.com'),
(8, 'Sneha', 'Madurai', 'sneha@gmail.com'),
(9, 'Rahul', 'Coimbatore', 'rahul@gmail.com'),
(10, 'Meena', 'Salem', 'meena@gmail.com');

-- 4. PRODUCT DATA INSERTION
INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 50000),
(102, 'Mobile Phone', 'Electronics', 25000),
(103, 'Headphones', 'Electronics', 2000),
(104, 'Smart Watch', 'Electronics', 5000),
(105, 'T-Shirt', 'Fashion', 800),
(106, 'Jeans', 'Fashion', 1500),
(107, 'Shoes', 'Fashion', 2500),
(108, 'Office Chair', 'Furniture', 7000),
(109, 'Study Table', 'Furniture', 6000),
(110, 'Water Bottle', 'Accessories', 500);

-- 5. ORDER DATA INSERTION
INSERT INTO orders VALUES
(1001, 1, '2026-01-05'),(1002, 2, '2026-01-12'),(1003, 3, '2026-02-03'),
(1004, 4, '2026-02-15'),(1005, 5, '2026-03-08'),(1006, 6, '2026-03-19'),
(1007, 7, '2026-04-02'),(1008, 8, '2026-04-14'),(1009, 9, '2026-04-25'),
(1010, 10, '2026-05-05'),(1011, 1, '2026-05-16'),(1012, 2, '2026-05-22'),
(1013, 3, '2026-06-03'),(1014, 4, '2026-06-10'),(1015, 5, '2026-06-18'),
(1016, 6, '2026-06-25'),(1017, 7, '2026-02-20'),(1018, 8, '2026-03-25'),
(1019, 9, '2026-05-28'),(1020, 10, '2026-01-25');

-- 6. ORDER ITEMS DATA INSERTION
INSERT INTO order_items VALUES
(1,1001,101,1),(2,1001,103,2),(3,1002,102,1),(4,1002,110,2),(5,1003,104,1),(6,1003,105,2),
(7,1004,106,2),(8,1004,107,1),(9,1005,101,1),(10,1005,108,1),(11,1006,103,3),(12,1006,110,2),
(13,1007,102,1),(14,1007,104,1),(15,1008,105,3),(16,1008,106,2),(17,1009,108,1),(18,1009,109,1),
(19,1010,101,1),(20,1010,103,1),(21,1011,102,2),(22,1011,110,3),(23,1012,107,2),(24,1012,105,1),
(25,1013,104,2),(26,1013,103,1),(27,1014,109,1),(28,1014,108,2),(29,1015,101,1),(30,1015,106,2),
(31,1016,102,1),(32,1016,107,1),(33,1017,103,2),(34,1017,110,4),(35,1018,105,2),(36,1018,109,1),
(37,1019,101,1),(38,1019,104,2),(39,1020,106,3),(40,1020,110,2);

-- 7. DATA VERIFICATION
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;

-- 8. BASIC DATA SUMMARY
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_products FROM products;
SELECT COUNT(*) AS total_orders FROM orders;
SELECT COUNT(*) AS total_order_items FROM order_items;

-- 9. TOTAL REVENUE
SELECT SUM(p.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id;

-- 10. TOTAL NUMBER OF ORDERS
SELECT COUNT(*) AS total_orders FROM orders;

-- 11. AVERAGE ORDER VALUE
SELECT SUM(p.price * oi.quantity) / COUNT(DISTINCT o.order_id) AS average_order_value
FROM orders o JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id;

-- 12. REVENUE BY PRODUCT CATEGORY
SELECT p.category,SUM(p.price * oi.quantity) AS total_revenue
FROM products p JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category ORDER BY total_revenue DESC;

-- 13. CUSTOMER SPENDING ANALYSIS
SELECT c.customer_name,SUM(p.price * oi.quantity) AS total_spent
FROM products p JOIN order_items oi
ON p.product_id = oi.product_id
JOIN orders o ON o.order_id = oi.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- 14. CUSTOMERS WHO NEVER PLACED ORDERS
SELECT c.customer_name FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 15. NUMBER OF ORDERS PER CUSTOMER
SELECT c.customer_name,
COUNT(o.order_id) AS total_orders
FROM customers c LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC;

-- 16. MONTHLY REVENUE ANALYSIS
SELECT DATE_FORMAT(o.order_date, '%M %Y') AS order_month,
SUM(p.price * oi.quantity) AS revenue
FROM products p JOIN order_items oi
ON p.product_id = oi.product_id
JOIN orders o ON o.order_id = oi.order_id
GROUP BY order_month ORDER BY revenue DESC;

-- 17. REVENUE BY CITY
SELECT c.city,SUM(p.price * oi.quantity) AS sales_revenue
FROM products p JOIN order_items oi
ON p.product_id = oi.product_id
JOIN orders o ON o.order_id = oi.order_id
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.city ORDER BY sales_revenue DESC;

-- 18. BEST-SELLING PRODUCTS BY QUANTITY
SELECT p.product_name,SUM(oi.quantity) AS total_quantity
FROM products p JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity DESC;

-- 19. PRODUCT-WISE REVENUE ANALYSIS
SELECT p.product_name,
SUM(p.price * oi.quantity) AS total_revenue
FROM products p  JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- 20. TOP 5 CUSTOMERS BY SPENDING WITH RANK
SELECT ROW_NUMBER() OVER (ORDER BY spending DESC) AS rank_no,
customer_name,spending
FROM (
    SELECT c.customer_name,
	SUM(p.price * oi.quantity) AS spending
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name
) AS customer_spending
ORDER BY spending DESC
LIMIT 5;

-- 21. TOTAL UNITS SOLD BY PRODUCT CATEGORY
SELECT p.category,
SUM(quantity) AS total_units FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY category ORDER BY total_units DESC;
