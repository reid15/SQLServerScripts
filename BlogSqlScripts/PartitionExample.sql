

-- Create database
use master;
go

create database TestDatabase;
go

use TestDatabase;
go

-- Create filegroups
alter database TestDatabase add filegroup PlayerFG1;
alter database TestDatabase add filegroup PlayerFG2;
alter database TestDatabase add filegroup PlayerFG3;

-- Create data files
alter database TestDatabase add file(name = 'PlayerDF1', FileName = 'C:\SQLData\PlayerDF1.ndf') to filegroup PlayerFG1;
alter database TestDatabase add file(name = 'PlayerDF2', FileName = 'C:\SQLData\PlayerDF2.ndf') to filegroup PlayerFG2;
alter database TestDatabase add file(name = 'PlayerDF3', FileName = 'C:\SQLData\PlayerDF3.ndf') to filegroup PlayerFG3;

-- Create partition function
create partition function PlayerPartition (tinyint) as
range left for values (32, 63);

-- Create partition scheme
create partition scheme PlayerScheme as
partition PlayerPartition to (PlayerFG1, PlayerFG2, PlayerFG3);

-- Create table to partition
create table Player (
JerseyNumber tinyint not null primary key,
FirstName varchar(20) not null,
LastName varchar(20) not null,
Position char(2) not null 
)
on PlayerScheme(JerseyNumber);

-- Insert Data
insert into Player(JerseyNumber, FirstName, LastName, Position) values (2, 'Matt', 'Ryan', 'QB');
insert into Player(JerseyNumber, FirstName, LastName, Position) values (11, 'Julio', 'Jones', 'WR');
insert into Player(JerseyNumber, FirstName, LastName, Position) values (32, 'Jacquizz', 'Rodgers', 'RB');
insert into Player(JerseyNumber, FirstName, LastName, Position) values (55, 'Paul', 'Worrilow', 'LB');
insert into Player(JerseyNumber, FirstName, LastName, Position) values (63, 'Justin', 'Blalock', 'LG');
insert into Player(JerseyNumber, FirstName, LastName, Position) values (84, 'Roddy', 'White', 'WR');
insert into Player(JerseyNumber, FirstName, LastName, Position) values (95, 'Jonathan', 'Babineaux', 'DT');

-- View Records
select JerseyNumber, FirstName, LastName, Position, $PARTITION.PlayerPartition(JerseyNumber) as FileGroupId from Player;

go

