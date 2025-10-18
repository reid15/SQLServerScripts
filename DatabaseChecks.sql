
-- Return potential issues with a database

DROP TABLE IF EXISTS #Issues;

CREATE TABLE #Issues(
	SchemaName VARCHAR(128) not null,
	ObjectName VARCHAR(128) not null,
	ObjectType VARCHAR(50) not null,
	Issue VARCHAR(50) not null
);

-- Check all tables have a primary key

INSERT INTO #Issues(SchemaName, ObjectName, ObjectType, Issue)
SELECT s.[Name] as SchemaName, t.[Name] as TableName, 'Table' as ObjectType, 'No Primary Key' as Issue 
FROM sys.tables as t
JOIN sys.schemas as s
	ON s.schema_id = t.schema_id
LEFT JOIN sys.key_constraints as k
	ON k.parent_object_id = t.Object_Id
	AND k.[Type] = 'PK'
WHERE k.object_id is null
	AND t.is_ms_shipped = 0;

-- Space in column names

INSERT INTO #Issues(SchemaName, ObjectName, ObjectType, Issue)
SELECT s.[Name] as SchemaName, t.[Name] + '.' +  c.[Name] as ColumnName, 'Column' as ObjectType, 'Space In Column Name' as Issue
FROM sys.columns as c
JOIN sys.tables as t
	ON t.object_id = c.object_id
JOIN sys.schemas as s
	ON s.schema_id = t.schema_id
WHERE c.[Name] like '% %'
	AND t.is_ms_shipped = 0;

-- Numbers in column names

INSERT INTO #Issues(SchemaName, ObjectName, ObjectType, Issue)
SELECT s.[Name] as SchemaName, t.[Name] + '.' +  c.[Name] as ColumnName, 'Column' as ObjectType, 'Number In Column Name' as Issue
FROM sys.columns as c
JOIN sys.tables as t
	ON t.object_id = c.object_id
JOIN sys.schemas as s
	ON s.schema_id = t.schema_id
WHERE c.[Name] like '%[0-9]%'
	AND t.is_ms_shipped = 0;

-- Brackets/Quotes in column names

INSERT INTO #Issues(SchemaName, ObjectName, ObjectType, Issue)
SELECT s.[Name] as SchemaName, t.[Name] + '.' +  c.[Name] as ColumnName, 'Column' as ObjectType, 'Bracket/Quote In Column Name' as Issue
FROM sys.columns as c
JOIN sys.tables as t
	ON t.object_id = c.object_id
JOIN sys.schemas as s
	ON s.schema_id = t.schema_id
WHERE t.is_ms_shipped = 0
	AND (
		c.[Name] like '%/[%' ESCAPE '/'
		OR c.[Name] like '%/]%' ESCAPE '/'
		OR c.[Name] like '%''%' 
		OR c.[Name] like '%"%'
	);


-- Space in object name

INSERT INTO #Issues(SchemaName, ObjectName, ObjectType, Issue)
SELECT s.[Name] as SchemaName, o.[Name] as ObjectName, o.type_desc as ObjectType, 'Space In Object Name' as Issue
FROM sys.objects as o
JOIN sys.schemas as s
	ON s.schema_id = o.schema_id
WHERE o.[Name] like '% %'
	AND o.is_ms_shipped = 0;

-- Number in object name

INSERT INTO #Issues(SchemaName, ObjectName, ObjectType, Issue)
SELECT s.[Name] as SchemaName, o.[Name] as ObjectName, o.type_desc as ObjectType, 'Number In Object Name' as Issue
FROM sys.objects as o
JOIN sys.schemas as s
	ON s.schema_id = o.schema_id
WHERE o.[Name] like '%[0-9]%'
	AND o.[Type] in ('U', 'V', 'P')
	AND o.is_ms_shipped = 0;

-- Brackets/Quotes in object name

INSERT INTO #Issues(SchemaName, ObjectName, ObjectType, Issue)
SELECT s.[Name] as SchemaName, o.[Name] as ObjectName, o.type_desc as ObjectType, 'Brackets/Quotes In Object Name' as Issue
FROM sys.objects as o
JOIN sys.schemas as s
	ON s.schema_id = o.schema_id
WHERE o.[Type] in ('U', 'V', 'P')
	AND o.is_ms_shipped = 0
	AND (
		o.[Name] like '%/[%' ESCAPE '/'
		OR o.[Name] like '%/]%' ESCAPE '/'
		OR o.[Name] like '%''%' 
		OR o.[Name] like '%"%'
	);

-- Disabled Foreign Key

INSERT INTO #Issues(SchemaName, ObjectName, ObjectType, Issue)
SELECT s.[Name], t.[Name] + '.' + f.[Name], 'Foreign Key', 'Disabled Foreign Key' 
FROM sys.foreign_keys as f
JOIN sys.tables as t
	ON t.object_id = f.parent_object_id
JOIN sys.schemas as s
	ON s.schema_id = t.schema_id
WHERE f.is_ms_shipped = 0
	AND f.is_disabled = 1;

-- Not Trusted Foreign Key

