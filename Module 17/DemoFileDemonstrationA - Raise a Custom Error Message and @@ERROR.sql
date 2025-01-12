-- Demonstration A

-- Step 1: Open a new query window to the T-SQL database.

USE TSQL;
GO

-- Step 2: Raise a custom error with RAISERROR.

RAISERROR (N'%s %d %s',
	10,
	1,
	N'Error number:',
	123,
	N'- No action needed');
GO

-- Capture @@ERROR into a variable.

DECLARE @ErrorValue int;

RAISERROR (N'%s %d %s',
	10,
	1,
	N'Error number:',
	123,
	N'- No action needed');

SET @ErrorValue = @@ERROR;
IF @ErrorValue <> 0
	PRINT 'Error=' + CAST(@ErrorValue AS VARCHAR(8));
GO

-- Create a custom error message.

sp_addmessage 50001, 10, N'%s %d %s';
GO

-- Use a custom error message.

RAISERROR (50001,
	10,
	1,
	N'Error number:',
	123,
	N'- No action needed');
GO