

-- Get current users for Database Server

use [master]
go

select p.spid, p.last_batch, p.nt_username, d.name as DatabaseName 
from sys.sysprocesses as p
join sys.databases as d
	on d.database_id = p.dbid
where d.owner_sid <> 0x01
order by d.name
	
go
