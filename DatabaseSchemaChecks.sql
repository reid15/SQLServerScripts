

-- Check for disabled or not trusted database objects.
-- Check for tables without primary keys and/or clustered indexes.
-- For selected tests, GeneratedSql will return SQL to correct the issue.

select object_name(object_id) + '.' + [Name] as ObjectName, 'Foreign Key' as ObjectType, 
	'Disabled Foreign Key' as Issue, 
	'alter table [' + object_name(parent_object_id) + '] with check check constraint [' + [Name] + '];' as GeneratedSql 
from sys.foreign_keys
where is_disabled = 1

union all

select object_name(object_id) + '.' + [Name] as ObjectName, 'Foreign Key' as ObjectType,
	'Foreign Key Not Trusted' as Issue, 
	'alter table [' + object_name(parent_object_id) + '] with check check constraint [' + [Name] + '];' as GeneratedSql 
from sys.foreign_keys
where is_not_trusted = 1 and is_disabled = 0

union all

select object_name(parent_obj) + '.' + [Name] as ObjectName, 'Trigger' as ObjectType, 'Disabled Trigger' as Issue, 
	'alter table [' + object_name(parent_obj) + '] enable trigger [' + [Name] + '];' as GeneratedSql
from dbo.sysobjects where XType = 'TR'
and objectproperty(ID, 'ExecIsTriggerDisabled') = 1

union all

select object_name(cc.parent_object_id) + '.' + cc.name as ObjectName, 'Check Constraint' as ObjectType,
	'Constraint Not Trusted' as Issue, '' as GeneratedSql
from sys.check_constraints as cc
where cc.is_not_trusted = 1

union all

select object_name(cc.parent_object_id) + '.' + cc.name as ObjectName, 'Check Constraint' as ObjectType,
	'Constraint Disabled' as Issue, 'alter table [' + object_name(cc.parent_object_id) + '] with check check constraint [' + cc.name + '];' as GeneratedSql
from sys.check_constraints as cc
where cc.is_disabled = 1

union all

select t.name as TableName, 'Table' as ObjectType, 'No Clustered Index' as Issue, '' as GeneratedSql 
from sys.tables as t
left join sys.indexes as i
	on i.object_id = t.object_id
	and i.type = 1 -- Clustered
where i.object_id is null

union all

select t.[Name] as ObjectName, 'Table' as ObjectType, 'No Primary Key' as Issue, '' as GeneratedSql 
from sys.tables as t
left join sys.key_constraints as c
	on c.parent_object_id = t.[object_id]
where c.parent_object_id is null

union all

select [Name] as ObjectName, [Type] as ObjectType, 'ANSI NULLS Off' as Issue, '' as GeneratedSql
from sys.objects 
where [Type] in ('TR', 'P', 'FN', 'IF', 'TF', 'U')
and objectproperty (object_id,'IsAnsiNullsOn') = 0

order by 1

go
