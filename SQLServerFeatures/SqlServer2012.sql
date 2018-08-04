
-- SQL Server 2012

---------------------------------------------------------
-- SEQUENCE ---------------------------------------------
---------------------------------------------------------

-- The Sequence object is used to generate identity values for a table. One advantage is that a value can be generated without having to 
-- first make an INSERT INTO a table.

-- Create:

IF OBJECT_ID('dbo.TestTable1') IS NOT NULL
	DROP TABLE dbo.TestTable1;
IF OBJECT_ID('dbo.TestTable2') IS NOT NULL
	DROP TABLE dbo.TestTable2;
IF OBJECT_ID('dbo.TestSequence') IS NOT NULL
	DROP SEQUENCE dbo.TestSequence;

CREATE SEQUENCE dbo.TestSequence
AS int
START WITH 1
INCREMENT BY 1
NO CYCLE -- CYCLE to reuse values once we get to the largest value allowed by the data type, or NO CYCLE to raise an exception once the limit is reached.
CACHE 10; -- specify CACHE to obtain a specified number of values at once.

-- There are two ways to use the Sequence. We can go to the Sequence on each insert to get the next value, or we can use the Sequence as part of the table definition.

-- Not part of table definition

IF OBJECT_ID('dbo.TestTable1') IS NOT NULL
	DROP TABLE dbo.TestTable1;

CREATE TABLE TestTable1 (
RecordNumber int NOT NULL PRIMARY KEY,
DisplayName varchar(25) NOT NULL
)
GO

INSERT INTO TestTable1 (RecordNumber, DisplayName)
VALUES (NEXT VALUE FOR dbo.TestSequence, 'Record One');

INSERT INTO TestTable1 (RecordNumber, DisplayName)
VALUES (NEXT VALUE FOR dbo.TestSequence, 'Record Two');

SELECT * FROM TestTable1;

GO

-- Part of table definition

IF OBJECT_ID('dbo.TestTable2') IS NOT NULL
	DROP TABLE dbo.TestTable2;

CREATE TABLE TestTable2 (
RecordNumber int NOT NULL PRIMARY KEY DEFAULT(NEXT VALUE FOR dbo.TestSequence),
DisplayName varchar(25) NOT NULL
);

INSERT INTO TestTable2 (DisplayName)
VALUES ('Record Three');

SELECT * FROM TestTable2;

GO

---------------------------------------------------------
-- PERCENTILE_CONT and PERCENTILE_DISC functions
---------------------------------------------------------

IF OBJECT_ID('dbo.TestTable') IS NOT NULL
	DROP TABLE dbo.TestTable;

CREATE TABLE dbo.TestTable (
RecordId INT NOT NULL IDENTITY(1, 1),
GroupId INT NOT NULL,
TotalAmount INT NOT NULL
);

INSERT INTO dbo.TestTable(GroupId, TotalAmount) VALUES (1, 1);
INSERT INTO dbo.TestTable(GroupId, TotalAmount) VALUES (1, 2);
INSERT INTO dbo.TestTable(GroupId, TotalAmount) VALUES (2, 2);
INSERT INTO dbo.TestTable(GroupId, TotalAmount) VALUES (2, 3);
INSERT INTO dbo.TestTable(GroupId, TotalAmount) VALUES (2, 2);
INSERT INTO dbo.TestTable(GroupId, TotalAmount) VALUES (3, 1);
INSERT INTO dbo.TestTable(GroupId, TotalAmount) VALUES (3, 2);
INSERT INTO dbo.TestTable(GroupId, TotalAmount) VALUES (4, 3);
INSERT INTO dbo.TestTable(GroupId, TotalAmount) VALUES (4, 5);
INSERT INTO dbo.TestTable(GroupId, TotalAmount) VALUES (5, 5);
INSERT INTO dbo.TestTable(GroupId, TotalAmount) VALUES (5, 6);

GO

SELECT GroupId,
SUM(TotalAmount) as TotalAmountSum,
COUNT(GroupId) as GroupRecordCount
FROM dbo.TestTable
GROUP BY GroupId;

SELECT DISTINCT GroupId,
PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY TotalAmount) OVER (PARTITION BY GroupId) AS PercentContValue,
PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY TotalAmount) OVER (PARTITION BY GroupId) AS PercentDiscValue
FROM dbo.TestTable;

GO

--PERCENTILE_CONT – From BOL: ‘Calculates a percentile based on a continuous distribution of the column value ‘
--PERCENTILE_DISC – From BOL: ‘Computes a specific percentile for sorted values in an entire rowset or within distinct partitions of a rowset’

--The input for both functions is a percent, from 0.0 to 1.0. PERCENTILE_CONT will calculate the value to match the designated percentage for each group. 
--So in this example, using 0.5 will compute the median value.
--PERCENTILE_DISC will return an actual value from the group, not a calculated value. If a value from the group doesn’t match the ‘specific percentile’ 
--exactly (if there are an even number of values) the lower value will be returned.

---------------------------------------------------------
-- Analytic Functions -----------------------------------
---------------------------------------------------------

IF OBJECT_ID('dbo.TestTable') IS NOT NULL
	DROP TABLE dbo.TestTable;

CREATE TABLE dbo.TestTable (
RecordId INT NOT NULL IDENTITY(1, 1),
DisplayName VARCHAR(20) NOT NULL
);

