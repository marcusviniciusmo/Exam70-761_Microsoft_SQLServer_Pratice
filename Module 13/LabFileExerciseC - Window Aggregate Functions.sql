---------------------------------------------------------------------
-- LAB 13
--
-- Exercise 3
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a SELECT statement to retrieve the custid, orderid, orderdate, and val columns from the Sales.OrderValues view. Add a calculated column
	named percoftotalcust that contains a percentage value of each order sales amount compared to the total sales amount for that customer.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 72 - Lab Exercise 3 -
	Task 1 Result.txt.
*/

SELECT
	custid, orderid, orderdate, val,
	(100. * val / SUM(val) OVER(
		PARTITION BY custid)) AS percoftotalcust
FROM Sales.OrderValues
ORDER BY custid, percoftotalcust DESC;
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Copy the previous SELECT statement and modify it by adding a new calculated column named runval. This column should contain a running sales
	total for each customer based on order date, using orderid as the tiebreaker.
	Execute the written statement and compare the results that you got with the recommended result shown in the file 73 - Lab Exercise 3 -
	Task 2 Result.txt.
*/

SELECT
	custid, orderid, orderdate, val,
	(100. * val / SUM(val) OVER(
		PARTITION BY custid)) AS percoftotalcust,
	(SUM(val) OVER(
		PARTITION BY custid
		ORDER BY orderdate, orderid
		ROWS BETWEEN UNBOUNDED PRECEDING
		AND CURRENT ROW)) AS runval
FROM Sales.OrderValues;
GO

/*
---------------------------------------------------------------------
	>> TASK 3

	Copy the SalesMonth2007 CTE in the last Task in Exercise 2. Write a SELECT statement to retrieve the monthno and val columns. Add two
	calculated columns:
		- avglast3months. This column should contain the average sales amount for last three months before the current month using a window
			aggregate function. You can assume that there are no missing months.
		- ytdval. This column should contain the cumulative sales value up to the current month.
	Execute the written statement and comapre the results that you got with the recommended result shown in the file 74 - Lab Exercise 3 -
	Task 3 Result.txt.
*/

WITH SalesMonth2007
AS
(
	SELECT
		MONTH(orderdate) AS monthno,
		SUM(val) AS val
	FROM Sales.OrderValues
	WHERE orderdate >= '20070101' AND orderdate < '20080101'
	GROUP BY MONTH(orderdate)
)

SELECT
	monthno,
	val,
	(AVG(val) OVER(
		ORDER BY monthno
		ROWS BETWEEN 3 PRECEDING
		AND CURRENT ROW)) AS avglast3months,
	(SUM(val) OVER(
		ORDER BY monthno
		ROWS BETWEEN UNBOUNDED PRECEDING
		AND CURRENT ROW)) AS ytdval
FROM SalesMonth2007;
GO