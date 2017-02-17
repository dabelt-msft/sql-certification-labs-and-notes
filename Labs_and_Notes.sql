--Challenge 1: Retrieve Customer Data
--Adventure Works Cycles sells directly to retailers, who then sell products to consumers. Each retailer that is an Adventure Works customer has provided a named contact for all communication from Adventure Works. The sales manager at Adventure Works has asked you to generate some reports containing details of the company’s customers to support a direct sales campaign.
--Tip: Review the documentation for the SELECT statement in the Transact-SQL Reference.
--1. Retrieve customer details
--Familiarize yourself with the Customer table by writing a Transact-SQL query that retrieves all columns for all customers.
--2. Retrieve customer name data
--Create a list of all customer contact names that includes the title, first name, middle name (if any), last name, and suffix (if any) of all customers.
--3. Retrieve customer names and phone numbers
--Each customer has an assigned salesperson. You must write a query to create a call sheet that lists:
-- The salesperson
-- A column named CustomerName that displays how the customer contact should be greeted (for
--example, “Mr Smith”)
-- The customer’s phone number.
--Challenge 2: Retrieve Customer and Sales Data
--As you continue to work with the Adventure Works customer data, you must create queries for reports that have been requested by the sales team.
--Tip: Review the documentation for Conversion Functions in the Transact-SQL Reference.
--1. Retrieve a list of customer companies
--You have been asked to provide a list of all customer companies in the format <Customer ID> : <Company Name> - for example, 78: Preferred Bikes.
--2. Retrieve a list of sales order revisions
--The SalesLT.SalesOrderHeader table contains records of sales orders. You have been asked to retrieve data for a report that shows:
-- The sales order number and revision number in the format <Order Number> (<Revision>) – for example SO71774 (2).
-- The order date converted to ANSI standard format (yyyy.mm.dd – for example 2015.01.31). Challenge 3: Retrieve Customer Contact Details
--Some records in the database include missing or unknown values that are returned as NULL. You must create some queries that handle these NULL fields appropriately.
--Tip: Review the documentation for the ISNULL function and Expressions in the Transact-SQL Reference.
--1. Retrieve customer contact names with middle names if known
--You have been asked to write a query that returns a list of customer names. The list must consist of a single field in the format <first name> <last name> (for example Keith Harris) if the middle name is unknown, or <first name> <middle name> <last name> (for example Jane M. Gates) if a middle name is stored in the database.
--2. Retrieve primary contact details
--Customers may provide adventure Works with an email address, a phone number, or both. If an email address is available, then it should be used as the primary contact method; if not, then the phone number should be used. You must write a query that returns a list of customer IDs in one column, and a second column named PrimaryContact that contains the email address if known, and otherwise the phone number.
--      IMPORTANT: In the sample data provided in AdventureWorksLT, there are no customer records without an email address. Therefore, to verify that your query works as expected, run the following UPDATE statement to remove some existing email addresses before creating your query (don’t worry, you’ll learn about UPDATE statements later in the course).
--UPDATE SalesLT.Customer
-- SET EmailAddress = NULL
--WHERE CustomerID % 7 = 1;
--3. Retrieve shipping status
--You have been asked to create a query that returns a list of sales order IDs and order dates with a column named ShippingStatus that contains the text “Shipped” for orders with a known ship date, and “Awaiting Shipment” for orders with no ship date.
--IMPORTANT: In the sample data provided in AdventureWorksLT, there are no sales order header records without a ship date. Therefore, to verify that your query works as expected, run the following UPDATE statement to remove some existing ship dates before creating your query (don’t worry, you’ll
--learn about UPDATE statements later in the course).
--UPDATE SalesLT.SalesOrderHeader
--SET ShipDate = NULL
--WHERE SalesOrderID > 71899;


-- Display all columns for all customers
SELECT * FROM SalesLT.Customer;

-- Display customer name fields
SELECT Title, FirstName, MiddleName, LastName, Suffix
FROM SalesLT.Customer;

SELECT FirstName, MiddleName, LastName, Suffix AS LONGTITLE
FROM SalesLT.Customer

-- Display title and last name with phone number
SELECT Salesperson, Title + ' ' + LastName AS CustomerName, Phone
FROM SalesLT.Customer;

SELECT Salesperson, Title + ' ' + LastName AS CustomerName, Phone
FROM SalesLT.Customer;

SELECT SalesPerson, Title + ' ' + LastName AS CustomerName, Phone
FROM SalesLT.Customer;

---CHALLENGE 2

Select CAST(CustomerID AS varchar) + ': ' + CompanyName AS CustomerCompanies
From SalesLT.Customer;

Select SalesOrderNumber + '( ' + STR(RevisionNumber, 1) + ')' AS OrderRevision, CONVERT(nvarchar(30), OrderDate, 102)
FROM SalesLT.SalesOrderHeader;

