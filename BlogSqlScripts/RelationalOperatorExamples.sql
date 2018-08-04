

-- Relational Algebra Operator examples
-- www.sqlrob.com
-- July 25, 2014

-- Create tables

if (object_id('Player') is not null)
	drop table Player

if (object_id('Team') is not null)
	drop table Team

if (object_id('SuperBowlHost') is not null)
	drop table SuperBowlHost

if (object_id('State') is not null)
	drop table [State]
go

create table dbo.[State] (
StateCode char(2) not null primary key clustered,
StateName varchar(20) not null
)

create table dbo.Team (
TeamCode char(3) not null primary key clustered,
PlaceName varchar(20) not null,
NickName varchar(20) not null,
City varchar(20) not null,
StateCode char(2) not null references dbo.[State](StateCode),
StadiumName varchar(25) not null
)

create table dbo.SuperBowlHost (
SuperBowlNumber tinyint not null primary key clustered,
StadiumName varchar(25) not null,
City varchar(20) not null,
StateCode char(2) not null references dbo.[State](StateCode)
)

create table dbo.Player (
PlayerName varchar(20) not null,
TeamCode char(3) not null references dbo.Team(TeamCode),
primary key (PlayerName, TeamCode)
)
go

-- Insert data

insert into dbo.[State] (StateCode, StateName) values ('GA', 'Georgia');
insert into dbo.[State] (StateCode, StateName) values ('LA', 'Louisiana');
insert into dbo.[State] (StateCode, StateName) values ('NC', 'North Carolina');
insert into dbo.[State] (StateCode, StateName) values ('FL', 'Florida');
insert into dbo.[State] (StateCode, StateName) values ('NJ', 'New Jersey');

insert into dbo.[Team] (TeamCode, PlaceName, NickName, City, StateCode, StadiumName)
values ('ATL', 'Atlanta', 'Falcons', 'Atlanta', 'GA', 'Georgia Dome');
insert into dbo.[Team] (TeamCode, PlaceName, NickName, City, StateCode, StadiumName)
values ('NOR', 'New Orleans', 'Saints', 'New Orleans', 'LA', 'Mercedes-Benz Superdome');
insert into dbo.[Team] (TeamCode, PlaceName, NickName, City, StateCode, StadiumName)
values ('CAR', 'Carolina', 'Panthers', 'Charlotte', 'NC', 'Bank Of America Stadium');
insert into dbo.[Team] (TeamCode, PlaceName, NickName, City, StateCode, StadiumName)
values ('TAM', 'Tampa Bay', 'Buccaneers', 'Tampa', 'FL', 'Raymond James Stadium');

insert into dbo.SuperBowlHost (SuperBowlNumber, StadiumName, City, StateCode)
values (48, 'Met Life Stadium', 'East Rutherford', 'NJ');
insert into dbo.SuperBowlHost (SuperBowlNumber, StadiumName, City, StateCode)
values (47, 'Mercedes-Benz Superdome', 'New Orleans', 'LA');
insert into dbo.SuperBowlHost (SuperBowlNumber, StadiumName, City, StateCode)
values (34, 'Georgia Dome', 'Atlanta', 'GA');

insert into dbo.Player (PlayerName, TeamCode) values ('Matt Ryan', 'ATL')
insert into dbo.Player (PlayerName, TeamCode) values ('Drew Brees', 'NOR')
insert into dbo.Player (PlayerName, TeamCode) values ('Cam Newton', 'CAR')
insert into dbo.Player (PlayerName, TeamCode) values ('Mike Glennon', 'TAM')
insert into dbo.Player (PlayerName, TeamCode) values ('Morten Andersen', 'ATL')
insert into dbo.Player (PlayerName, TeamCode) values ('Morten Andersen', 'NOR')
insert into dbo.Player (PlayerName, TeamCode) values ('Bobby Herbert', 'ATL')
insert into dbo.Player (PlayerName, TeamCode) values ('Bobby Herbert', 'NOR')
insert into dbo.Player (PlayerName, TeamCode) values ('Warrick Dunn', 'ATL')
insert into dbo.Player (PlayerName, TeamCode) values ('Warrick Dunn', 'TAM')

go

select * from dbo.[State];
select * from dbo.Team;
select * from dbo.SuperBowlHost;
select * from dbo.Player;

go

-- Examples

-- Operators:

-- 1)Selection

select * from dbo.Team where TeamCode = 'ATL';

-- 2)Projection

select PlaceName, NickName from dbo.Team;

-- 3)Join 

select t.NickName, t.City, t.StateCode, s.StateName
from dbo.Team as t 
inner join dbo.[State] as s
	on s.StateCode = t.StateCode;

-- 4)Intersect

select StadiumName, City, StateCode from dbo.Team
intersect
select StadiumName, City, StateCode from dbo.SuperBowlHost;

-- 5)Union

select StadiumName, City, StateCode from dbo.Team
union
select StadiumName, City, StateCode from dbo.SuperBowlHost;

-- 6)Difference

select StadiumName, City, StateCode from dbo.Team
except
select StadiumName, City, StateCode from dbo.SuperBowlHost;

-- 7)Cartesian Product 

select t.NickName, t.City, t.StateCode, s.StateCode, s.StateName
from dbo.Team as t 
cross join dbo.[State] as s;

-- 8)Divide

select distinct PlayerName from dbo.Player
except
select PlayerName
from ( select PlayerName, TeamCode
from (select PlayerName from dbo.Player) as t1,
(select TeamCode from dbo.Team where TeamCode in ('ATL', 'NOR')) as t2
except
select PlayerName, TeamCode from dbo.Player
) as t3;

go
