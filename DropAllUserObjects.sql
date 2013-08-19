

-- Drop all user created objects in a database.
-- Drop foreign keys first, functions and types last.

set nocount on

declare Diff_Cursor cursor
   for 

select case when [XType] = 'F' then 'alter table [' + object_name(parent_obj) + '] ' +  
		  'drop constraint [' + [name] + ']'
	when [XType] = 'U' then 'drop table [' + [name] + ']' 
	when [XType] = 'P' then 'drop procedure [' + [name] + ']'
	when [XType] = 'V' then 'drop view [' + [name] + ']'
	when [XType] in ('FN', 'TF', 'FT') then 'drop function [' + [name] + ']'
	else '_' + [XType] + ':' + [name] end as DropSQL,
	case when [XType] in ('FN', 'TF') then 2
	when [XType] = 'F' then 0
	else 1 end as SortOrder
from sysobjects
where objectproperty([ID], 'IsMSShipped') = 0 and
	[XType] not in ('D', 'PK', 'C', 'UQ', 'TR')
union all
select 'drop type [' + [name] + ']' as DropSQL, 2 as SortOrder
from sys.types
where is_user_defined = 1
order by 2

declare @SQL nvarchar(4000)
declare @SortOrder tinyint

open Diff_Cursor

fetch next from Diff_Cursor into @SQL, @SortOrder

while @@FETCH_STATUS = 0

begin
	print @SQL
	exec sp_executesql @SQL

	fetch next from Diff_Cursor into @SQL, @SortOrder
end

close Diff_Cursor

deallocate Diff_Cursor

go
