# 📚 Bookstore SQL Analysis

A SQL project analyzing a bookstore's sales data — built to practice querying, 
joins, aggregations, and business-style reporting questions.

## 🗂️ Dataset
Three related tables:
- **Books** — Title, Author, Genre, Published Year, Price, Stock
- **Customers** — Name, Email, Phone, City, Country
- **Orders** — Customer, Book, Order Date, Quantity, Total Amount

## 🎯 What this project covers
**Basic queries:**
- Filtering by genre, year, country, date range
- Aggregates: total stock, total revenue
- Sorting: most expensive book, lowest stock

**Advanced queries:**
- JOINs across Books, Customers, and Orders
- GROUP BY + HAVING for repeat customers
- Revenue and quantity analysis by genre/author
- Remaining stock calculation using LEFT JOIN + COALESCE
- Top spender identification

## 🛠️ Tools
PostgreSQL

## 💡 Sample insight
Identified which genre sold the highest quantity of books and which customer 
generated the most revenue — the kind of question a bookstore owner would 
actually ask.

## 📁 Files
- `Project.sql` — schema creation, data import, and all queries
- `Books.csv`, `Customers.csv`, `Orders.csv` — sample dataset
