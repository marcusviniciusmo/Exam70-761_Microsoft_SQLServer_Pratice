---------------------------------------------------------------------
-- LAB 16
--
-- Exercise 2
---------------------------------------------------------------------

USE TSQL;
GO

/*
---------------------------------------------------------------------
	>> TASK 1

	Write a T-SQL code tha defines the variable @result as an nvarchar(20) data type and the variable @i as an int data type. Set the value of
	the @i variable to 8. Write an IF statement that implements the following logic:
		For @i variable values less than 5, set the value of the @result variable to "Less than 5".
		For @i variable values between 5 and 10, set the value of the @result variable to "Between 5 and 10".
		For all @i variable values over 10, set the value of the @result variable to "More than 10".
		For other @i variable values, set the value of the @result variable to "Unknown".
	At the end of the T-SQL code, write a SELECT statement to retrieve the value of the @result variable using the alias result. Highlight the
	complete T-SQL code and execute it.
	Observe and compare the results that you got with the desired results shown in the file 62 - Lab Exercise 2 - Task 1 Result.txt.
	Copy the T-SQL code and modify it by replacing the IF statement with a CASE expression to get the same result.
*/

-- IF statement

DECLARE @result NVARCHAR(20),
	@i INT;

SET @i = 8;

IF @i < 5
	SET @result = 'Less than 5';
ELSE IF @i >= 5 AND @i <= 10
	SET @result = 'Between 5 and 10';
ELSE IF @i > 10
	SET @result = 'More than 10';
ELSE
	SET @result = 'Unknow';

SELECT @result AS result;
GO

-- CASE expression

DECLARE @result NVARCHAR(20),
	@i INT;

SET @i = 8;

SET @result = 
	(CASE 
		WHEN @i < 5
			THEN 'Less than 5'
		WHEN @i >= 5 AND @i <= 10
			THEN 'Between 5 and 10'
		WHEN @i > 10
			THEN 'More than 10'
		ELSE 'Unknown'
	END);

SELECT @result AS result;
GO

/*
---------------------------------------------------------------------
	>> TASK 2

	Write a T-SQL code that declares two variables: @birthdate (data type date) and @cmpdate (data type date).
	Set the value of the @birthdate variable by writing a SELECT statement against the HR.Employees table and retrieve the column birthday. Filter
	the result tot include only the employee with an empid equal to 5.
	Set the @cmpdate variable to the value January 1, 1970.
	Write an IF conditional statement by comparing the @birthdate and @cmpdate variable values. If @birthdate is less than @cmpdate, use the PRINT
	statement to print the message "The person selected was born before January 1, 1970". Otherwise, print the message "The person selected was
	born on or after the January 1, 1970".
	Execute the T-SQL code.
	Observe and compare the results that you got with the recommended result shown in the file 63 - Lab Exercise 2 - Task 2 Result.txt. This is a
	simple example for the purpose of this exercise. Typically, there would be a different statement block that would execute in each case.
*/

DECLARE @birthdate DATE,
	@cmpdate DATE;

SET @birthdate = (
	SELECT birthdate
	FROM HR.Employees
	WHERE empid = 5);

SET @cmpdate = '19700101';

IF (@birthdate < @cmpdate)
	PRINT 'The person selected was born before January 1, 1970'
ELSE
	PRINT 'The person selected was born on or after the January 1, 1970';
GO

/*
---------------------------------------------------------------------
	>> TASK 3

	The IT department has provided T-SQL code that encapsulates the previous Task in a stored procedure named Sales.CheckPersonBirthdate. It has
	two parameters: @empid, which you use to specify an employee id, and @cmpdate, which you use as a comparison date. Execute the provided T-SQL
	code.
	Write an EXECUTE statement to invoke the Sales.CheckPersonBirthdate stored procedure using the parameters of 3 for @empid and January 1, 1990,
	for @cmpdate. Execute the T-SQL code.
	Observe and compare the results that you got with the recommended result shown in the file 64 - Lab Exercise 2 - Task 3 Result.txt.
*/

CREATE PROCEDURE Sales.CheckPersonBirthdate
	(@empid INT, @cmpdate DATE)
AS
	DECLARE @birthdate DATE;

	SET @birthdate = (
		SELECT birthdate
		FROM HR.Employees
		WHERE empid = @empid)

	IF @birthdate < @cmpdate
		PRINT CONCAT('The person selected was born before ', FORMAT(@cmpdate, 'MMMM d, yyyy', 'en-US'))
	ELSE
		PRINT CONCAT('The person select was born on or after ', FORMAT(@cmpdate, 'MMMM d, yyyy', 'en-US'));
GO

EXECUTE Sales.CheckPersonBirthdate
	@empid = 3, @cmpdate = '19900101';
GO

/*
---------------------------------------------------------------------
	>> TASK 4

	Write T-SQL code to loop 10 times, displaying the current loop information each time.
	Define the @i variable as an int data type. Write a WHILE statement to execute while the @i variable value is less or equal 10. Inside the
	loop statement, write a PRINT statement to display the value of the @i variable using the alias loopid. Add T-SQL code to increment the @i
	variable value by 1.
	Observe and compare the results that you got with the recommended result shown in the file 65 - Lab Exercise 2 - Task 4 Result.txt.
*/

DECLARE @i INT = 1;

WHILE @i <= 10
	BEGIN
		PRINT CONCAT('The value of @i now is: ', @i);

		SET @i += 1;
	END
GO

/*
---------------------------------------------------------------------
	>> TASK 5

	Execute the provided T-SQL code to remove the created stored procedure.
*/

IF OBJECT_ID('Sales.CheckPersonBirthdate', 'P') IS NOT NULL
	DROP PROCEDURE Sales.CheckPersonBirthdate;
GO