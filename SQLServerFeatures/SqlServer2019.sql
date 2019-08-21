
-- SQL Server 2019

-- Table Veriable Deferred Compilation
-- Generate actual execution plan and compare between 2019 and an earlier version

DECLARE @TableVariable as TABLE (ID int not null primary key);

INSERT INTO @TableVariable
SELECT object_id 
FROM sys.objects;

SELECT * FROM @TableVariable;

-- APPROX_COUNT_DISTINCT

DROP TABLE IF EXISTS TestCount;
CREATE TABLE TestCount (ID int not null);

DECLARE @Counter int = 1;
WHILE @Counter < 10000
	BEGIN
		INSERT INTO TestCount(ID) 
		SELECT object_id 
		FROM sys.objects;

		SET @Counter+= 1;
	END

SELECT COUNT(DISTINCT ID) FROM TestCount;
SELECT APPROX_COUNT_DISTINCT(ID) FROM TestCount;

-- SENSITIVITY CLASSIFICATION

DROP TABLE IF EXISTS dbo.TestClassification;

CREATE TABLE dbo.TestClassification(
FirstName varchar(30) not null,
LastName varchar(30) not null,
SSN char(9) not null,
BirthDate date null,
CreditCardNumber varchar(16) null
);

ADD SENSITIVITY CLASSIFICATION TO dbo.TestClassification.SSN
WITH (LABEL='Confidential', INFORMATION_TYPE='SSN');

ADD SENSITIVITY CLASSIFICATION TO dbo.TestClassification.CreditCardNumber
WITH (LABEL='Confidential', INFORMATION_TYPE='Credit Card');

SELECT * FROM sys.sensitivity_classifications;

-- UTF-8 Support

DROP TABLE IF EXISTS dbo.TestUTF;

CREATE TABLE dbo.TestUTF(
ID int NOT NULL PRIMARY KEY IDENTITY(1,1),
FirstName varchar(10) COLLATE Latin1_General_100_CI_AI_SC_UTF8 NOT NULL
);

INSERT INTO dbo.TestUTF(FirstName) VALUES ('Linda');
INSERT INTO dbo.TestUTF(FirstName) VALUES ('Matías');
INSERT INTO dbo.TestUTF(FirstName) VALUES ('Zoë');

SELECT Id, FirstName, LEN(FirstName) as NameLength, DATALENGTH(FirstName) as NameDataLength
FROM dbo.TestUTF;

-- String Truncation
-- 2019 will return the column and value that is being truncated, instead of the
-- generic message of older versions

INSERT INTO dbo.TestUTF(FirstName) VALUES ('Bartholomew');

GO














