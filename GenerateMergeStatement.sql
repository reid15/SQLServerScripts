
-- Generate MERGE statement for specified table
-- Assumes there is a one column primary key

declare @TableName nvarchar(128) = N'Schema.Table';
declare @KeyColumn nvarchar(128) = N'Column';

declare Diff_Cursor cursor fast_forward read_only
   for 

select c.name
from sys.columns as c
where c.object_id = object_id(@TableName)
order by c.column_id;

declare @ColumnName varchar(128);
declare @ColumnList varchar(max) = '';
declare @UpdateColumnList varchar(max) = '';
declare @UnequalColumnList varchar(max) = '';
declare @SourceColumnList varchar(max) = '';
declare @ColumnListLineLength tinyint = 0

open Diff_Cursor

fetch next from Diff_Cursor into @ColumnName

while @@FETCH_STATUS = 0

begin
	if len(@ColumnList) > 0
	  begin
		set @ColumnList = @ColumnList + ', '
		set @SourceColumnList = @SourceColumnList + ', '
	  end

	if ((len(@UpdateColumnList) > 0) and (@ColumnName <> @KeyColumn))
		set @UpdateColumnList = @UpdateColumnList + ',' + char(13) + char(10);

	set @ColumnList = @ColumnList + @ColumnName;
	set @SourceColumnList = @SourceColumnList + 'source.' + @ColumnName;

	if @ColumnName <> @KeyColumn
	  begin
		set @UpdateColumnList = @UpdateColumnList + @ColumnName + ' = source.' + @ColumnName;
		if len(@UnequalColumnList) > 0
			set @UnequalColumnList = @UnequalColumnList + char(13) + char(10) + 'or ';
		set @UnequalColumnList = @UnequalColumnList + 'target.' + @ColumnName + ' <> source.' + @ColumnName;
	  end

	set @ColumnListLineLength = @ColumnListLineLength + len(@ColumnName);

	if @ColumnListLineLength > 80
	  begin
		set @ColumnList = @ColumnList + char(13) + char(10);
		set @SourceColumnList = @SourceColumnList + char(13) + char(10);
		set @ColumnListLineLength = 0;
	  end

	fetch next from Diff_Cursor into @ColumnName

end

close Diff_Cursor
deallocate Diff_Cursor

print 'merge ' + @TableName + ' as target';
print 'using (select ';
print @ColumnList;
print 'from ' + @TableName;
print ') as source';
print 'on target.' + @KeyColumn + ' = source.' + @KeyColumn;
print 'when matched and ((';
print @UnequalColumnList;
print ')) then';
print 'update set';
print @UpdateColumnList;
print 'when not matched then';
print 'insert (';
print @ColumnList;
print ') values (';
print @SourceColumnList;
print ');';

go

