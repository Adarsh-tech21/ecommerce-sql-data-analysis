-- ============================================================
-- E-COMMERCE SQL DATA ANALYSIS PROJECT
-- ============================================================
-- OVERVIEW
--
-- This project focuses on analyzing an e-commerce dataset
-- using SQL to extract meaningful business insights.
--
-- The dataset contains information about:
-- 1. Customers
-- 2. Products
-- 3. Transactions
-- 4. Customer Reviews
-- 5. Customer Sessions
--
-- The analysis covers customer behavior, sales performance,
-- product performance, customer engagement, conversion,
-- reviews, and customer churn.
--
-- The main objective of this project is to use SQL queries
-- to analyze the data, identify important patterns, and
-- generate insights that can support data-driven business
-- decision-making.
--
-- Tools Used:
-- MySQL
-- MySQL Workbench
--
-- Total Records: 236,000+
--
-- The project includes 30 SQL questions ranging from
-- basic data exploration to advanced analytical queries.
--

-- ============================================================

CREATE DATABASE IF NOT EXISTS ecommerce_sql_project;
USE ecommerce_sql_project;

-- ============================================================
-- TABLE 1: CUSTOMERS
-- ============================================================

CREATE TABLE IF NOT EXISTS customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    signup_date DATE,
    age INT,
    gender VARCHAR(50),
    country VARCHAR(50),
    segment VARCHAR(50),
    is_churned TINYINT,
    lifetime_value DECIMAL(12,2),
    email_opt_in TINYINT,
    has_app TINYINT
);

-- ============================================================
-- TABLE 2: PRODUCTS
-- ============================================================

CREATE TABLE IF NOT EXISTS products (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(150),
    category VARCHAR(100),
    brand VARCHAR(100),
    price DECIMAL(10,2),
    avg_rating DECIMAL(3,2),
    num_ratings INT,
    stock_quantity INT,
    discount_pct DECIMAL(5,2),
    is_featured TINYINT,
    weight_kg DECIMAL(8,2)
);

-- ============================================================
-- TABLE 3: REVIEWS
-- ============================================================

