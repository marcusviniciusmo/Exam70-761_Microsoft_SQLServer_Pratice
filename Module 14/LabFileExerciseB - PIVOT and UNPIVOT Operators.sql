---------------------------------------------------------------------
-- LAB 14
--
-- Exercise 2
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> Task 1

	Execute the provided T-SQL code to generate the Sales.PivotCustGroups view.
	Write a SELECT statement to retrieve the country, A, B, and C columns from the Sales.PivotCustGroups view.
	Execute the written statement and compare the results that you got with the desired results shown in the file 62 - Lab Exercise 2 -
	Task 1 Result.txt.
*/

CREATE VIEW Sales.PivotCustGroups
AS
	WITH PivotCusGroups
	AS
	(
		SELECT
			custid,
			country,
			custgroup
		FROM Sales.CustGroups
	)

SELECT
	country,
	P.A, P.B, P.C
FROM PivotCusGroups
	PIVOT (COUNT(custid) FOR custgroup IN (A, B, C)) AS P;
GO

-- Solution

SELECT
	country, A, B, C
FROM Sales.PivotCustGroups;
GO

/*
---------------------------------------------------------------------
	>> Task 2

	Write a SELECT statement against the Sales.PivotCustGroups view that returns the following:
		- A row for each country and customer group.
		- The column country.
		- Two new columns - custgroup and numberofcustomers. The custgroup should hold the names of the source columns A, B, and C as character
		strings, and the numberofcustomers column should hold their values (i.e., number of customers).
	Execute the T-SQL code and compare the results that you got with the recommended result shown in the file 63 - Lab Exercise 2 -
	Task 2 Result.txt.
*/

SELECT
	custgroup, country, numberofcustomers
FROM Sales.PivotCustGroups AS P
	UNPIVOT (numberofcustomers FOR custgroup IN (A, B, C)) AS unpvt;
GO

/*
---------------------------------------------------------------------
	>> Task 3

	Remove the created views by executing the provided T-SQL code. Execute this code exactly as written inside a query window.
*/

IF OBJECT_ID('Sales.CustGroups', 'V') IS NOT NULL
	DROP VIEW Sales.CustGroups;
GO

IF OBJECT_ID('Sales.PivotCustGroups', 'V') IS NOT NULL
	DROP VIEW Sales.PivotCustGroups;
GO