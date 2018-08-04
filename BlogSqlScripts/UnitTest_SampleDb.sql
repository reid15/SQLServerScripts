

-- www.robertbreid.com
-- Set up tables, data and stored procedures for unit tests
-- Feb 25, 2015

set ansi_nulls on
set quoted_identifier on
go

-- Create tables

if object_id('Player') is not null
	drop table Player
if object_id('Position') is not null
	drop table Position
if object_id('Team') is not null
	drop table Team
go

create table Team (
TeamId tinyint not null primary key clustered,
TeamCity varchar(20) not null,
TeamName varchar(20) not null
)

create table Position (
PositionId tinyint not null primary key clustered,
PositionName varchar(20) not null
)

create table Player (
PlayerId smallint not null identity (1,1) primary key clustered,
TeamId tinyint not null references Team(TeamId),
PositionId tinyint not null references Position(PositionId),
PlayerNumber tinyint not null,
PlayerFirstName varchar(20) not null,
PlayerLastName varchar(20) not null
)

go

-- Data

insert into Team (TeamId, TeamCity, TeamName) values (1, 'Atlanta', 'Falcons');

insert into Position (PositionId, PositionName) values (1, 'Quarterback');
insert into Position (PositionId, PositionName) values (2, 'Wide Receiver');
insert into Position (PositionId, PositionName) values (3, 'Running Back');
insert into Position (PositionId, PositionName) values (4, 'Safety');

insert into Player (TeamId, PositionId, PlayerNumber, PlayerFirstName, PlayerLastName)
values (1, 1, 2, 'Matt', 'Ryan');
insert into Player (TeamId, PositionId, PlayerNumber, PlayerFirstName, PlayerLastName)
values (1, 2, 11, 'Julio', 'Jones');
insert into Player (TeamId, PositionId, PlayerNumber, PlayerFirstName, PlayerLastName)
values (1, 2, 84, 'Roddy', 'White');
insert into Player (TeamId, PositionId, PlayerNumber, PlayerFirstName, PlayerLastName)
values (1, 3, 32, 'Jacquizz', 'Rodgers');

go

select * from Team;
select * from Position;
select * from Player;

go

-- Stored procedures

-- Team

if (object_id('TestDB_InsertTeam')) is not null
	drop procedure [TestDB_InsertTeam]
go
create procedure [dbo].[TestDB_InsertTeam](
	@TeamId tinyint,
	@TeamCity varchar(20),
	@TeamName varchar(20)
)
as

set nocount on

insert into Team([TeamId], [TeamCity], [TeamName])
values (@TeamId, @TeamCity, @TeamName)

return @@error
go


if (object_id('TestDB_GetTeam')) is not null
	drop procedure [TestDB_GetTeam]
go
create procedure [dbo].[TestDB_GetTeam](
@TeamId tinyint
)
as

set nocount on

select [TeamId], [TeamCity], [TeamName]
from Team
where [TeamId] = @TeamId

return @@error
go

-- No Delete for Team

if (object_id('TestDB_UpdateTeam')) is not null
	drop procedure [TestDB_UpdateTeam]
go
create procedure [dbo].[TestDB_UpdateTeam](
	@TeamId tinyint,
	@TeamCity varchar(20),
	@TeamName varchar(20)
)
as

set nocount on

update Team
set 
[TeamCity] = @TeamCity,
[TeamName] = @TeamName
where [TeamId] = @TeamId

return @@error
go

-- Position

if (object_id('TestDB_InsertPosition')) is not null
	drop procedure [TestDB_InsertPosition]
go
create procedure [dbo].[TestDB_InsertPosition](
	@PositionId tinyint,
	@PositionName varchar(20)
)
as

set nocount on

insert into Position([PositionId], [PositionName])
values (@PositionId, @PositionName)

return @@error
go


if (object_id('TestDB_GetPosition')) is not null
	drop procedure [TestDB_GetPosition]
go
create procedure [dbo].[TestDB_GetPosition](
@PositionId tinyint
)
as

set nocount on

select [PositionId], [PositionName]
from Position
where [PositionId] = @PositionId

return @@error
go

-- No delete for position

if (object_id('TestDB_UpdatePosition')) is not null
	drop procedure [TestDB_UpdatePosition]
go
create procedure [dbo].[TestDB_UpdatePosition](
	@PositionId tinyint,
	@PositionName varchar(20)
)
as

set nocount on

update Position
set 
[PositionName] = @PositionName
where [PositionId] = @PositionId

return @@error
go

-- Player

if (object_id('TestDB_InsertPlayer')) is not null
	drop procedure [TestDB_InsertPlayer]
go
create procedure [dbo].[TestDB_InsertPlayer](
	@TeamId tinyint,
	@PositionId tinyint,
	@PlayerNumber tinyint,
	@PlayerFirstName varchar(20),
	@PlayerLastName varchar(20)
)
as

set nocount on

insert into Player([TeamId], [PositionId], [PlayerNumber], [PlayerFirstName], [PlayerLastName])
values (@TeamId, @PositionId, @PlayerNumber, @PlayerFirstName, @PlayerLastName)

return @@error
go


if (object_id('TestDB_GetPlayer')) is not null
	drop procedure [TestDB_GetPlayer]
go
create procedure [dbo].[TestDB_GetPlayer](
@PlayerId smallint
)
as

set nocount on

select [PlayerId], [TeamId], [PositionId], [PlayerNumber], [PlayerFirstName], [PlayerLastName]
from Player
where [PlayerId] = @PlayerId

return @@error
go


if (object_id('TestDB_DeletePlayer')) is not null
	drop procedure [TestDB_DeletePlayer]
go
create procedure [dbo].[TestDB_DeletePlayer](
@PlayerId smallint
)
as

set nocount on

delete
from Player
where [PlayerId] = @PlayerId

return @@error
go


if (object_id('TestDB_UpdatePlayer')) is not null
	drop procedure [TestDB_UpdatePlayer]
go
create procedure [dbo].[TestDB_UpdatePlayer](
	@PlayerId smallint,
	@TeamId tinyint,
	@PositionId tinyint,
	@PlayerNumber tinyint,
	@PlayerFirstName varchar(20),
	@PlayerLastName varchar(20)
)
as

set nocount on

update Player
set 
[TeamId] = @TeamId,
[PositionId] = @PositionId,
[PlayerNumber] = @PlayerNumber,
[PlayerFirstName] = @PlayerFirstName,
[PlayerLastName] = @PlayerLastName
where [PlayerId] = @PlayerId

return @@error
go

-- Function

if (object_id('TestDB_GetPositionId')) is not null
	drop function [TestDB_GetPositionId]
go
create function dbo.TestDB_GetPositionId (
	@PositionName varchar(20)
) 
returns tinyint
as
begin
	declare @PositionId tinyint
	select @PositionId = PositionId from dbo.Position where PositionName = @PositionName;
	return @PositionId
end;
go