---- Challenge three

--1.
Select Title + ' ' + FirstName + ' ' + ISNULL(MiddleName + ' ', '') + LastName AS CustomerInfo
FROM SalesLT.Customer;

UPDATE SalesLT.Customer
SET EmailAddress = NULL
WHERE CustomerID % 7 = 1;


SELECT CustomerID, ISNULL(EmailAddress+ ' ', Phone) AS PrimaryContact
FROM SalesLT.Customer;

UPDATE SalesLT.SalesOrderHeader
SET ShipDate = NULL
WHERE SalesOrderID > 71899;

SELECT SalesOrderID, OrderDate,
	CASE
		WHEN ShipDate is Null THEN 'Awaiting Shipment'
		ELSE 'Shipped'
	END AS ShippingStatus
From SalesLT.SalesOrderHeader;

-- Note -- WITH TIES NEEDS TO BE USED WITH AN ORDER BY

--SELECT TOP (10) WITH TIES SalesPerson , FirstName
FROM SalesLT.Customer
ORDER BY SalesPerson Desc;

--OFFSET --DOES NOT WORK WITH TOP

SELECT SalesPerson , FirstName
FROM SalesLT.Customer
ORDER BY SalesPerson Desc
OFFSET 10 ROW;

--OFFSET BY 500, BUT ONLY SHOWING 20 TOTAL

SELECT SalesPerson , FirstName
FROM SalesLT.Customer
ORDER BY SalesPerson Desc
OFFSET 500 ROW
FETCH FIRST 20 ROWS ONLY;


--USING DISTINCT, FETCH NEEDS OFFSET TO WORK

SELECT DISTINCT ISNULL(ProductID, 'NULL') AS PRODUCT 
FROM SalesLT.SalesOrderDetail
ORDER BY Product
OFFSET 1 ROW
FETCH FIRST 20 ROWS ONLY;

--DISTINCT WITH TOP 
SELECT DISTINCT TOP 5 ISNULL(ProductId, 'null') AS Product
FROM SalesLT.SalesOrderDetail;

--Skipping Sections
SELECT SalesOrderID AS OrderNumber
FROM SalesLT.SalesOrderDetail
ORDER BY OrderNumber
OFFSET 0 ROWS
FETCH NEXT 100 ROWS ONLY;

---------
--Section-1 - Module 2-- Video 4
-- >,=>, =, <=
-- IN
-- BETWEEN -- USED WITH SET OF THINGS LIKE SET OF COLORS
-- LIKE -- Used with strings 
-- AND
-- OR
-- NOT 

--WHERE--
---------

--WHERE LIKE A%Z -- Means it's looking for any characters starting with a, ending in z. 
--WHERE LIKE A__Z -- '_ _' two underscores, means it's looking for a string starting with A, with TWO* characters in between, ending in z. 

--**Where conditional is not even being displayed here -- powerful**
SELECT Name, Color, Size FROM SalesLT.Product WHERE ProductModelId >= 6;

-- _ is any one character, % is any comination of any characters
SELECT ProductNumber, Name, Color, Size FROM SalesLT.Product WHERE ProductNumber LIKE 'FR-__2%58';


SELECT ProductNumber, Name, Color, Size FROM SalesLT.Product WHERE ProductNumber LIKE 'FR-_[0-9][0-9]_-[0-9][0-9]';

SELECT Name FROM SalesLT.Product WHERE SellEndDate IS NOT NUll;

--ISO DATE FORMAT IS STANDARD - YEAR, MONTH, DAY
SELECT Name FROM SalesLT.Product WHERE SellEndDate BETWEEN '2006/1/1' AND '2016/12/31';

--Selecting from a list of items
SELECT ProductCategoryID FROM SalesLT.Product WHERE ProductCategoryID IN (5, 6, 7)
ORDER BY ProductCategoryID DESC;

SELECT ProductCategoryID, SellEndDate From SalesLT.Product WHERE ProductCategoryID IN (5,6,7) AND SellEndDate IS NULL;

SELECT ProductCategoryID, SellEndDate From SalesLT.Product WHERE ProductNumber LIKE 'FR%' OR (ProductCategoryID IN (5,6,7) AND SellEndDate IS NULL);


--- SECTION 2 ---

-- Moduel 3 --
SELECT SalesLT.Product.Name AS Name, SalesLT.ProductCategory.Name AS Category
FROM SalesLT.Product
INNER JOIN SalesLT.ProductCategory
ON SalesLT.Product.ProductCategoryID = SalesLT.ProductCategory.ProductCategoryID;

SELECT p.Name As Name, c.Name AS Category
FROM SalesLT.Product AS p
INNER JOIN SalesLT.ProductCategory as c
ON p.ProductCategoryId = c.ProductCategoryId;

