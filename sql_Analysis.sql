 -- Total number of customers
SELECT COUNT(*)AS total_customers FROM customers;

SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM customers;


-- Total number of sales transactions
SELECT COUNT(*) AS total_sales FROM sales;

-- Total Revenue
SELECT SUM(quantity*price) AS total_revenue FROM sales;

-- Revenue by Category 
SELECT category, SUM(quantity*price) AS revenue FROM sales
GROUP BY category
ORDER BY revenue DESC;

-- Revenue by shopping_mall 
SELECT shopping_mall, SUM(quantity*price) AS revenue FROM sales
GROUP BY shopping_mall
ORDER BY revenue DESC;

-- INNER JOIN
SELECT c.customer_id, c.gender, c.age, s.category, s.quantity, s.price, s.shopping_mall
FROM customers c
JOIN sales s
ON c.customer_id = s.customer_id;

-- Revenue by gender
SELECT c.gender, SUM(s.quantity * s.price) AS revenue
FROM customers c
JOIN sales s
ON c.customer_id = s.customer_id
GROUP BY c.gender;

-- Revenue by payment method
SELECT c.payment_method, SUM(s.quantity * s.price) AS revenue
FROM customers c
JOIN sales s
ON c.customer_id = s.customer_id
GROUP BY c.payment_method;

-- Average age of customers per category
SELECT s.category, AVG(c.age) AS avg_age
FROM customers c
JOIN sales s
ON c.customer_id = s.customer_id
GROUP BY s.category;

-- Above average revenue
SELECT * FROM sales
WHERE (quantity * price) >(SELECT AVG(quantity * price) FROM sales); 


-- Outlier customers detection : All customers roughly falls in the range of 15 to 70
SELECT * FROM customers WHERE age < 15;
SELECT * FROM customers WHERE age > 70;

-- Top 5 highest value transactions
SELECT invoice_no, quantity * price as total_amount
FROM sales
ORDER BY total_amount DESC
LIMIT 5;


-- CREATING VIEWS AND TESTING IT
CREATE VIEW customer_sales_summary AS
SELECT 
	c.customer_id, c.gender, c.age,
	s.invoice_no, s.category, s.quantity, s.price, (quantity * price) AS total_amount
FROM customers c
JOIN sales s
ON c.customer_id = s.customer_id;

SELECT * FROM customer_sales_summary;

-- CREATE index on customer_id

CREATE INDEX idx_cust_sales ON sales(customer_id);
CREATE INDEX idx_cust_customers ON customers(customer_id);

PRAGMA index_list('sales');
PRAGMA index_list('customers');


EXPLAIN QUERY PLAN
SELECT *
FROM customers c
JOIN sales s
ON c.customer_id = s.customer_id;