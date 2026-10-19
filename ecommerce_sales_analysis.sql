CREATE database sales_project;
USE sales_project;
CREATE TABLE customers(
customer_id INT PRIMARY KEY,
name VARCHAR(50),
city VARCHAR(50)
);
CREATE TABLE products(
product_id INT PRIMARY KEY,
product_name VARCHAR(50),
price DECIMAL(10,2)
);
CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE order_items(
order_item_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT,
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers values
(1,'Naveen','Chennai'),
(2,'Ram','Erode'),
(3,'Vijay','Trichy');
INSERT INTO products values
(100,'Laptop',50000),
(200,'Phone',30000),
(300,'Earphones',2000);
INSERT INTO orders values
(11,1,'2026-04-02'),
(12,2,'2026-04-12');
INSERT INTO order_items values
(4,11,100,1),
(5,11,300,2),
(6,12,200,1);

SELECT SUM(p.price * oi.quantity) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

SELECT c.name, o.order_id, o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

SELECT p.product_name, SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name;

SELECT p.product_name, SUM(oi.quantity) AS total
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total DESC
LIMIT 1;

SELECT  YEAR(o.order_date) AS year,MONTH(order_date) AS month,SUM(p.price * oi.quantity) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY YEAR(o.order_date),MONTH(order_date)
ORDER BY year, month;

SELECT c.name, SUM(p.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id,c.name
ORDER BY total_spent DESC;


SELECT p.product_name,SUM(oi.quantity) AS total,RANK() OVER (ORDER BY SUM(oi.quantity) DESC) AS rank_no
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name;