SELECT oh.OrderDate, oh.SalesOrderNumber, p.Name AS ProductName, od.OrderQty, od.UnitPrice, od.LineTotal
FROM SalesLT.SalesOrderHeader AS oh
INNER JOIN SalesLT.SalesOrderDetail as od
ON oh.SalesOrderID = od.SalesOrderID
INNER JOIN SalesLT.Product AS p
ON od.ProductID = p.ProductID
ORDER BY oh.OrderDate, oh.SalesOrderId, Od.SalesOrderDetailId;

SELECT oh.OrderDate, oh.SalesOrderNumber, p.Name AS ProductName, od.OrderQty, od.UnitPrice, od.LineTotal
FROM SalesLT.SalesOrderHeader as oh
INNER JOIN SalesLT.SalesOrderDetail as od
ON od.SalesOrderId = oh.SalesOrderID
INNER JOIN SalesLT.Product AS p 
ON p.ProductID = od.ProductID AND od.UnitPrice < 65
ORDER BY oh.OrderDate, oh.SalesOrderId, od.SalesOrderDetailId;


--1. Company name -> Customer, SalesOrderID, Total => SalesOrderHeader;
SELECT c.CompanyName, H.SalesOrderID, H.TotalDue
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader AS H
ON H.CustomerID = C.CustomerID;

--2. Retrieve customer orders
--Main Office Address for each customer -- Full St Address, City, State, Province, Postal Code, Country/Region

--Lab 3 - Module 3
--Challenge 1: Generate Invoice Reports
--Adventure Works Cycles sells directly to retailers, who must be invoiced for their orders. You have been tasked with writing a query to generate a list of invoices to be sent to customers.
--Tip: Review the documentation for the FROM clause in the Transact-SQL Reference.
--1. Retrieve customer orders
--As an initial step towards generating the invoice report, write a query that returns the company name from the SalesLT.Customer table, and the sales order ID and total due from the SalesLT.SalesOrderHeader table.
--2. Retrieve customer orders with addresses
--Extend your customer orders query to include the Main Office address for each customer, including the full street address, city, state or province, postal code, and country or region
--Challenge 2: Retrieve Sales Data
--As you continue to work with the Adventure Works customer and sales data, you must create queries for reports that have been requested by the sales team.
--Tip: Note that each customer can have multiple addressees in the SalesLT.Address table, so the
--database developer has created the SalesLT.CustomerAddress table to enable a many-to-many relationship between customers and addresses. Your query will need to include both of these tables, and should filter the join to SalesLT.CustomerAddress so that only Main Office addresses are included.
--1. Retrieve a list of all customers and their orders
--The sales manager wants a list of all customer companies and their contacts (first name and last name), showing the sales order ID and total due for each order they have placed. Customers who have not placed any orders should be included at the bottom of the list with NULL values for the order ID and total due.
--2. Retrieve a list of customers with no address
--A sales employee has noticed that Adventure Works does not have address information for all customers. You must write a query that returns a list of customer IDs, company names, contact names (first name and last name), and phone numbers for customers with no address stored in the database.
--3. Retrieve a list of customers and products without orders
--Some customers have never placed orders, and some products have never been ordered. Create a query that returns a column of customer IDs for customers who have never placed an order, and a column of product IDs for products that have never been ordered. Each row with a customer ID should have a NULL product ID (because the customer has never ordered a product) and each row with a product ID should have a NULL customer ID (because the product has never been ordered by a customer).

--Challenge 1

--1
SELECT Distinct City, StateProvince
FROM SalesLT.Address;

--2
SELECT TOP 10 PERCENT Name, Weight 
FROM SalesLT.Product
WHERE Weight is not NULL
ORDER BY WEIGHT DESC;

--3
SELECT Name, Weight
FROM SalesLT.Product
WHERE Weight IS NOT NULL
ORDER BY Weight DESC
OFFSET 10 ROWS
FETCH FIRST 100 ROWS ONLY;

--Challenge 2

--1
SELECT Name, Color, Size
FROM SalesLT.Product
WHERE ProductModelId = 1;

--2
SELECT ProductNumber, Name
FROM SalesLT.Product
WHERE Color in('black', 'white', 'red') AND Size in('S', 'M');

--3
SELECT ProductNumber, Name
From SalesLT.Product
WHERE ProductNumber Like 'BK-%';

--4
SELECT ProductNumber, Name, ListPrice
From SalesLT.Product
WHERE ProductNumber Like 'BK-[^R]%-[0-9][0-9]';


--Module 4 --UNION
--BEST PRACTICE - Limit current data set for faster processing, and UNION archived (older) data sets when needed for reports or when needed for broader search criteria. 
SELECT EmployeeName as FirstName
FROM SalesLT.Employee
UNION
SELECT FirstName
FROM SalesLT.Customer
ORDER BY FirstName;

