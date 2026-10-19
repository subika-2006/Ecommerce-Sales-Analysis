# E-commerce Sales Analysis using SQL

## Project Overview
This project analyzes sample e-commerce sales data using MySQL to understand sales revenue, customer spending, product performance, and monthly revenue.

## Tools Used
- MySQL
- MySQL Workbench
- SQL

## Database Tables
- **customers:** Stores customer names and cities.
- **products:** Stores product names and prices.
- **orders:** Stores customer order details and dates.
- **order_items:** Stores products and quantities in each order.

## SQL Concepts Used
- INNER JOIN
- Aggregate functions: SUM()
- GROUP BY and ORDER BY
- LIMIT
- Date functions: YEAR() and MONTH()
- Window function: RANK()

## Business Questions Answered
1. What is the total sales revenue?
2. Which customers placed orders?
3. How many units of each product were sold?
4. Which product sold the highest quantity?
5. What is the monthly sales revenue?
6. How much did each customer spend?
7. How can products be ranked by quantity sold?

## Key Findings
- Total revenue: 84,000
- Best-selling product by quantity: Earphones (2 units)
- Naveen's total spending: 54,000
- Ram's total spending: 30,000

## How to Run
1. Install MySQL Server and MySQL Workbench.
2. Open `ecommerce_sales_analysis.sql` in MySQL Workbench.
3. Execute the database setup, table creation, and data insertion statements in order.
4. Run the analysis queries and review the results.

## Dataset
This project uses sample data created for learning and demonstration purposes.

## Author
Subika Balasubramaniam
