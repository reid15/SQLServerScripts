

-- List all permissions in a database for a specified user
-- Include SQL revoke permissions currently granted to objects

declare @UserName nvarchar(128) = 'Rob'
select p.name as UserName, 
	d.permission_name as PermissionName,
	d.state_desc as PermissionStateDescription,
	s.name as SchemaName, 
	o.name as ObjectName, 
	o.type_desc as ObjectTypeDescription,
	case when d.state <> 'G' then '' else 
		('revoke ' + d.permission_name + ' on object::' + s.name + '.' + o.name + ' from ' + p.name  + ';'
			collate sql_latin1_general_cp1_ci_as) end as RevokeSql
from sys.database_permissions as d
join sys.database_principals as p
	on p.principal_id = d.grantee_principal_id
join sys.objects as o
	on o.object_id = d.major_id
join sys.schemas as s
	on s.schema_id = o.schema_id
where p.name = @UserName
order by o.type, o.name

go

