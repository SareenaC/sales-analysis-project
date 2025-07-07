/* Although the dataset appeared to be well-structured and clean, standard data quality checks were still performed to ensure integrity. 
This included checking for null or missing values in key columns, checking for duplicates, verifying data types and verifying that every order 
detail is linked to a valid product and all orders reference valid customers.
There were not any duplicates or any concerning null values detected.
*/

use classicmodels;

-- Check for inconsistent categories (example customers)
SELECT DISTINCT city
FROM customers
ORDER BY city;

-- query used to standardise country column, avoid trailing spaces which can cause false duplicates
UPDATE customers
SET country = TRIM(country);

-- query used to check whether each table had duplicates (example employees) No tables had duplicates
SELECT employeeNumber,
COUNT(employeeNumber) as count
FROM employees
GROUP BY employeeNumber
HAVING(COUNT > 1);

-- To check data types are correct (example products)
DESCRIBE products;

-- Query to check for null values present (example customers)
SELECT *
FROM customers
WHERE state IS NULL OR state IN ('', 'N/A');

-- To check for orderdetails with missing product references
SELECT od.productCode
FROM orderdetails od
LEFT JOIN products p ON od.productCode = p.productCode
WHERE p.productCode IS NULL;

-- To check for orders with missing customer references
SELECT o.customerNumber
FROM orders o
LEFT JOIN customers c ON o.customerNumber = c.customerNumber
WHERE c.customerNumber IS NULL;


