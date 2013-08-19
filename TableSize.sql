

-- List all tables in a database 
-- and order by size

DBCC UPDATEUSAGE (0) -- Current DB
go

create table Z_TableSize (
TableName varchar(128) not null,
CountOfRows int not null,
Reserved varchar(200) not null,
Data varchar(200) not null,
Index_Size varchar(200) not null,
Unused varchar(200) not null
)
go

SET NOCOUNT ON

DECLARE Diff_Cursor CURSOR
   FOR 

select [Name] AS TableName
from sys.tables
where [Name] not in ('sysdiagrams', 'Z_TableSize')
	
DECLARE @TableName Nvarchar(128)

OPEN Diff_Cursor

FETCH NEXT FROM Diff_Cursor INTO @TableName

WHILE @@FETCH_STATUS = 0

BEGIN
	
	insert Z_TableSize exec sp_spaceused @TableName

	FETCH NEXT FROM Diff_Cursor INTO @TableName
END

CLOSE Diff_Cursor

DEALLOCATE Diff_Cursor

select TableName, Data, CountOfRows
from Z_TableSize
order by cast((replace(Data, ' KB', '')) as int) desc

drop table Z_TableSize

go
