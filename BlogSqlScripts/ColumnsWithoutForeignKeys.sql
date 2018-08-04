

-- Find columns without a foreign key
-- Can specify to only look at columns with an integer data type

declare @NumericOnly bit = 1

select t.name as TableName, c.name as ColumnName
from sys.columns as c
join sys.tables as t
	on t.object_id = c.object_id
	and t.is_ms_shipped = 0
join sys.types as s
	on s.user_type_id = c.user_type_id
left join sys.foreign_key_columns as f
	on f.parent_object_id = c.object_id
	and f.parent_column_id = c.column_id
left join sys.foreign_key_columns as f2
	on f2.referenced_object_id = c.object_id
	and f2.referenced_column_id = c.column_id
where f.parent_object_id is null
	and f2.referenced_object_id is null
	and ((@NumericOnly = 0) or (s.name in ('int', 'smallint', 'tinyint', 'bigint')))
order by t.name, c.column_id

go

