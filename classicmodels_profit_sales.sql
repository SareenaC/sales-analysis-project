USE classicmodels;


/* 1. This query calculates annual key performance indicators (KPIs) which include total number of 
orders, total number of customers, total revenue, total profit and average order value. */
 
SELECT COUNT(DISTINCT od.orderNumber) AS total_orders,
COUNT(DISTINCT c.customerNumber) AS total_customers,
SUM(od.quantityOrdered * od.priceEach)  as total_revenue,
SUM((od.priceEach - p.buyPrice) * od.quantityOrdered) as total_profit,
ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT od.orderNumber), 2) as avg_order_value,
YEAR(o.orderDate) as year
FROM orderdetails od
JOIN orders o 
ON od.orderNumber = o.orderNumber
JOIN customers c
ON o.customerNumber = c.customerNumber
JOIN products p 
ON od.productCode = p.productCode
GROUP BY YEAR(o.orderDate);

-- 2. Total revenue and profit per month and year
SELECT SUM(od.quantityOrdered * od.priceEach)  as total_revenue, 
SUM((od.priceEach - p.buyPrice) * od.quantityOrdered) as total_profit,
YEAR(o.orderDate) as year_ordered,
MONTH (o.orderDate) as month_ordered
FROM orderdetails od
JOIN orders o 
ON od.orderNumber = o.orderNumber
JOIN products p 
ON od.productCode = p.productCode
GROUP BY YEAR(o.orderDate), MONTH (o.orderDate)
ORDER BY month_ordered ASC;

-- 3. Total sales and profit per country
SELECT SUM(od.quantityOrdered * od.priceEach) as total_sales, 
SUM((od.priceEach - p.buyPrice) * od.quantityOrdered) as total_profit,
TRIM(c.country) as country 
FROM customers c
JOIN orders o 
ON c.customerNumber = o.customerNumber
JOIN orderdetails od 
ON o.orderNumber = od.orderNumber
JOIN products p 
ON od.productCode = p.productCode
GROUP BY TRIM(c.country)
ORDER BY total_sales DESC;

-- 4. Monthly sales and cumulative sales by sales representative
WITH employee_sales_per_month as (
SELECT e.employeeNumber,
CONCAT(e.firstName, ' ', e.lastName) AS employee_name,
DATE_FORMAT(p.paymentDate, '%Y-%m') AS sales_month,
SUM(p.amount) AS sales
FROM employees e
JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p 
ON c.customerNumber = p.customerNumber
WHERE e.jobTitle = 'Sales Rep'
GROUP BY e.employeeNumber, e.firstName, e.lastName, sales_month
)
SELECT *,
SUM(sales) OVER (
PARTITION BY employeeNumber
ORDER BY sales_month
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS cumulative_sales
FROM employee_sales_per_month 
ORDER BY employeeNumber, sales_month;

/* 5. This query lists the top 5 employees ranked by total sales and includes key sales statistics:
 number of sales, total, minimum, maximum, and average sales. */

SELECT e.employeeNumber, 
CONCAT(e.firstName,' ', e.lastName) as employee_name, 
SUM(p.amount) as total_sales, min(p.amount) as min_sale, 
MAX(p.amount) as max_sale, 
ROUND(AVG(p.amount),2) as avg_sale, 
COUNT(*) as number_of_sales 
FROM employees e 
JOIN customers c 
ON e.employeeNumber = c.salesRepEmployeeNumber 
JOIN payments p 
ON c.customerNumber = p.customerNumber
WHERE e.jobTitle = 'Sales Rep' 
GROUP BY e.employeeNumber, e.firstName, e.lastName 
ORDER BY total_sales DESC
LIMIT 5;

-- 6. Customer segmentation by Spend level 
WITH spend as (
SELECT SUM(amount) as total_sales, 
customerName, 
CASE 
WHEN SUM(amount) > 100000 THEN 'high'
WHEN SUM(amount) BETWEEN 50000 AND 100000 THEN 'medium'
ELSE 'low'
END AS Spend_level
FROM customers c
JOIN payments p 
ON c.customerNumber = p.customerNumber
GROUP BY customerName
ORDER BY total_sales DESC
)
SELECT SUM(total_sales) as total_sales, 
COUNT(total_sales) as number_of_sales, 
spend_level
FROM spend
GROUP BY spend_level;

-- 7. Frequent customers with at least 5 orders
SELECT CustomerName
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY CustomerName
HAVING COUNT(o.orderNumber) >= 5;

-- 8. Total sales per product line
SELECT SUM(od.quantityOrdered * od.priceEach) as total_revenue, 
SUM((od.priceEach - p.buyPrice) * od.quantityOrdered) as total_profit,
productLine
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
GROUP BY productLine
ORDER BY total_revenue DESC;

-- 9. Bottom 10 Products by Revenue
SELECT SUM(od.quantityOrdered * od.priceEach) as total_revenue,
productName, 
productLine
FROM products p
JOIN orderdetails od
ON p.productCode = od.productCode
GROUP BY productName, productLine
ORDER BY total_revenue ASC
LIMIT 10;
/* The same query structure was used to calculate total profit by replacing the revenue calculation with: 
SUM((od.priceEach - p.buyPrice) * od.quantityOrdered) AS total_profit */

-- 10. top 3 highest-revenue products within each product line
WITH ranked_products as (
SELECT p.productName, 
p.productLine, 
SUM(od.quantityOrdered * od.priceEach)  as total_revenue,
RANK () OVER 
(PARTITION BY p.productLine 
ORDER BY SUM(od.quantityOrdered * od.priceEach) DESC) as product_rank
FROM products p
JOIN Orderdetails od
ON p.productCode = od.productCode
GROUP BY productName, productLine
) 
SELECT *
FROM ranked_products
WHERE product_rank <= 3;
/* This same query structure was used to calculate top 3 highest profit products within each product 
line using SUM((od.priceEach - p.buyPrice) * od.quantityOrdered) as total_profit */

-- 11. This query determines how many orders are arriving late to customers
SELECT COUNT(*) as late_delivery,
(SELECT COUNT(*) FROM orders) AS total_orders,
ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM orders), 2) AS late_percentage
FROM (
SELECT orderNumber, CASE WHEN ShippedDate <= RequiredDate THEN 'on time'
ELSE 'late' 
END AS delivery_date
FROM orders) as delivery_date
WHERE delivery_date = 'late';


