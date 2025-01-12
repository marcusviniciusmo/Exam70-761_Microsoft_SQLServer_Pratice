---------------------------------------------------------------------
-- LAB 04
--
-- Exercise 5
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Execute the T-SQL code under Task 1. Do not worry yf you do not understand the provide T-SQL code,
	as it is used here to provide a more realistic example for a cross join in the next task.
*/

SET NOCOUNT ON;

IF OBJECT_ID('HR.Calendar') IS NOT NULL
	DROP TABLE HR.Calendar;

CREATE TABLE HR.Calendar(
	calendardate DATE CONSTRAINT PK_Calendar PRIMARY KEY
);

DECLARE
	@startdate DATE = DATEFROMPARTS(YEAR(SYSDATETIME()), 1, 1),
	@enddate DATE = DATEFROMPARTS(YEAR(SYSDATETIME()), 12, 31);

WHILE @startdate <= @enddate
BEGIN
	INSERT INTO HR.Calendar (calendardate)
	VALUES (@startdate);

	SET @startdate = DATEADD(DAY, 1, @startdate);
END

SET NOCOUNT OFF;

GO
-- Observe the HR.Calendar table

SELECT calendardate
FROM HR.Calendar;

/*
---------------------------------------------------------------------
	>> TASK 2

	Write a SELECT statement to retrieve the empid, firstname, and lastname columns from HR.Employees table
	and the calendardate column from the HR.Calendar table.
	Execute the written statement and compare the results that you got with the recommended result shown in the
	file 92 - Lab Exercise 5 - Task 2 Result.txt.
	What is the number of rows returned by the query? There are nine rows in the HR.Employees table. Try to
	calculate the total number of rows in the HR.Calendar table.
*/

SELECT E.empid, E.firstname, E.lastname, C.calendardate
FROM HR.Employees AS E
CROSS JOIN HR.Calendar AS C;
GO

/*
	Answer 1: (3285 row(s) affected). It is a cartesian product between the two tables.
*/

/*
---------------------------------------------------------------------
	>> TASK 3

	Execute the provided T-SQL statement to remove the HR.Calendar table.
*/

IF OBJECT_ID('HR.Calendar') IS NOT NULL
	DROP TABLE HR.Calendar;