

-- Jan 12, 2014
-- SqlRob.com
-- 2014 Columnstore Indexes

set ansi_nulls on
go
set quoted_identifier on
go

-- Create table

if object_id('TicketWaitList') is not null
	drop table TicketWaitList
go

create table TicketWaitList (
RecordId int not null identity(1,1),
HomeState char(2) not null,
HomeCity varchar(20) not null,
FavoriteTeam varchar(20) not null,
GameNumber tinyint not null,
TicketQuantity tinyint
)
go

-- Insert 

declare @Counter int = 0

while @Counter < 10
begin

declare @TicketQuantity tinyint

set @TicketQuantity = ceiling((rand() * 5));
insert into TicketWaitList(HomeState, HomeCity, FavoriteTeam, GameNumber, TicketQuantity)
values ('GA', 'Atlanta', 'Falcons', 1, @TicketQuantity)

set @TicketQuantity = ceiling((rand() * 5));
insert into TicketWaitList(HomeState, HomeCity, FavoriteTeam, GameNumber, TicketQuantity)
values ('GA', 'Atlanta', 'Falcons', 2, @TicketQuantity)

set @TicketQuantity = ceiling((rand() * 5));
insert into TicketWaitList(HomeState, HomeCity, FavoriteTeam, GameNumber, TicketQuantity)
values ('GA', 'Rome', 'Falcons', 1, @TicketQuantity)

set @TicketQuantity = ceiling((rand() * 5));
insert into TicketWaitList(HomeState, HomeCity, FavoriteTeam, GameNumber, TicketQuantity)
values ('GA', 'Marietta', 'Falcons', 2, @TicketQuantity)

set @TicketQuantity = ceiling((rand() * 5));
insert into TicketWaitList(HomeState, HomeCity, FavoriteTeam, GameNumber, TicketQuantity)
values ('NC', 'Charlotte', 'Panthers', 1, @TicketQuantity)

set @TicketQuantity = ceiling((rand() * 5));
insert into TicketWaitList(HomeState, HomeCity, FavoriteTeam, GameNumber, TicketQuantity)
values ('LA', 'New Orleans', 'Saints', 2, @TicketQuantity)

set @TicketQuantity = ceiling((rand() * 5));
insert into TicketWaitList(HomeState, HomeCity, FavoriteTeam, GameNumber, TicketQuantity)
values ('GA', 'Decatur', 'Panthers', 1, @TicketQuantity)

set @TicketQuantity = ceiling((rand() * 5));
insert into TicketWaitList(HomeState, HomeCity, FavoriteTeam, GameNumber, TicketQuantity)
values ('NC', 'Charlotte', 'Falcons', 1, @TicketQuantity)

set @TicketQuantity = ceiling((rand() * 5));
insert into TicketWaitList(HomeState, HomeCity, FavoriteTeam, GameNumber, TicketQuantity)
values ('LA', 'Slidell', 'Falcons', 2, @TicketQuantity)

set @TicketQuantity = ceiling((rand() * 5));
insert into TicketWaitList(HomeState, HomeCity, FavoriteTeam, GameNumber, TicketQuantity)
values ('NC', 'Gastonia', 'Panthers', 1, @TicketQuantity)

set @TicketQuantity = ceiling((rand() * 5));
insert into TicketWaitList(HomeState, HomeCity, FavoriteTeam, GameNumber, TicketQuantity)
values ('AL', 'Anniston', 'Falcons', 1, @TicketQuantity)

set @TicketQuantity = ceiling((rand() * 5));
insert into TicketWaitList(HomeState, HomeCity, FavoriteTeam, GameNumber, TicketQuantity)
values ('AL', 'Birmingham', 'Falcons', 2, @TicketQuantity)

set @TicketQuantity = ceiling((rand() * 5));
insert into TicketWaitList(HomeState, HomeCity, FavoriteTeam, GameNumber, TicketQuantity)
values ('SC', 'Columbia', 'Panthers', 1, @TicketQuantity)

set @TicketQuantity = ceiling((rand() * 5));
insert into TicketWaitList(HomeState, HomeCity, FavoriteTeam, GameNumber, TicketQuantity)
values ('MS', 'Jackson', 'Saints', 2, @TicketQuantity)

set @TicketQuantity = ceiling((rand() * 5));
insert into TicketWaitList(HomeState, HomeCity, FavoriteTeam, GameNumber, TicketQuantity)
values ('GA', 'Macon', 'Falcons', 2, @TicketQuantity)

set @TicketQuantity = ceiling((rand() * 5));
insert into TicketWaitList(HomeState, HomeCity, FavoriteTeam, GameNumber, TicketQuantity)
values ('GA', 'Columbus', 'Falcons', 1, @TicketQuantity)

set @Counter = @Counter + 1

end

go

select * from TicketWaitList
go

-- Rowstore indexes

if object_id('PK_TicketWaitList') is not null
	alter table [dbo].[TicketWaitList] drop constraint PK_TicketWaitList
go
alter table [dbo].[TicketWaitList] add constraint [PK_TicketWaitList]
primary key clustered ([RecordId])
go

if exists (select * from sys.indexes where name = 'IX_TicketWaitList')
	drop index TicketWaitList.IX_TicketWaitList
go
create nonclustered index IX_TicketWaitList
on TicketWaitList (HomeState, HomeCity, FavoriteTeam, GameNumber)
go 

-- Columnstore index
-- Drop existing indexes

if object_id('PK_TicketWaitList') is not null
	alter table [dbo].[TicketWaitList] drop constraint PK_TicketWaitList
go
if exists (select * from sys.indexes where name = 'IX_TicketWaitList')
	drop index TicketWaitList.IX_TicketWaitList
go
if exists (select * from sys.indexes where name = 'IX_TicketWaitList_ColumnStore')
	drop index TicketWaitList.IX_TicketWaitList_ColumnStore
go

create clustered columnstore index IX_TicketWaitList_ColumnStore on TicketWaitList
--with (drop_existing = on);

go

-- Queries

-- Sum

declare @StartTime datetime = getdate();

select HomeState, HomeCity, FavoriteTeam, GameNumber, sum(TicketQuantity) as TotalTickets
from TicketWaitList
group by HomeState, HomeCity, FavoriteTeam, GameNumber;

select datediff(ms, @StartTime, getdate()) as RunTimeMs;

go

-- Ticket sales by State

declare @StartTime datetime = getdate();

select HomeState, sum(TicketQuantity) as TotalTickets
from TicketWaitList
group by HomeState;

select datediff(ms, @StartTime, getdate()) as RunTimeMs;

go

--results:
--Rowstore:
--Sum: 2170, 2170, 2196
--By States: 776, 763, 783

--ColumnStore:
--Sum: 110, 43, 43
--By States: 36, 30, 40


