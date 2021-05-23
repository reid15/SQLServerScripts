
-- Change Data Capture

-- Table to track

USE TestDB;

DROP TABLE IF EXISTS dbo.CdcTest;

CREATE TABLE dbo.CdcTest(
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	RecordName varchar(10) NOT NULL UNIQUE,
	SortOrder tinyint NOT NULL,
	CreatedDate datetime NOT NULL DEFAULT GETDATE()
);

INSERT INTO dbo.CdcTest(RecordName, SortOrder) VALUES
('Record 1', 1),
('Record 2', 2),
('Record 3', 3);

SELECT * FROM dbo.CdcTest;

-- Enable CDC for database

EXEC sys.sp_cdc_enable_db;

-- Enable CDC for table
-- @role_name - Can set role to limit access to change data

EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'CdcTest', @role_name = NULL;

-- Table Changes

UPDATE dbo.CdcTest
SET SortOrder = 0
WHERE RecordName = 'Record 3';

SELECT * FROM dbo.CdcTest;

-- See CDC table

SELECT * FROM cdc.dbo_CdcTest_CT;

-- Query to see changes
-- Operation: 1 = Delete : 2 = Insert : 3 = Update (Before) : 4 = Update (after)

SELECT l.tran_begin_time, l.tran_end_time, __$operation, 
	c.Id, c.RecordName, c.SortOrder, c.CreatedDate,
	__$command_id
FROM cdc.dbo_CdcTest_CT as c
JOIN cdc.lsn_time_mapping as l
	ON l.start_lsn = c.__$start_lsn;

-- Function to retrieve net changes

SELECT * FROM cdc.fn_cdc_get_net_changes_dbo_CdcTest (0x0000002A000015170003, 0x0000002A000015170003, 'all');

-- Remove table

DROP TABLE IF EXISTS dbo.CdcTest;

-- Disable CDC for DB

EXEC sys.sp_cdc_disable_db;
