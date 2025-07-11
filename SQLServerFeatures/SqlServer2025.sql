
-- SQL Server 2025 - New T-SQL features
-- 2025 evaluation edition (17.0.700.9) - July 5, 2025
--
-- SQL Rob - Blog post on new features
-- https://sqlrob.wordpress.com/2025/07/03/sql-server-2025-new-t-sql-features-part-1
--
-- Microsoft - What is new in SQL Server 2025
-- https://learn.microsoft.com/en-us/sql/sql-server/what-s-new-in-sql-server-2025

-- Regular Expressions -----------------------------------------------------------------------------------------------------
-- Use regular expressions to find matches in column values

-- Test Data

DROP TABLE IF EXISTS #EmailTest;

CREATE TABLE #EmailTest (Email VARCHAR(100) NOT NULL);

INSERT INTO #EmailTest(Email)
VALUES 
('example@example.com'),
('example1@example.com'),
('EXAMPLE@example.com'),
('example@example.c'),
('example.com'),
('example');

-- Find Matches - Default is Case insensitive

SELECT Email FROM #EmailTest WHERE REGEXP_LIKE(Email, '([a-z0-9]+@[a-z]+\.[a-z]{2,})');

-- Find matches - Case sensitive

SELECT Email FROM #EmailTest WHERE REGEXP_LIKE(Email, '([a-z0-9]+@[a-z]+\.[a-z]{2,})', 'c');

-- Find Matches - Case insensitive

SELECT Email FROM #EmailTest WHERE REGEXP_LIKE(Email, '([a-z0-9]+@[a-z]+\.[a-z]{2,})', 'i');

GO

-- Fuzzy match -------------------------------------------------------------------------------------------------------------
-- Return values specifying how similar two strings are to one another

SELECT EDIT_DISTANCE_SIMILARITY('Attitude', 'Attitude'); -- 100

SELECT EDIT_DISTANCE_SIMILARITY('Attitude', 'Altitude'); -- 88

SELECT EDIT_DISTANCE_SIMILARITY('Zero', 'One'); -- 0

SELECT EDIT_DISTANCE('Attitude', 'Attitude'); -- 0

SELECT EDIT_DISTANCE('Attitude', 'Altitude'); -- 1

SELECT EDIT_DISTANCE('Zero', 'One'); -- 4

-- JARO_WINKLER_DISTANCE - JARO_WINKLER_SIMILARITY

GO

-- REST Calls --------------------------------------------------------------------------------------------------------------
-- Call to a REST endpoint within a query

--Permission:
GRANT EXECUTE ANY EXTERNAL ENDPOINT TO [dbo];

--Enable:
EXECUTE sp_configure 'external rest endpoint enabled', 1;
RECONFIGURE WITH OVERRIDE;

-- Call REST endpoint - No login or payload passed in
-- @headers and @payload parameters take JSON inputs

DECLARE @ReturnCode AS INT;
DECLARE @Response AS NVARCHAR (MAX);

EXECUTE
    @ReturnCode = sp_invoke_external_rest_endpoint
    @url = N'https://date.nager.at/api/v3/publicholidays/2025/US',
    @method = 'GET',
    @response = @response OUTPUT;

SELECT @ReturnCode AS ReturnCode,
       @Response AS Response;

GO

-- Vector Data Type --------------------------------------------------------------------------------------------------------
-- Data type to store arrays of float values

DROP TABLE IF EXISTS #VectorExample;

CREATE TABLE #VectorExample(
	Id INT NOT NULL IDENTITY(1,1),
	VectorValue VECTOR(5) NOT NULL
);

INSERT INTO #VectorExample(VectorValue)
VALUES ('[1, 2, 3, 4, 5]');

INSERT INTO #VectorExample(VectorValue)
VALUES (JSON_ARRAY(6, 7, 8, 9, 10));

SELECT * FROM #VectorExample;

GO

-- JSON Data Type ----------------------------------------------------------------------------------------------------------
-- Instead of using VARCHAR, JSON documents can be stored with a dedicated data type - Document must be valid JSON

DROP TABLE IF EXISTS #JsonTest;

CREATE TABLE #JsonTest(
   ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
   Document JSON NOT NULL
);

INSERT INTO #JsonTest(Document)
VALUES ('{ "name": "Jane Doe", "ID": 1, "Location": "Atlanta, GA, USA" }');

-- Invalid JSON - Insert will fail

INSERT INTO #JsonTest(Document)
VALUES ('{ "name": Jane Doe, "ID": 1, "Location": "Atlanta, GA, USA" }');

SELECT * FROM #JsonTest;

GO

-- Modify a value within JSON document

UPDATE #JsonTest SET
    Document.Modify('$.Location', 'Chattanooga, TN, USA')
WHERE ID = 1;

SELECT * FROM #JsonTest;

-- Existing JSON functions will accept the JSON data type

-- Return 1 if document is valid JSON

SELECT ID, Document, ISJSON(Document) AS [IsJSON]
FROM #JsonTest;

-- Parse document into one row for each attribute

DECLARE @Document JSON;
SELECT @Document = Document FROM #JsonTest WHERE ID = 1;
SELECT * FROM OpenJSON(@Document);

GO

-- Product -----------------------------------------------------------------------------------------------------------------
-- Multiply all values in the specified column and return result

DROP TABLE IF EXISTS #ProductTest;

CREATE TABLE #ProductTest ([Value] INT NULL);

INSERT INTO #ProductTest ([Value])
VALUES
    (2), (4), (6), (8), (NULL);

SELECT PRODUCT([Value]) AS ValueProduct -- Returns 384
FROM #ProductTest;

GO

----------------------------------------------------------------------------------------------------------------------------
