USE master;
GO

-- Drop and Restore Database
IF EXISTS (SELECT * FROM sys.sysdatabases WHERE name = 'TSQL')
BEGIN
	DROP DATABASE TSQL;
END
GO

RESTORE DATABASE [TSQL] FROM DISK = N'D:\Marcus\Projetos\Exam70-761_MicrosoftPratice\Databases\TSQL.bak' WITH REPLACE,
MOVE N'TSQL' TO N'D:\Marcus\Projetos\Exam70-761_MicrosoftPratice\Databases\TSQL.mdf',
MOVE N'TSQL_Log' TO N'D:\Marcus\Projetos\Exam70-761_MicrosoftPratice\Databases\TSQL_LOG.ldf'
GO
ALTER AUTHORIZATION ON DATABASE::TSQL TO [ADVENTUREWORKS/Student];
GO