
-- List all tables in a database 
-- and order by size

dbcc UPDATEUSAGE (0); -- Current DB

create table Z_TableSize (
TableName varchar(128) not null,
CountOfRows int not null,
Reserved varchar(200) not null,
[Data] varchar(200) not null,
Index_Size varchar(200) not null,
Unused varchar(200) not null
);
go

create table Y_TableSize (
SchemaName varchar(128) not null,
TableName varchar(128) not null,
[Data] varchar(200) not null,
CountOfRows int not null
);
go

set nocount on;

declare Diff_Cursor cursor
   for 

select s.[Name] as SchemaName, t.[Name] as TableName
from sys.tables as t
join sys.schemas as s
	on s.schema_id = t.schema_id
where t.[Name] not in ('sysdiagrams', 'Z_TableSize');
	
declare @TableName nvarchar(128);
declare @SchemaName nvarchar(128);

open Diff_Cursor;

fetch next from Diff_Cursor into @SchemaName, @TableName;

while @@FETCH_STATUS = 0

begin
	delete from Z_TableSize;
	declare @FullTableName nvarchar(256) = @SchemaName + '.' + @TableName;
	insert Z_TableSize exec sp_spaceused @FullTableName;

	insert into Y_TableSize(SchemaName, TableName, [Data], CountOfRows)
	select @SchemaName, @TableName, [Data], CountOfRows
	from Z_TableSize;

	fetch next from Diff_Cursor into @SchemaName, @TableName;
end

close Diff_Cursor;

deallocate Diff_Cursor;

select SchemaName, TableName, [Data], CountOfRows
from Y_TableSize
order by cast((replace([Data], ' KB', '')) as int) desc;

drop table Z_TableSize;
drop table Y_TableSize;

go
