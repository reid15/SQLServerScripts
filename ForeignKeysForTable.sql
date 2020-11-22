
-- Find Foreign Keys for a table

DECLARE @SchemaName nvarchar(128) = 'VIN';
DECLARE @TableName nvarchar(128) = 'BodyType';
 
SELECT SCHEMA_NAME(t.schema_Id) as SchemaName, t.[name] as TableName, 
	SCHEMA_NAME(rt.schema_Id) as ReferencedSchemaName, rt.[name] as ReferencedTableName,
    f.[name] as ForeignKeyName, f.is_disabled, f.is_not_trusted
FROM sys.foreign_keys as f
JOIN sys.tables as t
    on t.object_id = f.parent_object_id
JOIN sys.tables as rt
    on rt.object_id = f.referenced_object_id
WHERE (t.[name] = @TableName AND SCHEMA_NAME(t.schema_Id) = @SchemaName)
    OR (rt.[name] = @TableName AND SCHEMA_NAME(rt.schema_Id) = @SchemaName)
ORDER BY t.[name], rt.[name], f.[name];

GO