

-- Assign permission to a particular principal
-- to all DB objects that don't already have that permission assigned.

set nocount on

declare @PrincipalName nvarchar(50) = 'midtier'

declare Cursor_Template cursor local fast_forward
   for 

select o.Name as ObjectName, o.ObjectType, s.name as SchemaName
from (
select name, type as ObjectType, schema_id as SchemaId, object_id as ObjectId, 1 as [Class]
from sys.objects 
where is_ms_shipped = 0
	and type in ('FN', 'P', 'TF', 'U', 'V')
union
select name, 'TT' as ObjectType, schema_id as SchemaId, user_type_id as ObjectId, 6 as [Class]
from sys.table_types
where is_user_defined = 1
) as o
join sys.schemas as s
	on s.schema_id = o.SchemaId
left join (
select d.major_id, d.permission_name, d.state_desc, d.Class
from sys.database_permissions as d
join sys.database_principals as dp
	on dp.principal_id = d.grantee_principal_id
	and dp.name = @PrincipalName
where d.permission_name in ('EXECUTE', 'SELECT')
	and d.state_desc = 'GRANT'
) as t
on t.major_id = o.ObjectId
	and t.class = o.Class
where t.permission_name is null
order by o.name

declare @ObjectName varchar(128)
declare @ObjectType varchar(5)
declare @SchemaName varchar(128)

open Cursor_Template

fetch next from Cursor_Template into @ObjectName, @ObjectType, @SchemaName

while @@FETCH_STATUS = 0

begin
	declare @FullObjectName varchar(256) = ('[' + @SchemaName + '].[' + @ObjectName + ']')
	if (@ObjectType = 'TT')
		set @FullObjectName = 'type::[' + @SchemaName + '].[' + @ObjectName + ']'
	
	declare @PermissionAction varchar(30) = 'EXECUTE'
	if (@ObjectType = 'V')
		set @PermissionAction = 'SELECT'
	else if (@ObjectType = 'U')
		set @PermissionAction = 'SELECT ,INSERT, UPDATE, DELETE'

	declare @SQL nvarchar(500) = 'GRANT ' + @PermissionAction + ' ON ' + @FullObjectName + ' TO ' + @PrincipalName + ';'

	exec sp_executesql @sql
	print @SQL

	fetch next from Cursor_Template into @ObjectName, @ObjectType, @SchemaName
end

close Cursor_Template

deallocate Cursor_Template

go
