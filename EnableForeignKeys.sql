

-- Enable or disable all foreign keys in a database
-- Can check exsiting data
-- Will fail on any violations

declare @EnableFK bit
declare @CheckExistingData bit

set @EnableFK = 1 -- 1 = enable keys, 0 = disable keys
set @CheckExistingData = 1 -- only matters if @EnableFK=1, 1=check existing data, 0=don't check existing data

declare @DisableSQL nvarchar(100)
declare @Action nvarchar(100)

if @EnableFK = 1 
  begin
	if @CheckExistingData = 1 
		set @DisableSQL = 'with check check'
	else
		set @DisableSQL = 'check'
	set @Action = 'ENABLE'
  end
else
  begin
	set @DisableSQL = 'nocheck'
	set @Action = 'DISABLE'
  end

declare FK_Cursor cursor
   for 

-- Return all foreign keys in a DB
select f.[Name] as ForeignKeyName, object_name(f.parent_object_id) as TableName,
	s.name as SchemaName
from sys.foreign_keys as f
join sys.schemas as s
	on s.schema_id = f.schema_id
-- where f.is_disabled = 1 -- To return only disabled keys

declare @ForeignKeyName nvarchar(128)
declare @TableName nvarchar(128)
declare @SchemaName nvarchar(128)
declare @SQL nvarchar(2000)

open FK_Cursor

fetch next from FK_Cursor into @ForeignKeyName, @TableName, @SchemaName

while @@FETCH_STATUS = 0

begin
	set @SQL = 'alter table [' + @SchemaName + '].[' + @TableName + '] ' + @DisableSQL + ' constraint [' + @ForeignKeyName + ']'

	exec sp_executesql @SQL
	print @Action + ' ' + @TableName + '.' + @ForeignKeyName

	fetch next from FK_Cursor into @ForeignKeyName, @TableName, @SchemaName
end

close FK_Cursor

deallocate FK_Cursor

go