--UNION ALL
SELECT EmployeeName as FirstName
FROM SalesLT.Employee
UNION ALL
SELECT FirstName
FROM SalesLT.Customer
ORDER BY FirstName;

-- UNION ALL with TYPE
SELECT EmployeeName AS FirstName, 'Employee' AS Type
FROM SalesLT.Employee
UNION ALL
SELECT FirstName, 'Customer' --Uses first reference to Type, since it's the third column
FROM SalesLT.Customer
ORDER BY FirstName;

--INTERSECT --Find records that exist in both tables
--EXCEPT --Find items that occur in one but DO NOT occur in another

--INTERSECT --Customers who have purchased an item
SELECT CustomerID AS Customer
FROM SalesLT.Customer
INTERSECT
SELECT ProductID
FROM SalesLT.Product
ORDER BY ProductID;

--EXCEPT --Customers who have never purchased an item. 
SELECT CustomerID AS Customer
FROM SalesLT.Customer
EXCEPT
SELECT CustomerID
FROM SalesLT.SalesOrderHeader;

--EXCEPT --Items that have never been sold.
SELECT ProductID
FROM SalesLT.Product
EXCEPT
SELECT ProductID AS Product
FROM SalesLT.SalesOrderDetail
ORDER BY ProductID;

--Lab4 Challenge 1
--1.1
--Write a query that retrieves the company name, first line of the street address, city, and a column named AddressType with the value ‘Billing’ for customers where the address type in the SalesLT.CustomerAddress table is ‘Main Office’.
SELECT C.CompanyName, A.AddressLine1, A.City, 'Billing' AS AddressType
FROM SalesLT.CustomerAddress as CA
JOIN SalesLT.Customer as C
ON C.CustomerID = CA.CustomerID
JOIN SalesLT.Address as A
ON CA.AddressID = A.AddressID
WHERE CA.AddressType = 'Main Office';

--1.2
--Write a similar query that retrieves the company name, first line of the street address, city, and a column named AddressType with the value ‘Shipping’ for customers where the address type in the SalesLT.CustomerAddress table is ‘Shipping’.
SELECT C.CompanyName, A.AddressLine1, A.City, 'Shipping' AS AddressType
FROM SalesLT.CustomerAddress as CA
JOIN SalesLT.Customer as C
ON C.CustomerID = CA.CustomerID
JOIN SalesLT.Address as A
ON CA.AddressID = A.AddressID
WHERE CA.AddressType = 'Shipping';

--1.3
-- Combine the results returned by the two queries to create a list of all customer addresses that is sorted by company name and then address type.
SELECT C.CompanyName, A.AddressLine1, A.City, 'Billing' AS AddressType
FROM SalesLT.CustomerAddress as CA
JOIN SalesLT.Customer as C
ON C.CustomerID = CA.CustomerID
JOIN SalesLT.Address as A
ON CA.AddressID = A.AddressID
WHERE CA.AddressType = 'Main Office'
UNION ALL
SELECT C.CompanyName, A.AddressLine1, A.City, 'Shipping' AS AddressType
FROM SalesLT.CustomerAddress as CA
JOIN SalesLT.Customer as C
ON C.CustomerID = CA.CustomerID
JOIN SalesLT.Address as A
ON CA.AddressID = A.AddressID
WHERE CA.AddressType = 'Shipping'
ORDER BY C.CompanyName, AddressType;

--Challenge 2
--2.1
-- Write a query that returns the company name of each company that appears in a table of customers with a ‘Main Office’ address, but not in a table of customers with a ‘Shipping’ address.
SELECT C.CompanyName
FROM SalesLT.CustomerAddress AS CA
JOIN SalesLT.Customer AS C
ON CA.CustomerID = C.CustomerID
WHERE CA.AddressType = 'Main Office'
EXCEPT
SELECT C.CompanyName
FROM SalesLT.CustomerAddress AS CA
JOIN SalesLT.Customer AS C
ON CA.CustomerID = C.CustomerID
WHERE CA.AddressType = 'Shipping';

--2.2
--Write a query that returns the company name of each company that appears in a table of customers with a ‘Main Office’ address, and also in a table of customers with a ‘Shipping’ address.
SELECT C.CompanyName
FROM SalesLT.CustomerAddress AS CA
JOIN SalesLT.Customer AS C
ON CA.CustomerID = C.CustomerID
WHERE CA.AddressType = 'Main Office'
INTERSECT
SELECT C.CompanyName
FROM SalesLT.CustomerAddress AS CA
JOIN SalesLT.Customer AS C
ON CA.CustomerID = C.CustomerID
WHERE CA.AddressType = 'Shipping';

--Module 5 --Lab 5
--Challenge 1
--1.1
-- Write a query to return the product ID of each product, together with the product name formatted as upper case and a column named ApproxWeight with the weight of each product rounded to the nearest whole unit.

