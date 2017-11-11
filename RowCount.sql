
-- Return the number of rows in each user table

select o.[name] as 'TableName', p.rows as 'Rows'
from sys.objects as o
join sys.partitions as p 
	on o.object_id = p.object_id
where (o.[type] = 'U')
and (p.index_id in (0,1))
order by o.[name];

go