INSERT INTO #Issues(SchemaName, ObjectName, ObjectType, Issue)
SELECT s.[Name], t.[Name] + '.' + f.[Name], 'Foreign Key', 'Not Trusted Foreign Key' 
FROM sys.foreign_keys as f
JOIN sys.tables as t
	ON t.object_id = f.parent_object_id
JOIN sys.schemas as s
	ON s.schema_id = t.schema_id
WHERE f.is_ms_shipped = 0
	AND f.is_not_trusted = 1;

-- System Named Foreign Key

INSERT INTO #Issues(SchemaName, ObjectName, ObjectType, Issue)
SELECT s.[Name], t.[Name] + '.' + f.[Name], 'Foreign Key', 'System Named Foreign Key' 
FROM sys.foreign_keys as f
JOIN sys.tables as t
	ON t.object_id = f.parent_object_id
JOIN sys.schemas as s
	ON s.schema_id = t.schema_id
WHERE f.is_ms_shipped = 0
	AND f.is_system_named = 1;

-- Disabled Check Constraint

INSERT INTO #Issues(SchemaName, ObjectName, ObjectType, Issue)
SELECT s.[Name], t.[Name] + '.' + f.[Name], 'Check Constraint', 'Disabled Check Constraint' 
FROM sys.check_constraints as f
JOIN sys.tables as t
	ON t.object_id = f.parent_object_id
JOIN sys.schemas as s
	ON s.schema_id = t.schema_id
WHERE f.is_ms_shipped = 0
	AND f.is_disabled = 1;

-- Not Trusted Check Constraint

INSERT INTO #Issues(SchemaName, ObjectName, ObjectType, Issue)
SELECT s.[Name], t.[Name] + '.' + f.[Name], 'Check Constraint', 'Not Trusted Check Constraint' 
FROM sys.check_constraints as f
JOIN sys.tables as t
	ON t.object_id = f.parent_object_id
JOIN sys.schemas as s
	ON s.schema_id = t.schema_id
WHERE f.is_ms_shipped = 0
	AND f.is_not_trusted = 1;

-- System Named Check Constraint

INSERT INTO #Issues(SchemaName, ObjectName, ObjectType, Issue)
SELECT s.[Name], t.[Name] + '.' + f.[Name], 'Check Constraint', 'System Named Check Constraint' 
FROM sys.check_constraints as f
JOIN sys.tables as t
	ON t.object_id = f.parent_object_id
JOIN sys.schemas as s
	ON s.schema_id = t.schema_id
WHERE f.is_ms_shipped = 0
	AND f.is_system_named = 1;

-- System Named Default Constraint

INSERT INTO #Issues(SchemaName, ObjectName, ObjectType, Issue)
SELECT s.[Name], t.[Name] + '.' + f.[Name], 'Default', 'System Named Default' 
FROM sys.default_constraints as f
JOIN sys.tables as t
	ON t.object_id = f.parent_object_id
JOIN sys.schemas as s
	ON s.schema_id = t.schema_id
WHERE f.is_ms_shipped = 0
	AND f.is_system_named = 1;

-- Tables with no rows

INSERT INTO #Issues(SchemaName, ObjectName, ObjectType, Issue)
SELECT s.[Name], t.[Name], 'Table', 'Empty Table'
FROM sys.partitions as p
JOIN sys.tables as t
	ON t.object_id = p.object_id
JOIN sys.schemas as s
	ON s.schema_id = t.schema_id
WHERE t.is_ms_shipped = 0
	AND p.index_id between 0 AND 1
GROUP BY s.[Name], t.[Name]
HAVING sum(p.rows) = 0

-- Deprecated data types

INSERT INTO #Issues(SchemaName, ObjectName, ObjectType, Issue)
SELECT s.[Name] as SchemaName, t.[Name] + '.' +  c.[Name] as ColumnName, 'Column' as ObjectType, 
	'Deprecated Data Type: ' + ty.[Name] as Issue
FROM sys.columns as c
JOIN sys.tables as t
	ON t.object_id = c.object_id
JOIN sys.schemas as s
	ON s.schema_id = t.schema_id
JOIN sys.types as ty
	ON ty.user_type_id = c.user_type_id
WHERE ty.[Name] in ('image', 'text', 'ntext', 'timestamp')
	AND t.is_ms_shipped = 0;

INSERT INTO #Issues(SchemaName, ObjectName, ObjectType, Issue)
SELECT s.[Name] as SchemaName, t.[Name] + '.' +  c.[Name] as ColumnName, 'Column' as ObjectType, 
	'Unadvised Data Type: ' + ty.[Name] as Issue
FROM sys.columns as c
JOIN sys.tables as t
	ON t.object_id = c.object_id
JOIN sys.schemas as s
	ON s.schema_id = t.schema_id
JOIN sys.types as ty
	ON ty.user_type_id = c.user_type_id
WHERE ty.[Name] in ('float', 'sql_variant')
	AND t.is_ms_shipped = 0;
	
-- Return Issues

SELECT SchemaName, ObjectName, ObjectType, Issue
FROM #Issues
ORDER BY Issue, SchemaName, ObjectName;

GO
