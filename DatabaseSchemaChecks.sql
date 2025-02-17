
-- Check for disabled or not trusted database objects.
-- Check for tables without primary keys and/or clustered indexes.
-- For Selected tests, GeneratedSql will return SQL to correct the issue.

SELECT OBJECT_NAME(OBJECT_ID) + '.' + [Name] as ObjectName, 'Foreign Key' as ObjectType, 
	'Disabled Foreign Key' as Issue, 
	'ALTER TABLE [' + OBJECT_NAME(parent_OBJECT_ID) + '] WITH CHECK CHECK CONSTRAINT [' + [Name] + '];' as GeneratedSql 
FROM sys.foreign_keys
WHERE is_disabled = 1

UNION ALL

SELECT OBJECT_NAME(OBJECT_ID) + '.' + [Name] as ObjectName, 'Foreign Key' as ObjectType,
	'Foreign Key Not Trusted' as Issue, 
	'ALTER TABLE [' + OBJECT_NAME(parent_OBJECT_ID) + '] WITH CHECK CHECK CONSTRAINT [' + [Name] + '];' as GeneratedSql 
FROM sys.foreign_keys
WHERE is_not_trusted = 1 AND is_disabled = 0

UNION ALL

SELECT OBJECT_NAME(parent_obj) + '.' + [Name] as ObjectName, 'Trigger' as ObjectType, 'Disabled Trigger' as Issue, 
	'ALTER TABLE [' + OBJECT_NAME(parent_obj) + '] ENABLE TRIGGER [' + [Name] + '];' as GeneratedSql
FROM dbo.sysobjects WHERE XType = 'TR'
and objectproperty(ID, 'ExecIsTriggerDisabled') = 1

UNION ALL

SELECT OBJECT_NAME(cc.parent_OBJECT_ID) + '.' + cc.name as ObjectName, 'Check Constraint' as ObjectType,
	'Constraint Not Trusted' as Issue, '' as GeneratedSql
FROM sys.check_constraints as cc
WHERE cc.is_not_trusted = 1

UNION ALL

SELECT OBJECT_NAME(cc.parent_OBJECT_ID) + '.' + cc.name as ObjectName, 'Check Constraint' as ObjectType,
	'Constraint Disabled' as Issue, 'ALTER TABLE [' + OBJECT_NAME(cc.parent_OBJECT_ID) + '] WITH CHECK CHECK CONSTRAINT [' + cc.name + '];' as GeneratedSql
FROM sys.check_constraints as cc
WHERE cc.is_disabled = 1

UNION ALL

-- Only return check for No Clustered Index if table has a primary key

SELECT CONCAT(SCHEMA_NAME(t.SCHEMA_ID), '.', t.[Name]) as TableName, 'Table' as ObjectType, 'No Clustered Index' as Issue, 
	'' as GeneratedSql 
FROM sys.tables as t
JOIN sys.indexes as pk
	ON pk.OBJECT_ID = t.OBJECT_ID
	AND pk.is_primary_key = 1
LEFT JOIN sys.indexes as i
	ON i.OBJECT_ID = t.OBJECT_ID
	AND i.type = 1 -- Clustered
WHERE i.OBJECT_ID IS NULL

UNION ALL

SELECT CONCAT(SCHEMA_NAME(t.SCHEMA_ID), '.', t.[Name]) as ObjectName, 'Table' as ObjectType, 'No Primary Key' as Issue, 
	CONCAT('ALTER TABLE [', SCHEMA_NAME(t.SCHEMA_ID), '].[', t.[name], '] ADD CONSTRAINT ',
	'[PK_', SCHEMA_NAME(t.SCHEMA_ID), t.[Name], '] PRIMARY KEY CLUSTERED (<column>);') as GeneratedSql 
FROM sys.tables as t
LEFT JOIN sys.key_constraints as c
	ON c.parent_OBJECT_ID = t.[OBJECT_ID]
WHERE c.parent_OBJECT_ID IS NULL

UNION ALL

SELECT [Name] as ObjectName, [Type] as ObjectType, 'ANSI NULLS Off' as Issue, '' as GeneratedSql
FROM sys.objects 
WHERE [Type] IN ('TR', 'P', 'FN', 'IF', 'TF', 'U')
	AND OBJECTPROPERTY (OBJECT_ID,'IsAnsiNullsOn') = 0

UNION ALL

SELECT s.[Name] AS SchemaName, 'Schema' AS ObjectType, 'Empty Schema' AS Issue,
	CONCAT('DROP SCHEMA [', s.[name], '];') AS GeneratedSql
FROM sys.schemas AS s
JOIN sys.database_principals AS p
	ON p.principal_id = s.principal_id
LEFT JOIN sys.objects AS o
	ON o.schema_id = s.schema_id
WHERE p.is_fixed_role = 0
	AND s.[name] NOT IN ('guest', 'INFORMATION_SCHEMA', 'sys', 'dbo')
	AND o.[name] IS NULL

ORDER BY 1

GO