CREATE TABLE IF NOT EXISTS reviews (
    review_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    product_id VARCHAR(20),
    review_date DATE,
    rating INT,
    review_text TEXT,
    helpful_votes INT,
    verified_purchase TINYINT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================================
-- TABLE 4: SESSIONS
-- ============================================================

CREATE TABLE IF NOT EXISTS sessions (
    session_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    session_date DATETIME,
    device VARCHAR(50),
    channel VARCHAR(50),
    duration_seconds INT,
    pages_viewed INT,
    converted TINYINT,
    bounced TINYINT,
    cart_additions INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ============================================================
-- TABLE 5: TRANSACTIONS
-- ============================================================

CREATE TABLE IF NOT EXISTS transactions (
    transaction_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    product_id VARCHAR(20),
    transaction_date DATETIME,
    quantity INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(12,2),
    discount_applied DECIMAL(10,2),
    status VARCHAR(30),
    payment_method VARCHAR(50),
    shipping_cost DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================================
-- DATA IMPORT
-- IMPORTANT:
-- Update the file paths below according to your MySQL setup.
-- Example for Windows:
-- LOAD DATA LOCAL INFILE 'C:/Users/YourName/Downloads/customers.csv'
-- ============================================================

-- LOAD DATA LOCAL INFILE 'PATH/customers.csv'
-- INTO TABLE customers
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- IGNORE 1 ROWS;

-- LOAD DATA LOCAL INFILE 'PATH/products.csv'
-- INTO TABLE products
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- IGNORE 1 ROWS;

-- LOAD DATA LOCAL INFILE 'PATH/reviews.csv'
-- INTO TABLE reviews
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- IGNORE 1 ROWS;

-- LOAD DATA LOCAL INFILE 'PATH/sessions.csv'
-- INTO TABLE sessions
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- IGNORE 1 ROWS;

-- LOAD DATA LOCAL INFILE 'PATH/transactions.csv'
-- INTO TABLE transactions
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- IGNORE 1 ROWS;


-- ============================================================
-- 30 SQL ANALYSIS QUESTIONS
-- ============================================================

-- Q01. Find the total number of customers.
SELECT COUNT(*) AS total_customers
FROM customers;


-- Q02. Find the number of unique countries represented by customers.
SELECT COUNT(DISTINCT country) AS unique_countries
FROM customers;


-- Q03. Count customers in each customer segment.
SELECT segment,
       COUNT(*) AS customer_count
FROM customers
GROUP BY segment
ORDER BY customer_count DESC;


-- Q04. Find the average age of customers.
SELECT ROUND(AVG(age), 2) AS average_age
FROM customers;


-- Q05. Count churned and non-churned customers.
SELECT is_churned,
       COUNT(*) AS customer_count
FROM customers
GROUP BY is_churned;


-- Q06. Find total transaction amount for each transaction status.
SELECT status,
       COUNT(*) AS transaction_count,
       ROUND(SUM(total_amount), 2) AS total_amount
FROM transactions
GROUP BY status
ORDER BY total_amount DESC;


-- Q07. Find total completed transaction revenue for each month.
SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS month,
       ROUND(SUM(total_amount), 2) AS revenue
FROM transactions
WHERE status = 'completed'
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY month;


-- Q08. Find the top 10 products by completed transaction revenue.
SELECT p.product_id,
       p.product_name,
       ROUND(SUM(t.total_amount), 2) AS revenue
FROM transactions t
JOIN products p
    ON t.product_id = p.product_id
WHERE t.status = 'completed'
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC
LIMIT 10;


-- Q09. Find completed revenue and quantity sold for each product category.
SELECT p.category,
       SUM(t.quantity) AS quantity_sold,
       ROUND(SUM(t.total_amount), 2) AS revenue
FROM transactions t
JOIN products p
    ON t.product_id = p.product_id
WHERE t.status = 'completed'
GROUP BY p.category
ORDER BY revenue DESC;


-- Q10. Find completed transactions and revenue by payment method.
SELECT payment_method,
       COUNT(*) AS completed_transactions,
       ROUND(SUM(total_amount), 2) AS revenue
FROM transactions
WHERE status = 'completed'
GROUP BY payment_method
ORDER BY revenue DESC;


-- Q11. Find completed revenue by customer country.
SELECT c.country,
       ROUND(SUM(t.total_amount), 2) AS revenue
FROM transactions t
JOIN customers c
    ON t.customer_id = c.customer_id
WHERE t.status = 'completed'
GROUP BY c.country
ORDER BY revenue DESC;


-- Q12. Calculate the average completed transaction amount.
SELECT ROUND(AVG(total_amount), 2) AS average_order_value
FROM transactions
WHERE status = 'completed';


-- Q13. Compare completed revenue for transactions with and without a discount.
SELECT discount_applied,
       COUNT(*) AS transactions,
       ROUND(SUM(total_amount), 2) AS revenue
FROM transactions
WHERE status = 'completed'
GROUP BY discount_applied;


-- Q14. Find products whose stock quantity is below average stock.
SELECT product_id,
       product_name,
       stock_quantity
FROM products
WHERE stock_quantity < (
    SELECT AVG(stock_quantity)
    FROM products
)
ORDER BY stock_quantity;


-- Q15. Find products with rating >= 4.5 and at least 100 ratings.
SELECT product_id,
       product_name,
       avg_rating,
       num_ratings
FROM products
WHERE avg_rating >= 4.5
  AND num_ratings >= 100
ORDER BY avg_rating DESC, num_ratings DESC;


-- Q16. Find the top 10 customers by completed transaction revenue.
SELECT c.customer_id,
       ROUND(SUM(t.total_amount), 2) AS completed_spend
FROM transactions t
JOIN customers c
    ON t.customer_id = c.customer_id
WHERE t.status = 'completed'
GROUP BY c.customer_id
ORDER BY completed_spend DESC
LIMIT 10;


-- Q17. Find customers with more than 10 completed transactions.
SELECT customer_id,
       COUNT(*) AS completed_orders
FROM transactions
WHERE status = 'completed'
GROUP BY customer_id
HAVING COUNT(*) > 10
ORDER BY completed_orders DESC;


-- Q18. Find customers who purchased at least 2 different products.
SELECT customer_id,
       COUNT(DISTINCT product_id) AS different_products
FROM transactions
WHERE status = 'completed'
GROUP BY customer_id
HAVING COUNT(DISTINCT product_id) >= 2
ORDER BY different_products DESC;


-- Q19. Compare calculated completed spend with customer lifetime value.
WITH spend AS (
    SELECT customer_id,
           ROUND(SUM(total_amount), 2) AS calculated_spend
    FROM transactions
    WHERE status = 'completed'
    GROUP BY customer_id
)
SELECT c.customer_id,
       c.lifetime_value,
       COALESCE(s.calculated_spend, 0) AS calculated_spend,
       ROUND(
           c.lifetime_value - COALESCE(s.calculated_spend, 0),
           2
       ) AS difference
FROM customers c
LEFT JOIN spend s
    ON c.customer_id = s.customer_id
ORDER BY difference DESC;


-- Q20. Rank products by completed revenue using DENSE_RANK().
WITH product_revenue AS (
    SELECT p.product_id,
           p.product_name,
           SUM(t.total_amount) AS revenue
    FROM transactions t
    JOIN products p
        ON t.product_id = p.product_id
    WHERE t.status = 'completed'
    GROUP BY p.product_id, p.product_name
)
SELECT product_id,
       product_name,
       ROUND(revenue, 2) AS revenue,
       DENSE_RANK() OVER (
           ORDER BY revenue DESC
       ) AS revenue_rank
FROM product_revenue
ORDER BY revenue_rank;


-- Q21. Find the top 3 products by revenue within each category.
WITH product_revenue AS (
    SELECT p.category,
           p.product_id,
           p.product_name,
           SUM(t.total_amount) AS revenue,
           DENSE_RANK() OVER (
               PARTITION BY p.category
               ORDER BY SUM(t.total_amount) DESC
           ) AS category_rank
    FROM transactions t
    JOIN products p
        ON t.product_id = p.product_id
    WHERE t.status = 'completed'
    GROUP BY p.category, p.product_id, p.product_name
)
SELECT category,
       product_id,
       product_name,
       ROUND(revenue, 2) AS revenue,
       category_rank
FROM product_revenue
WHERE category_rank <= 3
ORDER BY category, category_rank;


-- Q22. Calculate month-over-month revenue growth using LAG().
WITH monthly AS (
    SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS month,
           SUM(total_amount) AS revenue
    FROM transactions
    WHERE status = 'completed'
    GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
),
monthly_with_previous AS (
    SELECT month,
           revenue,
           LAG(revenue) OVER (
               ORDER BY month
           ) AS previous_revenue
    FROM monthly
)
SELECT month,
       ROUND(revenue, 2) AS revenue,
       ROUND(previous_revenue, 2) AS previous_month_revenue,
       ROUND(
           (revenue - previous_revenue)
           / NULLIF(previous_revenue, 0) * 100,
           2
       ) AS mom_growth_pct
FROM monthly_with_previous
ORDER BY month;


-- Q23. Calculate each customer's running completed spend.
SELECT customer_id,
       transaction_date,
       transaction_id,
       total_amount,
       ROUND(
           SUM(total_amount) OVER (
               PARTITION BY customer_id
               ORDER BY transaction_date, transaction_id
               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
           ),
           2
       ) AS running_spend
FROM transactions
WHERE status = 'completed'
ORDER BY customer_id, transaction_date, transaction_id;


-- Q24. Calculate sessions, conversions and conversion rate by channel.
SELECT channel,
       COUNT(*) AS sessions,
       SUM(converted) AS conversions,
       ROUND(
           SUM(converted) / COUNT(*) * 100,
           2
       ) AS conversion_rate_pct
FROM sessions
GROUP BY channel
ORDER BY conversion_rate_pct DESC;


-- Q25. Analyze website performance by device.
SELECT device,
       COUNT(*) AS sessions,
       ROUND(AVG(duration_seconds), 2) AS avg_duration_seconds,
       ROUND(AVG(pages_viewed), 2) AS avg_pages_viewed,
       ROUND(AVG(converted) * 100, 2) AS conversion_rate_pct
FROM sessions
GROUP BY device
ORDER BY conversion_rate_pct DESC;


-- Q26. Calculate bounce rate for each channel.
SELECT channel,
       COUNT(*) AS sessions,
       SUM(bounced) AS bounced_sessions,
       ROUND(
           SUM(bounced) / COUNT(*) * 100,
           2
       ) AS bounce_rate_pct
FROM sessions
GROUP BY channel
ORDER BY bounce_rate_pct DESC;


-- Q27. Analyze product review quality.
SELECT p.product_id,
       p.product_name,
       COUNT(r.review_id) AS review_count,
       ROUND(AVG(r.rating), 2) AS average_review_rating,
       ROUND(
           AVG(r.verified_purchase) * 100,
           2
       ) AS verified_purchase_pct
FROM products p
LEFT JOIN reviews r
    ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
ORDER BY average_review_rating DESC,
         review_count DESC;


-- Q28. Analyze customer engagement by segment.
SELECT c.segment,
       COUNT(DISTINCT c.customer_id) AS customers,
       COUNT(s.session_id) AS sessions,
       ROUND(
           COUNT(s.session_id)
           / COUNT(DISTINCT c.customer_id),
           2
       ) AS avg_sessions_per_customer,
       ROUND(
           AVG(s.converted) * 100,
           2
       ) AS conversion_rate_pct
FROM customers c
LEFT JOIN sessions s
    ON c.customer_id = s.customer_id
GROUP BY c.segment
ORDER BY conversion_rate_pct DESC;


-- Q29. Find high-value churned customers.
SELECT customer_id,
       country,
       segment,
       lifetime_value
FROM customers
WHERE is_churned = 1
  AND lifetime_value > (
      SELECT AVG(lifetime_value)
      FROM customers
  )
ORDER BY lifetime_value DESC;


-- Q30. Build a final customer-level business analysis.
WITH customer_metrics AS (
    SELECT c.customer_id,
           c.country,
           c.segment,
           c.is_churned,
           c.lifetime_value,
           COUNT(t.transaction_id) AS order_count,
           COALESCE(SUM(t.total_amount), 0) AS completed_spend
    FROM customers c
    LEFT JOIN transactions t
        ON c.customer_id = t.customer_id
       AND t.status = 'completed'
    GROUP BY c.customer_id,
             c.country,
             c.segment,
             c.is_churned,
             c.lifetime_value
)
SELECT customer_id,
       country,
       segment,
       is_churned,
       lifetime_value,
       order_count,
       ROUND(completed_spend, 2) AS completed_spend
FROM customer_metrics
ORDER BY completed_spend DESC
LIMIT 10;

-- ============================================================
-- OVERALL INSIGHTS
-- ============================================================

-- 1. Customer analysis helps understand customer segments,
--    demographics, lifetime value, and churn behavior.

-- 2. Transaction analysis provides insights into revenue,
--    order performance, payment methods, discounts, and
--    customer spending patterns.

-- 3. Product and category analysis helps identify products
--    and categories with strong sales and customer ratings.

-- 4. Session analysis helps evaluate customer engagement
--    across different devices and marketing channels.

-- 5. Conversion and bounce-rate analysis helps identify
--    differences in customer behavior across channels
--    and devices.

-- 6. Review analysis provides insights into customer
--    satisfaction and product performance.

-- 7. Churn analysis helps identify high-value customers
--    who have stopped engaging with the business.

-- 8. Combining customer, transaction, product, review,
--    and session data provides a broader view of
--    e-commerce business performance.

-- ============================================================

-- ============================================================
-- CONCLUSION
-- ============================================================

-- This project demonstrates the use of SQL to analyze
-- an e-commerce dataset and extract meaningful business
-- insights.
--
-- The analysis covers customers, products, transactions,
-- reviews, sessions, sales performance, customer engagement,
-- conversion, and churn.
--
-- Through these analyses, SQL helps transform raw data
-- into useful information that can support data-driven
-- business decision-making.
--
-- This project also demonstrates practical use of SQL
-- concepts such as filtering, aggregation, grouping,
-- joins, subqueries, CTEs, and window functions.

-- ============================================================
-- END OF PROJECT
-- ============================================================
