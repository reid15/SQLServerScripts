

if object_id('dbo.LevelTest') is not null
	drop table dbo.LevelTest;

create table dbo.LevelTest(
EmployeeId int not null primary key identity(1,1),
EmployeeName varchar(50) not null,
JobTitle varchar(50) not null,
ManagerId int null references dbo.LevelTest(EmployeeId),
IsActive bit not null default(1)
);

insert into dbo.LevelTest(EmployeeName, JobTitle, ManagerId) values ('Big Boss', 'CEO', null);
insert into dbo.LevelTest(EmployeeName, JobTitle, ManagerId) values ('Martha', 'Director', 1);
insert into dbo.LevelTest(EmployeeName, JobTitle, ManagerId) values ('Bob', 'Middle Manager', 2);
insert into dbo.LevelTest(EmployeeName, JobTitle, ManagerId) values ('Little Guy', 'Mailroom', 3);

with EmployeeLevel (EmployeeId, EmployeeName, JobTitle, ManagerId, LevelId)
as (
select EmployeeId, EmployeeName, JobTitle, ManagerId, 1 as LevelId
from dbo.LevelTest
where ManagerId is null
union all
select l.EmployeeId, l.EmployeeName, l.JobTitle, l.ManagerId, e.LevelId + 1
from dbo.LevelTest as l
join EmployeeLevel as e
	on e.EmployeeId = l.ManagerId
where l.ManagerId is not null
)
select * from EmployeeLevel;

go
