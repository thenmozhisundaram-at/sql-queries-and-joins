-- SQL Queries and Joins Project
-- Sample database: Online Bookstore
-- Database engine: SQLite 3
--
-- Run:
--   sqlite3 bookstore.db < queries.sql
--
-- Each section begins with the question it answers.
-- Expected query results are also included in RESULTS.txt.

PRAGMA foreign_keys = ON;

-- 1. Create the sample database tables
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name TEXT NOT NULL,
    city TEXT NOT NULL
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT NOT NULL,
    category TEXT NOT NULL,
    price REAL NOT NULL CHECK (price >= 0)
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date TEXT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 2. Insert sample data
INSERT INTO customers VALUES
(1, 'Aarav Sharma', 'Chennai'),
(2, 'Maya Patel', 'Bengaluru'),
(3, 'Riya Kumar', 'Vellore'),
(4, 'Kabir Singh', 'Chennai'),
(5, 'Ananya Das', 'Hyderabad');

INSERT INTO products VALUES
(101, 'SQL Basics', 'Technology', 450.00),
(102, 'Python for Beginners', 'Technology', 550.00),
(103, 'The Hidden Garden', 'Fiction', 300.00),
(104, 'Ocean Adventures', 'Children', 250.00),
(105, 'Everyday Science', 'Education', 400.00),
(106, 'Mystery at Midnight', 'Fiction', 350.00);

INSERT INTO orders VALUES
(1001, 1, '2026-11-01'),
(1002, 2, '2026-11-02'),
(1003, 1, '2026-11-05'),
(1004, 3, '2026-11-07'),
(1005, 4, '2026-11-10');

INSERT INTO order_items VALUES
(1, 1001, 101, 1),
(2, 1001, 103, 2),
(3, 1002, 102, 1),
(4, 1002, 104, 2),
(5, 1003, 105, 1),
(6, 1003, 101, 1),
(7, 1004, 103, 1),
(8, 1004, 106, 1),
(9, 1005, 104, 3);

-- Question 1: Which products did each customer buy, and on what date?
-- Demonstrates joins across customers, orders, order_items, and products.
SELECT
    c.customer_name,
    o.order_date,
    p.product_name,
    oi.quantity
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
JOIN order_items AS oi ON o.order_id = oi.order_id
JOIN products AS p ON oi.product_id = p.product_id
ORDER BY o.order_date, c.customer_name, p.product_name;

-- Question 2: How much money did each customer spend in total?
-- Demonstrates joins and grouping with the SUM aggregate.
SELECT
    c.customer_name,
    ROUND(SUM(p.price * oi.quantity), 2) AS total_spent
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
JOIN order_items AS oi ON o.order_id = oi.order_id
JOIN products AS p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

-- Question 3: What is the total quantity sold and revenue for each category?
-- Demonstrates GROUP BY with SUM and multiple joins.
SELECT
    p.category,
    SUM(oi.quantity) AS units_sold,
    ROUND(SUM(p.price * oi.quantity), 2) AS category_revenue
FROM products AS p
JOIN order_items AS oi ON p.product_id = oi.product_id
JOIN orders AS o ON oi.order_id = o.order_id
GROUP BY p.category
ORDER BY category_revenue DESC;

-- Question 4: Which customers have not placed any orders?
-- Demonstrates LEFT JOIN and finding unmatched rows.
SELECT
    c.customer_id,
    c.customer_name,
    c.city
FROM customers AS c
LEFT JOIN orders AS o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
ORDER BY c.customer_id;

-- Question 5: Which products have never been ordered?
-- Demonstrates LEFT JOIN across products and order_items.
SELECT
    p.product_id,
    p.product_name,
    p.category
FROM products AS p
LEFT JOIN order_items AS oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL
ORDER BY p.product_id;
