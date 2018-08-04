
-- SQL SERVER 2016
-- use ZuoraMigration;

-- DROP IF EXISTS

CREATE TABLE dbo.TestTable (RecordId int not null);

DROP TABLE IF EXISTS dbo.TestTable;

-- CREATE OR ALTER - SP1

GO
CREATE OR ALTER PROCEDURE dbo.sp_testproc
AS
SELECT object_id, name, type_desc
FROM sys.tables;
GO

-- String_Split
-- The String_Split function will take a delimited list and return each value in a one column table.

DECLARE @List varchar(100) = 'Matt Ryan,Julio Jones,Vic Beasley,Desmond Trufant';
SELECT value FROM STRING_SPLIT(@List, ',');

-- JSON

SELECT [Name], OBJECT_ID, [Type], [Type_Desc] FROM sys.tables FOR JSON AUTO;

-- String_Escape
-- This function will take a string and escape special characters for a certain format. Currently, the only format supported is for JSON.

SELECT STRING_ESCAPE('She said "OK"', 'json');

-- AT TIME ZONE:
-- Using AT TIME ZONE gives a way to convert a datetime value to a datetimeoffset value for a specific time zone by using a time zone name.

-- 2012 - date time offset
-- Can convert time, but you have to know the offset of the target time zone and account for DST

SELECT SYSDATETIMEOFFSET() AS CurrentEasternTime;
SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '-08:00') AS CurrentPacificTime;

-- 2016 - can specific the time zone - DST aware

SELECT SYSDATETIMEOFFSET() AS CurrentEasternTime;
SELECT SYSDATETIMEOFFSET() AT TIME ZONE 'Pacific Standard Time' AS CurrentPacificTime;

-- Time zone values
SELECT * FROM sys.time_zone_info;

-- COMPRESS/DECOMPRESS:
-- SQL Server 2016 also includes built-in support for compression and decompression, using GZip.

DROP TABLE IF EXISTS dbo.TestCompress;

CREATE TABLE dbo.TestCompress(
RecordId int NOT NULL IDENTITY(1,1),
CompressedData varbinary(max) NOT NULL
);
 
DECLARE @Text nvarchar(max) = 'We the People of the United States, in Order to form a more perfect Union, establish Justice, insure domestic Tranquility, provide for the common defence, promote the general Welfare, and secure the Blessings of Liberty to ourselves and our Posterity, do ordain and establish this Constitution for the United States of America.';
INSERT INTO dbo.TestCompress(CompressedData) VALUES (COMPRESS(@Text));
SELECT * FROM dbo.TestCompress;
SELECT RecordId, CAST(DECOMPRESS(CompressedData) AS nvarchar(max)) FROM dbo.TestCompress;

SELECT DATALENGTH(CompressedData) FROM dbo.TestCompress;
SELECT DATALENGTH(@Text);
SELECT RecordId, DATALENGTH(CAST(DECOMPRESS(CompressedData) AS nvarchar(max))) FROM dbo.TestCompress;

-- FORMATMESSAGE:
-- Currently FORMATMESSAGE is used for error messages that come from sys.messages, so that error information can be inserted into the standard error messages.
-- We can now supply our own message using %s as place holder and then drop in our text in those placeholders.

DECLARE @Team1 varchar(20) = 'Atlanta Falcons';
DECLARE @Team2 varchar(20) = 'Seattle Seahawks';
 
SELECT FORMATMESSAGE('2017-11-20 %s vs %s', @Team1, @Team2);

-- DATEDIFF_BIG

SELECT DATEDIFF(ms, '1900-01-01', '2100-01-01');

SELECT DATEDIFF_BIG(ms, '1900-01-01', '2100-01-01');

---------------------------------------------
-- Row Level Security -----------------------
---------------------------------------------

DROP SECURITY POLICY IF EXISTS RLSTestPolicy;
DROP FUNCTION IF EXISTS dbo.CanViewIsSensitive;
DROP TABLE IF EXISTS dbo.RLSTest;

CREATE TABLE dbo.RLSTest (
RecordId int NOT NULL identity(1,1) primary key,
DisplayName varchar(20) NOT NULL,
IsSensitive bit NOT NULL
);
 
