
-- Generate SQL to remove all foreign keys in a database

declare @SQL nvarchar(max);

select @SQL = coalesce(@SQL, '') + 'alter table ' + schema_name(t.schema_id) + '.' + t.[Name] +	
	' drop constraint ' + f.[name] + ';'
from sys.foreign_keys as f
join sys.tables as t
	on t.object_id = f.parent_object_id;

exec sp_executesql @SQL;

go