INSERT INTO dbo.TestTable(DisplayName) VALUES ('Record 1');
INSERT INTO dbo.TestTable(DisplayName) VALUES ('Record 2');
INSERT INTO dbo.TestTable(DisplayName) VALUES ('Record 3');
INSERT INTO dbo.TestTable(DisplayName) VALUES ('Record 4');
INSERT INTO dbo.TestTable(DisplayName) VALUES ('Record 5');
INSERT INTO dbo.TestTable(DisplayName) VALUES ('Record 6');
INSERT INTO dbo.TestTable(DisplayName) VALUES ('Record 7');
INSERT INTO dbo.TestTable(DisplayName) VALUES ('Record 8');
INSERT INTO dbo.TestTable(DisplayName) VALUES ('Record 9');
INSERT INTO dbo.TestTable(DisplayName) VALUES ('Record 10');

SELECT RecordId,
	FIRST_VALUE(RecordId) OVER (ORDER BY RecordId ASC) AS FirstValue,
	LAST_VALUE(RecordId) OVER (ORDER BY RecordId ASC) AS LastValue,
	LEAD(RecordId) OVER (ORDER BY RecordId ASC) AS LeadValue,
	LAG(RecordId) OVER (ORDER BY RecordId ASC) AS LagValue,
	CUME_DIST() OVER (ORDER BY RecordId ASC) AS CumeDistValue,
	PERCENT_RANK() OVER (ORDER BY RecordId ASC) AS PercentRankValue
FROM TestTable;

--FIRST_VALUE – The value of the first record in the result set.
--LAST_VALUE – The value of the current record in the result set.
--LEAD – The value of the previous record in the result set.
--LAG – The value of the next record in the result set.
--CUME_DIST – cumulative distribution – From BOL ” the CUME_DIST of r is the number of rows with values lower than or equal to the value of r, 
--	divided by the number of rows evaluated in the partition or query result set.”
--PERCENT_RANK – The relative rank.

GO

---------------------------------------------------------
-- Various Functions ------------------------------------
---------------------------------------------------------

-- CHOOSE
--CHOOSE will return the value from a comma separated list of values in the position indicated by the first value supplied:
SELECT CHOOSE(3, 9, 8, 7, 6, 5);

-- IIF
-- The immediate if will evaluate a boolean expression and return the 2nd value if true, and the 3rd value if the expression is false.

DECLARE @Value int = 31
SELECT (IIF(@Value > 10, 'Greater than 10', 'Less than or equal to 10'));

-- CONCAT
-- CONCAT will concatenate a comma delimited list of values into one string. If the input values aren’t strings, then an implicit conversion 
-- will take place. NULL values are converted to empty length strings.

SELECT CONCAT(1, 2, 3, 4);

SELECT CONCAT('One', null, 2, '3');

-- EXECUTE WITH RESULT SETS
-- WITH RESULT SETS will let you redefine the output of a stored procedure, including renaming the columns. 
-- This can be useful when working with a stored procedure where you aren’t able to change the definition, or are concerned with breaking some 
-- existing mapping with result column names.

IF OBJECT_ID('dbo.sp_testproc') IS NOT NULL
	DROP PROCEDURE dbo.sp_testproc;
GO
CREATE PROCEDURE dbo.sp_testproc
AS
SELECT object_id, name, type_desc
FROM sys.tables;
GO

EXEC sp_testproc
WITH RESULT SETS ((
ObjectId int not null,
TableName varchar(128) not null,
TypeDescription varchar(20) not null
));
GO

-- TRY_CONVERT:
-- TRY_CONVERT will execute a CONVERT, but it will return NULL instead of raising an error if the conversion cannot be made.
SELECT CONVERT(xml, '<Invalid XML');

SELECT TRY_CONVERT(xml, '<Invalid XML');

SELECT TRY_CONVERT(xml, '<tag>Invalid XML</tag>');

-- If the conversion between two data types isn’t explicitly allowed, an exception will be raised.
SELECT TRY_CONVERT(image, 1);

--PARSE:
-- According to Books Online, parse should be used to convert from a string to datetime or numeric types. For other types of conversion, CONVERT is recommended.

SELECT CAST('Sunday, January 8, 2017 3:00 PM' AS datetime);
SELECT PARSE('Sunday, January 8, 2017 3:00 PM' AS datetime);

SELECT PARSE('11/13/2017 15:00' AS datetime USING 'en-US');
SELECT PARSE('13/11/2017 15:00' AS datetime USING 'en-GB');

-- TRY_PARSE:
-- The same as parse, but will return a NULL if the conversion can’t be made.

SELECT TRY_PARSE('tomorrow, Monday' AS datetime);

-- EOMONTH:
-- Before 2012, calculating the last day of the month usually involved some sort of hack, like going to the first day of the following month and then subtracting a day.
-- The new EOMONTH Will take a date or datetime as will return the last day of that month.
SELECT EOMONTH(GETDATE());

-- DATEFROMPARTS:
--This function will return a date from integers representing the year, month and day.
SELECT DATEFROMPARTS(2017, 1, 8);

-- FORMAT:
-- Format using .Net format values

SELECT FORMAT(GETDATE(), 'MMMM d, yyyy');

-- FORMAT can also be used with types other than dates

-- returns a percentage:
SELECT FORMAT(1, 'P');

-- Returns currency:
SELECT FORMAT(987.45, 'C');

-- Returns Hexadecimal:
SELECT FORMAT(100, 'X');

GO

