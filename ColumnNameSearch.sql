
-- Search Column Names for the specified pattern

SELECT SCHEMA_NAME(t.schema_Id) as SchemaName, t.[Name] as TableName, c.[Name] as ColumnName
FROM sys.columns as c
JOIN sys.tables as t
ON t.object_id = c.object_id
WHERE c.[name] LIKE '%ID%'
ORDER BY SCHEMA_NAME(t.schema_Id), t.[Name], c.[Name];

GO