--1.2
--Extend your query to include columns named SellStartYear and SellStartMonth containing the year and month in which Adventure Works started selling each product. The month should be displayed as the month name (for example, ‘January’).

--1.3
-- Extend your query to include a column named ProductType that contains the leftmost two characters from the product number.

--1.4
-- Extend your query to filter the product returned so that only products with a numeric size are included.

--Challenge 2
--2.1
-- Write a query that returns a list of company names with a ranking of their place in a list of highest TotalDue values from the SalesOrderHeader table.

--Challenge 3
--3.1
--Write a query to retrieve a list of the product names and the total revenue calculated as the sum of the LineTotal from the SalesLT.SalesOrderDetail table, with the results sorted in descending order of total revenue.

--3.2
--Modify the previous query to include sales totals for products that have a list price of more than $1000.

--3.3
-- Modify the previous query to only include only product groups with a total sales value greater than $20,000.

--1.1 
SELECT UPPER(CONCAT(P.ProductID, ' ' , P.Name)) AS Product, ROUND(P.Weight, 1) AS ApproxWeight
FROM SalesLT.Product AS P;

--1.2
SELECT YEAR(P.SellStartDate) AS SellStartYear, DATENAME(mm, P.SellStartDate) AS SellStartMonth
FROM SalesLT.Product AS P;

--1.3
SELECT YEAR(P.SellStartDate) AS SellStartYear, DATENAME(mm, P.SellStartDate) AS SellStartMonth, LEFT(P.ProductID,2) AS ID
FROM SalesLT.Product AS P;

--1.4
SELECT YEAR(SellStartDate) AS SellStartYear, DATENAME(mm, SellStartDate) AS SellStartMonth, LEFT(ProductID,2) AS ID, Size
FROM SalesLT.Product
WHERE ISNUMERIC(Size) = 1;

--2.1
SELECT CompanyName, 
		TotalDue AS Revenue,
		RANK() OVER (ORDER BY OH.TotalDue DESC) AS Ranking
FROM SalesLT.SalesOrderHeader AS OH
JOIN SalesLT.Customer AS C
ON OH.CustomerID = C.CustomerID;

