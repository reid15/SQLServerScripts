

-- Change the owner of a DB to SA

use [Master]
go

set nocount on

declare Diff_Cursor cursor
   for 

select [Name] as DBName, suser_sname (owner_sid)
from sys.databases
where suser_sname (owner_sid) <> 'sa'
and state_desc = 'ONLINE'

declare @DBName varchar(128)
declare @SQL nvarchar(2000)

open Diff_Cursor

fetch next from Diff_Cursor into @DBName

while @@FETCH_STATUS = 0

begin
	set @SQL = 'use [' + @DBName + ']' + char(13) + char(10)
	set @SQL = @SQL + 'exec sp_changedbowner ''sa''' + char(13) + char(10)
	set @SQL = @SQL + char(13) + char(10)
	
	exec sp_executesql @SQL

	fetch next from Diff_Cursor into @DBName

end

close Diff_Cursor

deallocate Diff_Cursor

select [Name] as DBName, SUSER_SNAME (owner_sid) as DBOwner
from sys.databases
where state_desc = 'ONLINE'
order by [Name]

go


