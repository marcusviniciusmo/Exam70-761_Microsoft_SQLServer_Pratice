-- Demonstration B

-- Step 1: Open a new query window to the TSQL database.

USE TSQL;
GO

-- Step 2: Use a TRY CATCH block.
-- Ther will only be an error if the variable on the first line is set to 0.

DECLARE @num VARCHAR(20) = '2';

BEGIN TRY
	PRINT 5 / CAST(@num AS NUMERIC(4,2));
END TRY
BEGIN CATCH
	PRINT 'Error number: ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
	PRINT 'Error Message: ' + ERROR_MESSAGE();
END CATCH;
GO