
-- Drop all user objects in a specified schema

USE RoundHouseETL;

set nocount on;

DECLARE @SchemaName nvarchar(20) = 'LNP';

DROP TABLE IF EXISTS #Objects;

CREATE TABLE #Objects(
[type] nvarchar(100) NOT NULL,
[name] nvarchar(100) NOT NULL,
parent_object_id int NULL
);

INSERT INTO #Objects([type], [name], parent_object_id)
SELECT [type], [name], parent_object_id
FROM sys.objects as o
WHERE o.is_ms_shipped = 0 
	AND o.[type] not in ('D', 'PK', 'C', 'UQ', 'TR')
	AND SCHEMA_NAME(o.schema_id) = @SchemaName;

declare Diff_Cursor cursor
   for 

select 
	case 
		when [type] = N'F' then 'alter table [' + @SchemaName + '].[' + object_name(parent_object_id) + '] ' +  
		  'drop constraint [' + [name] + ']'
		when [type] = N'U' then 'drop table [' + @SchemaName + '].[' + [name] + ']' 
		when [type] = N'P' then 'drop procedure [' + @SchemaName + '].[' + [name] + ']'
		when [type] = N'V' then 'drop view [' + @SchemaName + '].[' + [name] + ']'
		when [type] in (N'FN', N'TF', N'FT') then 'drop function [' + @SchemaName + '].[' + [name] + ']'
		else '_' + [type] + ':' + [name] end as DropSQL,
	case when [type] in (N'FN', N'TF') then 2
		when [type] = N'F' then 0
		else 1 end as SortOrder
from #Objects as o
--union all
--select 'drop type [' + [name] + ']' as DropSQL, 2 as SortOrder
--from sys.types
--where is_user_defined = 1
order by 2

declare @SQL nvarchar(4000)
declare @SortOrder tinyint

open Diff_Cursor

fetch next from Diff_Cursor into @SQL, @SortOrder

while @@FETCH_STATUS = 0

begin
	print @SQL
	--exec sp_executesql @SQL

	fetch next from Diff_Cursor into @SQL, @SortOrder
end

close Diff_Cursor

deallocate Diff_Cursor

go