INSERT INTO dbo.RLSTest(DisplayName, IsSensitive) values ('Record1', 0);
INSERT INTO dbo.RLSTest(DisplayName, IsSensitive) values ('Record2', 1);
INSERT INTO dbo.RLSTest(DisplayName, IsSensitive) values ('Record3', 1);
INSERT INTO dbo.RLSTest(DisplayName, IsSensitive) values ('Record4', 1);
INSERT INTO dbo.RLSTest(DisplayName, IsSensitive) values ('Record5', 0);
 
SELECT * FROM dbo.RLSTest;
GO

CREATE FUNCTION dbo.CanViewIsSensitive(@IsSensitive bit)
RETURNS TABLE
WITH SCHEMABINDING
AS
 
RETURN SELECT 1 AS CanViewIsSensitive
WHERE @IsSensitive = 0
OR IS_SRVROLEMEMBER(N'sysadmin') = 1; 
GO

CREATE SECURITY POLICY RLSTestPolicy
ADD FILTER PREDICATE dbo.CanViewIsSensitive(IsSensitive)
ON dbo.RLSTest
WITH (STATE = ON);
GO
 
-- Connect with non-admin user
SELECT * FROM dbo.RLSTest;
GO

---------------------------------------------
-- Data Masking -----------------------------
---------------------------------------------

-- Admin can see data - Use non-admin user

DROP TABLE IF EXISTS dbo.TestTable;

CREATE TABLE dbo.TestTable(
RecordId int NOT NULL identity(1,1) primary key,
Name varchar(30) NOT NULL,
SSN varchar(9) MASKED WITH(FUNCTION = 'default()') NOT NULL,
CreditCardNumber varchar(16) MASKED WITH(FUNCTION = 'default()') NOT NULL
);

INSERT INTO dbo.TestTable([Name], SSN, CreditCardNumber) VALUES ('Jane Doe', '123456789', '1234567890123456');

SELECT * FROM dbo.TestTable;

-- Custom Masking

DROP TABLE IF EXISTS dbo.TestTable2;

CREATE TABLE dbo.TestTable2(
RecordId int NOT NULL identity(1,1) primary key,
Name varchar(30) NOT NULL,
SSN varchar(9) MASKED WITH(FUNCTION = 'partial(0, "XXXXX", 4)') NOT NULL,
CreditCardNumber varchar(16) MASKED WITH(FUNCTION = 'partial(0, "XXXXXXXXXXXX", 4)') NOT NULL
);

INSERT INTO dbo.TestTable2([Name], SSN, CreditCardNumber) VALUES ('Jane Doe', '123456789', '1234567890123456');

SELECT * FROM dbo.TestTable2;

---------------------------------------------
-- Temporal Tables --------------------------
---------------------------------------------

DROP TABLE IF EXISTS dbo.TestTemporal;

CREATE TABLE dbo.TestTemporal (
RecordId int not null identity(1,1) primary key,
RecordName varchar(20) not null,
CreatedAt datetime not null default(getutcdate()),
StartTime datetime2 generated always as row start not null,
EndTime datetime2 generated always as row end not null,
period for system_time (StartTime, EndTime)
) WITH (system_versioning = on);

INSERT INTO dbo.TestTemporal(RecordName)
VALUES ('Record1');

SELECT * FROM dbo.TestTemporal;

UPDATE dbo.TestTemporal SET RecordName = 'Record1A' WHERE RecordID = 1;

-- Current Record
SELECT * FROM dbo.TestTemporal;

-- Record at specified time
SELECT * FROM dbo.TestTemporal FOR system_time AS OF '2017-11-13 15:16:56';

-- Record during range of dates
SELECT * FROM dbo.TestTemporal FOR system_time FROM '2017-11-14' TO '2017-11-15';

GO

---------------------------------------------
-- Cleanup ----------------------------------
---------------------------------------------

DROP PROC IF EXISTS dbo.sp_testproc;
DROP TABLE IF EXISTS dbo.TestCompress;
DROP TABLE IF EXISTS dbo.TestTable;
DROP TABLE IF EXISTS dbo.TestTable2;
DROP SECURITY POLICY IF EXISTS RLSTestPolicy;
DROP FUNCTION IF EXISTS dbo.CanViewIsSensitive;
IF OBJECT_ID('dbo.TestTemporal') IS NOT NULL
	ALTER TABLE dbo.TestTemporal SET (system_versioning = off);
DROP TABLE IF EXISTS dbo.TestTemporal;
DROP TABLE IF EXISTS dbo.RLSTest;
GO
