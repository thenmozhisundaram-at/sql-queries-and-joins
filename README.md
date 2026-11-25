# SQL Queries and Joins — Online Bookstore

A small SQLite project demonstrating joins, aggregate functions, and grouping.

## Project contents

- `queries.sql` — creates the sample database, inserts sample data, and runs five questions.
- `RESULTS.txt` — expected output for each query.
- `README.md` — setup and run instructions.

## Database design

The sample online bookstore has four related tables:

- `customers` — customer details
- `products` — books and their categories/prices
- `orders` — orders placed by customers
- `order_items` — products and quantities in each order

Relationships:
- One customer can place many orders.
- One order can contain many order items.
- Each order item refers to one product.

## Requirements covered

- Multiple joins across related tables (`INNER JOIN` and `LEFT JOIN`)
- Aggregate functions: `SUM`
- Grouping with `GROUP BY`
- Five questions, each documented directly above its SQL query
- Expected results documented in `RESULTS.txt`

## How to run

Install SQLite if it is not already installed.

From this folder, run:

```bash
sqlite3 bookstore.db < queries.sql
```

This creates (or resets) the sample tables, inserts the sample records, and prints the query results.

If you use DB Browser for SQLite:
1. Open DB Browser for SQLite.
2. Choose **File → Open Database** and create/open `bookstore.db`.
3. Open the **Execute SQL** tab.
4. Paste the contents of `queries.sql` and click **Run**.

## Notes

- The SQL uses SQLite-compatible syntax.
- The sample data is fictional and created for this assignment.
- Running `queries.sql` again resets and recreates the sample tables.
