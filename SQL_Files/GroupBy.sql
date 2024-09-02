
-- The GROUP BY statement groups rows that have the same values into summary rows,
--  like "find the number of customers in each country".

-- The GROUP BY statement is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()) to group the result-set 
-- by one or more columns.

SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
ORDER BY column_name(s);


-- The following SQL statement lists the number of customers in each country, sorted high to low:

Example
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC;


GROUP BY With JOIN Example
--- The following SQL statement lists the number of orders sent by each shipper:

Example
SELECT Shippers.ShipperName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID
GROUP BY ShipperName;

SQL HAVING Examples
-- The following SQL statement lists the number of customers in each country. Only include countries with more than 5 customers:

ExampleGet your own SQL Server
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5;

-- Having

-- The following SQL statement lists the number of customers in each country, sorted high to low (Only include countries with more than 5 customers):

Example
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5
ORDER BY COUNT(CustomerID) DESC;

More HAVING Examples
-- the following SQL statement lists the employees that have registered more than 10 orders:

Example
SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
FROM (Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID)
GROUP BY LastName
HAVING COUNT(Orders.OrderID) > 10;

SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
FROM Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE LastName = 'Davolio' OR LastName = 'Fuller'
GROUP BY LastName
HAVING COUNT(Orders.OrderID) > 25;

-- technical test mySql

### Technical Interview Plan for MySQL (30 Minutes)

Below is a structured plan for a 30-minute technical interview focusing on MySQL. This plan includes exercises that test basic and intermediate SQL skills. The interviewee will work with a set of predefined tables.

### Setup: Database Schema
Before starting the interview, make sure the following tables are created in your MySQL database. This schema represents a simple database for a company that deals with customers, orders, and products.

#### 1. **Customers Table**
```sql
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ContactName VARCHAR(100),
    Country VARCHAR(50)
);
```

#### 2. **Orders Table**
```sql
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    ShipperID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
```

#### 3. **Products Table**
```sql
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    SupplierID INT,
    Price DECIMAL(10, 2)
);
```

#### 4. **OrderDetails Table**
```sql
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
```

#### 5. **Shippers Table**
```sql
CREATE TABLE Shippers (
    ShipperID INT PRIMARY KEY,
    ShipperName VARCHAR(100),
    Phone VARCHAR(20)
);
```

### Sample Data Insertion (Optional)
Insert some sample data into the tables to facilitate testing:

```sql
-- Customers
INSERT INTO Customers VALUES (1, 'John Smith', 'John S.', 'USA');
INSERT INTO Customers VALUES (2, 'Sara Doe', 'Sara D.', 'UK');
INSERT INTO Customers VALUES (3, 'Mike Johnson', 'Mike J.', 'Canada');

-- Orders
INSERT INTO Orders VALUES (1, 1, '2024-08-01', 1);
INSERT INTO Orders VALUES (2, 2, '2024-08-03', 2);
INSERT INTO Orders VALUES (3, 1, '2024-08-05', 3);

-- Products
INSERT INTO Products VALUES (1, 'Laptop', 1, 1200.00);
INSERT INTO Products VALUES (2, 'Mouse', 2, 25.00);
INSERT INTO Products VALUES (3, 'Keyboard', 1, 75.00);

-- OrderDetails
INSERT INTO OrderDetails VALUES (1, 1, 1, 1);
INSERT INTO OrderDetails VALUES (2, 1, 2, 2);
INSERT INTO OrderDetails VALUES (3, 2, 3, 1);

-- Shippers
INSERT INTO Shippers VALUES (1, 'DHL', '123-456-7890');
INSERT INTO Shippers VALUES (2, 'FedEx', '098-765-4321');
INSERT INTO Shippers VALUES (3, 'UPS', '555-555-5555');
```

### Interview Questions

#### **1. Basic Query (5 minutes)**
- **Question:** Retrieve a list of all customers in the `USA`.
- **Expected Output:**
  - `CustomerID`
  - `CustomerName`
  - `ContactName`

```sql
SELECT CustomerID, CustomerName, ContactName
FROM Customers
WHERE Country = 'USA';
```

#### **2. Joining Tables (5 minutes)**
- **Question:** Retrieve a list of all orders along with the customer name and shipper name.
- **Expected Output:**
  - `OrderID`
  - `CustomerName`
  - `ShipperName`
  - `OrderDate`

```sql
SELECT Orders.OrderID, Customers.CustomerName, Shippers.ShipperName, Orders.OrderDate
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID;
```

#### **3. Aggregation (5 minutes)**
- **Question:** Find the total number of orders made by each customer.
- **Expected Output:**
  - `CustomerName`
  - `TotalOrders`

```sql
SELECT Customers.CustomerName, COUNT(Orders.OrderID) AS TotalOrders
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Customers.CustomerName;
```

#### **4. Filtering and Grouping (5 minutes)**
- **Question:** Find the total quantity of products ordered in each order where the total quantity is greater than 1.
- **Expected Output:**
  - `OrderID`
  - `TotalQuantity`

```sql
SELECT OrderID, SUM(Quantity) AS TotalQuantity
FROM OrderDetails
GROUP BY OrderID
HAVING SUM(Quantity) > 1;
```

#### **5. Subquery (5 minutes)**
- **Question:** Retrieve the names of products that have never been ordered.
- **Expected Output:**
  - `ProductName`

```sql
SELECT ProductName
FROM Products
WHERE ProductID NOT IN (
    SELECT ProductID FROM OrderDetails
);
```

#### **6. Update Operation (5 minutes)**
- **Question:** Increase the price of all products by 10% where the current price is less than $100.
- **Expected Outcome:**
  - The prices of applicable products should be updated.

```sql
UPDATE Products
SET Price = Price * 1.10
WHERE Price < 100;
```

### Wrap-Up

At the end of the session, discuss the interviewee's approach to each problem, their understanding of key SQL concepts, and areas for improvement if any. Provide feedback on their query performance, efficiency, and any best practices they should consider.

This interview plan should be completed within 30 minutes and covers a broad range of SQL topics, providing a good measure of the interviewee's understanding of MySQL.