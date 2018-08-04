
-- Pivot vs Case performance test

create table dbo.TestPivotCase(
RecordId int not null identity(1,1),
CreatedDate datetime not null default(getdate()),
RecordColor varchar(10) not null
);
go

insert into dbo.TestPivotCase(RecordColor) values ('Red');
insert into dbo.TestPivotCase(RecordColor) values ('Blue');
insert into dbo.TestPivotCase(RecordColor) values ('White');
insert into dbo.TestPivotCase(RecordColor) values ('Red');
insert into dbo.TestPivotCase(RecordColor) values ('Blue');
insert into dbo.TestPivotCase(RecordColor) values ('Red');
go 1000000

select count(*) from dbo.TestPivotCase;
go

-- Queries

-- Case

select
	sum(case when RecordColor = 'Red' then 1 else 0 end) as [Red],
	sum(case when RecordColor = 'Blue' then 1 else 0 end) as [Blue],
	sum(case when RecordColor = 'White' then 1 else 0 end) as [White],
	count(*) as [Total]
from dbo.TestPivotCase;

-- Pivot

select [Red], [Blue], [White], ([Red] + [Blue] + [White]) as Total
from (
select RecordColor from dbo.TestPivotCase
) as a
pivot (
count(RecordColor) for RecordColor in ([Red], [White], [Blue])
)as p;

go


