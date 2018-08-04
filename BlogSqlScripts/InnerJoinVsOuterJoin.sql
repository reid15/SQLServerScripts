
-- Compare query performance between inner and outer joins

-- Create tables and populate with data

if object_id('dbo.Test1') is not null
	drop table dbo.Test1
go
create table dbo.Test1(
RecordId int not null identity(1,1) constraint PK_Test1 primary key clustered,
CreatedDate datetime not null default getdate()
);

insert into dbo.Test1 default values;
go 2000000

select count(*) from dbo.Test1;

go

if object_id('dbo.Test2') is not null
	drop table dbo.Test2
go
create table dbo.Test2(
RecordId int null,
ItemId tinyint null,
CreatedDate datetime not null default getdate()
);

insert into dbo.Test2(RecordId, ItemId) select RecordId, 1 from dbo.Test1;
insert into dbo.Test2(RecordId, ItemId) select RecordId, 2 from dbo.Test1;
insert into dbo.Test2(RecordId, ItemId) select RecordId, 3 from dbo.Test1;
insert into dbo.Test2(RecordId, ItemId) select RecordId, 4 from dbo.Test1;
insert into dbo.Test2(RecordId, ItemId) select RecordId, 5 from dbo.Test1;

create clustered index IX_Test2_RecordIdItemId on dbo.Test2 (RecordId, ItemId);

select count(*) from dbo.Test2;

go

-- Selects - Include Actual Execution Plan

-- All records

select *
from dbo.Test1 as a
join dbo.Test2 as b
	on b.RecordId = a.RecordId;

select *
from dbo.Test1 as a
left join dbo.Test2 as b
	on b.RecordId = a.RecordId;

go

-- One specific record

select *
from dbo.Test1 as a
join dbo.Test2 as b
	on b.RecordId = a.RecordId
where b.RecordId = 9999;

select *
from dbo.Test1 as a
left join dbo.Test2 as b
	on b.RecordId = a.RecordId
where b.RecordId = 9999;

go

-- Drop Test1 clustered primary key

alter table dbo.Test1 drop constraint PK_Test1;

-- Add Test1 clustered primary key

alter table dbo.Test1 add constraint PK_Test1
primary key clustered (RecordId);

-- Drop every 4th record in the Test2 table

delete
from dbo.Test2
where RecordId % 4 = 0;

go
