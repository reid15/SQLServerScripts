
declare Diff_Cursor cursor fast_forward read_only
   for 

select 1

declare @DBName varchar(128)
declare @SQL nvarchar(2000)

open Diff_Cursor

fetch next from Diff_Cursor into @DBName

while @@FETCH_STATUS = 0

begin
	set @SQL = 'use [' + @DBName + ']' + char(13) + char(10)
	
	print @SQL

	fetch next from Diff_Cursor into @DBName

end

close Diff_Cursor
deallocate Diff_Cursor
go
