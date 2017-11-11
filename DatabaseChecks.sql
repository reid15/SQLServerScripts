
-- Return potential issues with a database

drop table if exists #Issues;

create table #Issues(
SchemaName varchar(20) not null,
ObjectName varchar(50) not null,
ObjectType varchar(50) not null,
Issue varchar(50) not null
);

-- Check all tables have a primary key

insert into #Issues(SchemaName, ObjectName, ObjectType, Issue)
select s.[Name] as SchemaName, t.[Name] as TableName, 'Table' as ObjectType, 'No Primary Key' as Issue 
from sys.tables as t
join sys.schemas as s
	on s.schema_id = t.schema_id
left join sys.key_constraints as k
	on k.parent_object_id = t.Object_Id
	and k.[Type] = 'PK'
where k.object_id is null
	and t.is_ms_shipped = 0;

-- Space in column names

insert into #Issues(SchemaName, ObjectName, ObjectType, Issue)
select s.[Name] as SchemaName, t.[Name] + '.' +  c.[Name] as ColumnName, 'Column' as ObjectType, 'Space In Column Name' as Issue
from sys.columns as c
join sys.tables as t
	on t.object_id = c.object_id
join sys.schemas as s
	on s.schema_id = t.schema_id
where c.[Name] like '% %'
	and t.is_ms_shipped = 0;

-- Numbers in column names

insert into #Issues(SchemaName, ObjectName, ObjectType, Issue)
select s.[Name] as SchemaName, t.[Name] + '.' +  c.[Name] as ColumnName, 'Column' as ObjectType, 'Number In Column Name' as Issue
from sys.columns as c
join sys.tables as t
	on t.object_id = c.object_id
join sys.schemas as s
	on s.schema_id = t.schema_id
where c.[Name] like '%[0-9]%'
	and t.is_ms_shipped = 0;

-- Space in object name

insert into #Issues(SchemaName, ObjectName, ObjectType, Issue)
select s.[Name] as SchemaName, o.[Name] as ObjectName, o.type_desc as ObjectType, 'Space In Object Name' as Issue
from sys.objects as o
join sys.schemas as s
	on s.schema_id = o.schema_id
where o.[Name] like '% %'
	and o.is_ms_shipped = 0;

-- Number in object name

insert into #Issues(SchemaName, ObjectName, ObjectType, Issue)
select s.[Name] as SchemaName, o.[Name] as ObjectName, o.type_desc as ObjectType, 'Number In Object Name' as Issue
from sys.objects as o
join sys.schemas as s
	on s.schema_id = o.schema_id
where o.[Name] like '%[0-9]%'
	and o.[Type] in ('U', 'V', 'P')
	and o.is_ms_shipped = 0;

-- Disabled Foreign Key
insert into #Issues(SchemaName, ObjectName, ObjectType, Issue)
select s.[Name], t.[Name] + '.' + f.[Name], 'Foreign Key', 'Disabled Foreign Key' 
from sys.foreign_keys as f
join sys.tables as t
	on t.object_id = f.parent_object_id
join sys.schemas as s
	on s.schema_id = t.schema_id
where f.is_ms_shipped = 0
	and f.is_disabled = 1;

-- Not Trusted Foreign Key
insert into #Issues(SchemaName, ObjectName, ObjectType, Issue)
select s.[Name], t.[Name] + '.' + f.[Name], 'Foreign Key', 'Not Trusted Foreign Key' 
from sys.foreign_keys as f
join sys.tables as t
	on t.object_id = f.parent_object_id
join sys.schemas as s
	on s.schema_id = t.schema_id
where f.is_ms_shipped = 0
	and f.is_not_trusted = 1;

-- System Named Foreign Key
insert into #Issues(SchemaName, ObjectName, ObjectType, Issue)
select s.[Name], t.[Name] + '.' + f.[Name], 'Foreign Key', 'System Named Foreign Key' 
from sys.foreign_keys as f
join sys.tables as t
	on t.object_id = f.parent_object_id
join sys.schemas as s
	on s.schema_id = t.schema_id
where f.is_ms_shipped = 0
	and f.is_system_named = 1;

-- Disabled Check Constraint
insert into #Issues(SchemaName, ObjectName, ObjectType, Issue)
select s.[Name], t.[Name] + '.' + f.[Name], 'Check Constraint', 'Disabled Check Constraint' 
from sys.check_constraints as f
join sys.tables as t
	on t.object_id = f.parent_object_id
join sys.schemas as s
	on s.schema_id = t.schema_id
where f.is_ms_shipped = 0
	and f.is_disabled = 1;

-- Not Trusted Check Constraint
insert into #Issues(SchemaName, ObjectName, ObjectType, Issue)
select s.[Name], t.[Name] + '.' + f.[Name], 'Check Constraint', 'Not Trusted Check Constraint' 
from sys.check_constraints as f
join sys.tables as t
	on t.object_id = f.parent_object_id
join sys.schemas as s
	on s.schema_id = t.schema_id
where f.is_ms_shipped = 0
	and f.is_not_trusted = 1;

-- System Named Check Constraint
insert into #Issues(SchemaName, ObjectName, ObjectType, Issue)
select s.[Name], t.[Name] + '.' + f.[Name], 'Check Constraint', 'System Named Check Constraint' 
from sys.check_constraints as f
join sys.tables as t
	on t.object_id = f.parent_object_id
join sys.schemas as s
	on s.schema_id = t.schema_id
where f.is_ms_shipped = 0
	and f.is_system_named = 1;

-- System Named Default Constraint
insert into #Issues(SchemaName, ObjectName, ObjectType, Issue)
select s.[Name], t.[Name] + '.' + f.[Name], 'Default', 'System Named Default' 
from sys.default_constraints as f
join sys.tables as t
	on t.object_id = f.parent_object_id
join sys.schemas as s
	on s.schema_id = t.schema_id
where f.is_ms_shipped = 0
	and f.is_system_named = 1;

-- Tables with no rows

insert into #Issues(SchemaName, ObjectName, ObjectType, Issue)
select s.[Name], t.[Name], 'Table', 'Empty Table'
from sys.partitions as p
join sys.tables as t
	on t.object_id = p.object_id
join sys.schemas as s
	on s.schema_id = t.schema_id
where t.is_ms_shipped = 0
	and p.index_id between 0 and 1
group by s.[Name], t.[Name]
having sum(p.rows) = 0

-- Deprecated data types

insert into #Issues(SchemaName, ObjectName, ObjectType, Issue)
select s.[Name] as SchemaName, t.[Name] + '.' +  c.[Name] as ColumnName, 'Column' as ObjectType, 
	'Deprecated Data Type: ' + ty.[Name] as Issue
from sys.columns as c
join sys.tables as t
	on t.object_id = c.object_id
join sys.schemas as s
	on s.schema_id = t.schema_id
join sys.types as ty
	on ty.user_type_id = c.user_type_id
where ty.[Name] in ('image', 'text', 'ntext', 'timestamp')
	and t.is_ms_shipped = 0;
	
-- Return Issues

select SchemaName, ObjectName, ObjectType, Issue
from #Issues
order by Issue, SchemaName, ObjectName;

go

