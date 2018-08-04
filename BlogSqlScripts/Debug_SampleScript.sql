
-- www.robertbreid.com
-- Debugging Stored Procedures 
-- Nov 28, 2015

set ansi_nulls on
set quoted_identifier on
go

-- Drop objects

if object_id('Player') is not null
	drop table Player
if object_id('InsertPlayer') is not null
	drop procedure InsertPlayer
go

-- Create table

create table dbo.Player (
TeamName char(3) not null,
JerseyNumber tinyint not null,
FirstName varchar(25) not null,
LastName varchar(25) not null,
Position char(2) not null,
primary key(TeamName, JerseyNumber)
);
go

-- Create procedure

create procedure dbo.InsertPlayer
	@TeamName char(3),
	@JerseyNumber tinyint,
	@FirstName varchar(25),
	@LastName varchar(25),
	@Position char(2)
as

insert into dbo.Player(TeamName, JerseyNumber, FirstName, LastName, Position)
values (@TeamName, @JerseyNumber, @FirstName, @LastName, @Position);

select TeamName, JerseyNumber, FirstName, LastName, Position
from dbo.Player
where TeamName = @TeamName
	and JerseyNumber = @JerseyNumber;

go
grant execute on dbo.InsertPlayer to [public];
go

-- Run Proc

declare @TeamName char(3) = 'ATL';
declare @JerseyNumber tinyint = 2;
declare  @FirstName varchar(25) = 'Matt';
declare  @LastName varchar(25) = 'Ryan'
declare  @Position char(2) = 'QB';

exec dbo.InsertPlayer @TeamName, @JerseyNumber, @FirstName, @LastName, @Position;

go