--3.1
--Product Names, Total Revenue, Total Revenue calculated as sum of LineTotal, SalesOrderDetail Desc Order
SELECT P.Name,
		SUM(SOD.LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS SOD
JOIN SalesLT.Product AS P
ON SOD.ProductID = P.ProductID
GROUP BY P.Name
ORDER BY TotalRevenue DESC;

--3.2
SELECT Name,SUM(LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS SOD
JOIN SalesLT.Product AS P
ON SOD.ProductID = P.ProductID
WHERE P.ListPrice > 1000
GROUP BY P.Name
ORDER BY TotalRevenue DESC;

--3.3 -- Displays Total Revenue for every item costing more than 2000. Note - Name can be listed even though it's not an aggregate since that's what it's being grouped by. 
SELECT P.Name, SUM(LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS SOD
JOIN SalesLT.Product AS P
ON SOD.ProductID = P.ProductID
WHERE P.ListPrice > 1000
GROUP BY P.Name
HAVING SUM(LineTotal) > 2000
ORDER BY TotalRevenue DESC;

-- Displays Total Revenue HAVING (if greater than 2000) of all items where list price. 
SELECT P.ListPrice, SUM(LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS SOD
JOIN SalesLT.Product AS P
ON SOD.ProductID = P.ProductID
WHERE P.ListPrice > 1000
GROUP BY P.ListPrice
HAVING SUM(LineTotal) > 2000
ORDER BY TotalRevenue DESC;

--Gets list prices for all of the products
SELECT Name, P.ListPrice
FROM SalesLT.SalesOrderDetail AS SOD
JOIN SalesLT.Product AS P
ON SOD.ProductID = P.ProductID
WHERE P.ListPrice > 1000;

--Lists * Customers grouped by State and Then City
-- NOTE - Non-aggregate values can be displayed (State, City) as long as they are included in 'Group by'
SELECT COUNT(C.CustomerID) AS CustomerCount, A.City AS CustomerCity, A.StateProvince AS CustomerState
FROM SalesLT.CustomerAddress AS CA
JOIN SalesLT.Customer AS C
ON CA.CustomerID = C.CustomerID
JOIN SalesLT.Address AS A
ON CA.AddressID = A.AddressID
GROUP BY StateProvince, City;

-- SUBQUERIES -- SECTION 3, Module 6
SELECT MAX(UnitPrice)
FROM SalesLT.SalesOrderDetail -- Results in 1467.01 added below

SELECT * FROM SalesLT.Product
WHERE ListPrice > 1467.01;

-- Alternatively - Use the first query above inside of the second query 
SELECT * FROM SalesLT.Product
WHERE ListPrice > 
(SELECT MAX(UnitPrice)
FROM SalesLT.SalesOrderDetail);

--Correlated Subquery
--Displays the most recent order for any given customer
SELECT CustomerID, SalesOrderId, OrderDate
FROM SalesLT.SalesOrderHeader AS SOH1
WHERE OrderDate = 
(SELECT MAX(OrderDate)
FROM SalesLT.SalesOrderHeader AS SOH2
WHERE SOH1.OrderDate = SOH2.OrderDate);

--Challenge 1: Retrieve Product Price Information
--Adventure Works products each have a standard cost price that indicates the cost of manufacturing the product, and a list price that indicates the recommended selling price for the product. This data is stored in the SalesLT.Product table. Whenever a product is ordered, the actual unit price at which it was sold is also recorded in the SalesLT.SalesOrderDetail table. You must use subqueries to compare the cost and list prices for each product with the unit prices charged in each sale.
--Tip: Review the documentation for subqueries in Subquery Fundamentals.
--1. Retrieve products whose list price is higher than the average unit price
--Retrieve the product ID, name, and list price for each product where the list price is higher than the average unit price for all products that have been sold.

SELECT ProductID, Name, ListPrice
FROM SalesLT.Product AS P
WHERE ListPrice > 
(SELECT AVG(UnitPrice) 
FROM SalesLT.SalesOrderDetail AS SOD)
ORDER BY ProductID;

--2. Retrieve Products with a list price of $100 or more that have been sold for less than $100
--Retrieve the product ID, name, and list price for each product where the list price is $100 or more, and the product has been sold for less than $100.

SELECT ProductID, Name, ListPrice
FROM SalesLT.Product
WHERE ProductID IN	
(SELECT ProductID
FROM SalesLT.SalesOrderDetail
WHERE ListPrice >= 100
AND UnitPrice < 100)

--3. Retrieve the cost, list price, and average selling price for each product
--Retrieve the product ID, name, cost, and list price for each product along with the average unit price for which that product has been sold.

SELECT ProductID, Name, StandardCost AS Cost, ListPrice, 
	(SELECT AVG(UnitPrice)
	FROM SalesLT.SalesOrderDetail AS SOD
	WHERE SOD.ProductID = P.ProductId) AS AverageCost
FROM SalesLT.Product AS P

--4. Retrieve products that have an average selling price that is lower than the cost
--Filter your previous query to include only products where the cost price is higher than the average selling price.
SELECT ProductID, Name, StandardCost AS Cost, ListPrice, (SELECT AVG(UnitPrice)
	FROM SalesLT.SalesOrderDetail AS SOD
	WHERE SOD.ProductID = P.ProductId) AS AverageSellingCost
FROM SalesLT.Product AS P
WHERE StandardCost > 
	(SELECT AVG(UnitPrice)
	FROM SalesLT.SalesOrderDetail AS SOD
	WHERE SOD.ProductID = P.ProductId)

--Challenge 2: Retrieve Customer Information
--The AdventureWorksLT database includes a table-valued user-defined function named dbo.ufnGetCustomerInformation. You must use this function to retrieve details of customers based on customer ID values retrieved from tables in the database.
--Tip: Review the documentation for the APPLY operator in Using APPLY.
--1. Retrieve customer information for all sales orders

SELECT SOH.SalesOrderId, SOH.CustomerID, CI.FirstName, CI.LastName, SOH.TotalDue
FROM SalesLT.SalesOrderHeader AS SOH
CROSS APPLY dbo.ufnGetCustomerInformation(SOH.CustomerID) AS CI
ORDER BY SOH.SalesOrderID


--Retrieve the sales order ID, customer ID, first name, last name, and total due for all sales orders from the SalesLT.SalesOrderHeader table and the dbo.ufnGetCustomerInformation function.
--2. Retrieve customer address information
--Retrieve the customer ID, first name, last name, address line 1 and city for all customers from the SalesLT.Address and SalesLT.CustomerAddress tables, and the dbo.ufnGetCustomerInformation function.
SELECT CA.CustomerID, CI.FirstName, CI.LastName, A.AddressLine1
FROM SalesLT.Address AS A
JOIN SalesLT.CustomerAddress as CA
ON A.AddressID = CA.AddressID
CROSS APPLY dbo.ufnGetCustomerInformation(CA.CustomerID) AS CI
ORDER BY CI.LastName;

-------- Module Seven --
-------- Using Table Expressions

--Creating a view
CREATE VIEW SalesLT.vSalesOrders
AS
SELECT SOH.SalesOrderId, SOD.UnitPrice, P.Name AS ProductName, C.FirstName AS CustomerName
FROM SalesLt.SalesOrderHeader AS SOH
JOIN SalesLT.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
JOIN SalesLT.Product AS P
ON SOD.ProductID = P.ProductID
JOIN SalesLT.Customer AS C
ON SOH.CustomerID = C.CustomerID

--Running newly created view
SELECT ProductName, CustomerName
FROM SalesLT.vSalesOrders

--Combining new view with additonal query
SELECT ProductName, ListPrice, AVG(UnitPrice) AS AverageUnitPrice
FROM SalesLT.vSalesOrders AS vSO
JOIN SalesLT.Product AS P
ON vSO.ProductName = P.Name
GROUP BY ListPrice, ProductName
ORDER BY AverageUnitPrice

--Create function for defining customers by city
--Once run, can be found in /Programmability/Functions/Table-valued\ Functions
CREATE FUNCTION SalesLT.udfCustomersByCity
(@City AS VARCHAR(20))
RETURNS TABLE
AS
RETURN
(SELECT C.FirstName, C.LastName, A.City
FROM SalesLT.Customer AS C
JOIN SalesLT.CustomerAddress AS CA
ON C.CustomerID = CA.CustomerID
JOIN SalesLT.Address AS A
ON CA.AddressID = A.AddressID
WHERE City = @City)

SELECT * FROM SalesLT.udfCustomersByCity('Bellevue')

SELECT Category, COUNT(ProductID) AS Products
FROM
	(SELECT P.ProductID, P.Name AS Product, C.Name AS Category
	FROM SalesLT.Product AS P
	JOIN SalesLT.ProductCategory AS C
	ON P.ProductCategoryID = C.ProductCategoryID) AS ProdCats
GROUP BY Category
ORDER BY Category;

--Recursive Query --Recursive Queries have large overhead- Use with small datasets 
WITH OrgReport (ManagerID, EmployeeID, EmployeeName, Level)
AS
( 
SELECT
FROM HR.Employee AS E
WHERE ManagerID IS NULL
UNION ALL
SELECT E.ManagerID, E.EmployeeID, EmployeeName, 0
E.ManagerID, E.EmployeeId, E.EmployeeName, Level + 1
FROM HR.Employee AS E
INNER JOIN OrgReport AS O
ON E.ManagerID = O.EmoloyeeID
) 
SELECT * FROM OrgReport
OPTION (MAXRECURSION 3);

WITH ProductsByCategory (ProductId, ProductName, Category)
AS
(
	SELECT p.ProductId, p.Name, c.Name as Category
	FROM SalesLT.Product AS P
	JOIN SalesLT.ProductCategory AS C
	ON P.ProductCategoryId = C.ProductCategoryId
)

SELECT Category, COUNT(ProductId) AS Products
FROM ProductsByCategory
GROUP BY Category
ORDER BY Category

--Recursive Query 2 ---works with Adventureworkslt
WITH OrgReport (ManagerID, EmployeeID, EmployeeName, Level)
AS
( 
	--Ancor Query - Base Case
	SELECT E.ManagerID, E.EmployeeID, EmployeeName, 0
	FROM SalesLT.Employee AS E
	WHERE ManagerID IS NULL

	UNION ALL

	--Recursive Query
	SELECT E.ManagerID, E.EmployeeId, E.EmployeeName, Level + 1
	FROM SalesLt.Employee AS E
	INNER JOIN OrgReport AS O
	ON E.ManagerID = O.EmployeeID
) 

SELECT * FROM OrgReport
OPTION (MAXRECURSION 3);



--Challenge 1: Retrieve Product Information
--Adventure Works sells many products that are variants of the same product model. You must write queries that retrieve information about these products
--1. Retrieve product model descriptions
--Retrieve the product ID, product name, product model name, and product model summary for each product from the SalesLT.Product table and the SalesLT.vProductModelCatalogDescription view.

CREATE VIEW SalesLT.vProductModelCatologDescription
AS
SELECT ProductModelId, Name, CatalogDescription
FROM SalesLT.ProductModel

SELECT P.ProductId, P.Name, MCD.Name AS ModelName, MCD.Summary
FROM SalesLT.Product AS P
JOIN SalesLT.vProductModelCatalogDescription AS MCD
ON P.ProductModelId = MCD.ProductModelId
ORDER BY ProductId;

SELECT * FROM SalesLT.vProductModelCatalogDescription;


--2. Create a table of distinct colors
--Tip: Review the documentation for Variables in Transact-SQL Language Reference.
--Create a table variable and populate it with a list of distinct colors from the SalesLT.Product table. Then use the table variable to filter a query that returns the product ID, name, and color from the SalesLT.Product table so that only products with a color listed in the table variable are returned.

DECLARE @colors AS TABLE (Color nvarchar(15))

INSERT INTO @Colors
SELECT DISTINCT Color
FROM SalesLT.Product

SELECT ProductID, Name, Color
FROM SalesLT.Product
WHERE Color IN (SELECT Color FROM @Colors)

--3. Retrieve product parent categories
--The AdventureWorksLT database includes a table-valued function named dbo.ufnGetAllCategories, which returns a table of product categories (for example ‘Road Bikes’) and parent categories (for example ‘Bikes’). Write a query that uses this function to return a list of all products including their parent category and category.


SELECT C.ParentProductCategoryName AS ParentCategory,
       C.ProductCategoryName AS Category,
       P.ProductID, P.Name AS ProductName
FROM SalesLT.Product AS P
JOIN dbo.ufnGetAllCategories() AS C
ON P.ProductCategoryID = C.ProductCategoryID
ORDER BY ParentCategory, Category, ProductName;


--Challenge 2: Retrieve Customer Sales Revenue
--Each Adventure Works customer is a retail company with a named contact. You must create queries that return the total revenue for each customer, including the company and customer contact names.
--1. Retrieve sales revenue by customer and contact
--Retrieve a list of customers in the format Company (Contact Name) together with the total revenue for that customer. Use a derived table or a common table expression to retrieve the details for each sales order, and then query the derived table or CTE to aggregate and group the data.

WITH CustomerSales(CompanyContact, SalesAmount)
AS
(SELECT CONCAT(c.CompanyName, CONCAT(' (' + c.FirstName + ' ', c.LastName + ')')), SOH.TotalDue
 FROM SalesLT.SalesOrderHeader AS SOH
 JOIN SalesLT.Customer AS c
 ON SOH.CustomerID = c.CustomerID)
SELECT CompanyContact, SUM(SalesAmount) AS Revenue
FROM CustomerSales
GROUP BY CompanyContact
ORDER BY CompanyContact;


--Challenge 1: Retrieve Regional Sales Totals
--Adventure Works sells products to customers in multiple country/regions around the world.
--1. Retrieve totals for country/region and state/province
--Tip: Review the documentation for GROUP BY in the Transact-SQL Language Reference.
--An existing report uses the following query to return total sales revenue grouped by country/region and
--state/province.
--SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue FROM SalesLT.Address AS a
--JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
--JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
--JOIN SalesLT.SalesOrderHeader as soh ON c.CustomerID = soh.CustomerID GROUP BY a.CountryRegion, a.StateProvince
--ORDER BY a.CountryRegion, a.StateProvince;
--You have been asked to modify this query so that the results include a grand total for all sales revenue and a subtotal for each country/region in addition to the state/province subtotals that are already returned.

SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh
ON c.CustomerID = soh.CustomerID
GROUP BY a.CountryRegion, a.StateProvince
ORDER BY a.CountryRegion, a.StateProvince;



--2. Indicate the grouping level in the results
--Tip: Review the documentation for the GROUPING_ID function in the Transact-SQL Language Reference.
--Modify your query to include a column named Level that indicates at which level in the total, country/region, and state/province hierarchy the revenue figure in the row is aggregated. For example, the grand total row should contain the value ‘Total’, the row showing the subtotal for United States should contain the value ‘United States Subtotal’, and the row showing the subtotal for California should contain the value ‘California Subtotal’.

SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh
ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince;

--3. Add a grouping level for cities
--Extend your query to include a grouping for individual cities.

SELECT a.CountryRegion, a.StateProvince, a.City,
CHOOSE (1 + GROUPING_ID(a.CountryRegion) + GROUPING_ID(a.StateProvince) + GROUPING_ID(a.City), a.City + ' Subtotal', a.StateProvince + ' Subtotal', a.CountryRegion + ' Subtotal', 'Total') AS Level,
SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh
ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince, a.City)
ORDER BY a.CountryRegion, a.StateProvince, a.City;

--Challenge 2: Retrieve Customer Sales Revenue by Category
--Adventure Works products are grouped into categories, which in turn have parent categories (defined in the SalesLT.vGetAllCategories view). Adventure Works customers are retail companies, and they may place orders for products of any category. The revenue for each product in an order is recorded as the LineTotal value in the SalesLT.SalesOrderDetail table.
--1. Retrieve customer sales revenue for each parent category
--Retrieve a list of customer company names together with their total revenue for each parent category in Accessories, Bikes, Clothing, and Components.

SELECT * FROM
(SELECT cat.ParentProductCategoryName, cust.CompanyName, sod.LineTotal
 FROM SalesLT.SalesOrderDetail AS sod
 JOIN SalesLT.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
 JOIN SalesLT.Customer AS cust ON soh.CustomerID = cust.CustomerID
 JOIN SalesLT.Product AS prod ON sod.ProductID = prod.ProductID
 JOIN SalesLT.vGetAllCategories AS cat ON prod.ProductcategoryID = cat.ProductCategoryID) AS catsales
PIVOT (SUM(LineTotal) FOR ParentProductCategoryName IN ([Accessories], [Bikes], [Clothing], [Components])) AS pivotedsales
ORDER BY CompanyName;
