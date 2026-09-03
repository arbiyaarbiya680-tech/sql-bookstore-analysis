DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Books;

CREATE TABLE Books(
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10,2),
    Stock INT
);

CREATE TABLE Customers(
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

CREATE TABLE Orders(
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10,2)
);

COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'E:\Practice Files SQL Projects\Books.csv'
HEADER CSV;

COPY Customers(Customer_ID, Name, Email, Phone, City, Country)
FROM 'E:\Practice Files SQL Projects\Customers.csv'
HEADER CSV;

COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)
FROM 'E:\Practice Files SQL Projects\Orders.csv'
HEADER CSV;

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

--1) Retrieve all books in the "Fiction" genre
SELECT * FROM Books
WHERE GENRE = 'Fiction';

--2) Find books published after the year 1950
SELECT * FROM Books
WHERE Published_Year >1950;

--3) List all customers from the Canada
SELECT * FROM Customers
WHERE COUNTRY = 'Canada';

--4) Show orders placed in November 2023
SELECT * FROM Orders
WHERE ORDER_DATE BETWEEN '2023-11-01' AND '2023-11-30';

--5) Retrieve the total stock of books available
SELECT SUM(STOCK) AS TOTAL_STOCK
FROM Books;

--6) Find the details of the most expensive book
SELECT * FROM Books ORDER BY PRICE DESC LIMIT 1;

--7) Show all customers who ordered more than 1 quantity of a book
SELECT * FROM Orders 
WHERE QUANTITY > 1;

-- 8) Retrieve all orders where the total amount exceeds $20
SELECT * FROM Orders 
WHERE TOTAL_AMOUNT >20;

-- 9) List all genres available in the Books table
SELECT DISTINCT GENRE FROM Books;

-- 10) Find the book with the lowest stock
SELECT * FROM Books ORDER BY STOCK LIMIT 1;

-- 11) Calculate the total revenue generated from all orders
SELECT SUM(TOTAL_AMOUNT) AS TOTAL_REVENUE FROM Orders;

-- Advance Queries
-- 1) Retrieve the total number of books sold for each genre
SELECT * FROM Orders;

SELECT b.Genre, SUM(o.Quantity) AS TOTAL_QUANTITY
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;

-- 2) Find the average price of books in the "Fantasy" genre
SELECT AVG(PRICE) AS AVG_PRICE 
FROM Books
WHERE Genre = 'Fantasy';

-- 3) List customers who have placed at least 2 orders
SELECT CUSTOMER_ID , COUNT(ORDER_ID) AS ORDER_COUNT
FROM Orders
GROUP BY CUSTOMER_ID
HAVING COUNT(ORDER_ID) >= 2;

SELECT
	O.CUSTOMER_ID,
	C.NAME,
	COUNT(O.ORDER_ID) AS ORDER_COUNT
FROM
	ORDERS O
	JOIN CUSTOMERS C ON C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY
	O.CUSTOMER_ID , C.NAME
HAVING
	COUNT(ORDER_ID) >= 2;

-- 4) Find the most frequently ordered book
SELECT BOOK_ID, COUNT(ORDER_ID) AS ORDER_COUNT 
FROM ORDERS
GROUP BY BOOK_ID
ORDER BY ORDER_COUNT DESC LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre 
SELECT * FROM BOOKS 
WHERE GENRE = 'Fantasy'
ORDER BY PRICE DESC LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author
SELECT B.AUTHOR, SUM(O.QUANTITY) AS TOTAL_BOOKS_SOLD
FROM BOOKS B 
JOIN ORDERS O ON B.BOOK_ID = O.BOOK_ID
GROUP BY B.AUTHOR;

-- 7) List the cities where customers who spent over $30 are located
SELECT DISTINCT C.CITY, TOTAL_AMOUNT 
FROM ORDERS O
JOIN CUSTOMERS C ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE O.TOTAL_AMOUNT > 30;

-- 8) Find the customer who spent the most on orders
SELECT C.CUSTOMER_ID, C.NAME, SUM(TOTAL_AMOUNT) AS TOTAL_SPENT
FROM ORDERS O
JOIN CUSTOMERS C ON C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY C.NAME, C.CUSTOMER_ID
ORDER BY TOTAL_SPENT DESC LIMIT 1;

-- 9) Calculate the stock remaining after fulfilling all order
SELECT B.BOOK_ID, B.TITLE,B.STOCK, COALESCE(SUM(O.QUANTITY),0) AS ORDER_QUANTITY,
B.STOCK - COALESCE(SUM(O.QUANTITY),0) AS REMAINING_QUANITY
FROM BOOKS B
LEFT JOIN ORDERS O ON B.BOOK_ID = O.BOOK_ID 
GROUP BY B.BOOK_ID
ORDER BY B.BOOK_ID ASC;




