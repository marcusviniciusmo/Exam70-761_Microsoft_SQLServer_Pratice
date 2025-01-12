-- Demonstration C

-- Step 1: Open a new query window to the TSQL database.

USE TSQL;
GO

-- Step 2a: Column aliases in derived tables. Select this query and execute it to show internal column aliases.

SELECT
	orderyear,
	COUNT(DISTINCT custid) AS cust_count
FROM (
		SELECT YEAR(orderdate) AS orderyear, custid
		FROM Sales.Orders
	) AS derived_year
GROUP BY orderyear;
GO

-- Step 2b: Select this query and execute it to show external column aliases.

SELECT
	orderyear,
	COUNT(DISTINCT custid) AS cust_count
FROM (
		SELECT YEAR(orderdate), custid
		FROM Sales.Orders
	) AS derived_year(orderyear, custid)
GROUP BY orderyear;
GO

-- Step 3: Use a local variable as a parameter for a derived table

DECLARE @emp_id INT = 9;

SELECT
	orderyear,
	COUNT(DISTINCT custid) AS cust_count
FROM (
		SELECT
			YEAR(orderdate) AS orderyear, custid
		FROM Sales.Orders
		WHERE empid = @emp_id
	) AS derived_year
GROUP BY orderyear;
GO

-- Step 4: Nesting derived tables

SELECT
	orderyear,
	cust_count
FROM (
		SELECT
			orderyear,
			COUNT(DISTINCT custid) AS cust_count
		FROM (
				SELECT
					YEAR(orderdate) AS orderyear,
					custid
				FROM Sales.Orders
			) AS derived_table1
		GROUP BY orderyear
	) AS derived_table2
WHERE cust_count > 80;
GO

-- An alternative to nesting, at the cost of restating the COUNT expression in a HAVING clause.

SELECT
	orderyear,
	COUNT(DISTINCT custid) AS cust_count
FROM (
		SELECT
			YEAR(orderdate) AS orderyear,
			custid
		FROM Sales.Orders
	) AS derived_table1
GROUP BY orderyear
HAVING COUNT(DISTINCT custid) > 80;
GO