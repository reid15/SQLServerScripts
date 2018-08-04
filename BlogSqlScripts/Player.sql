

-- SQL Rob Blog
-- Sept 6, 2015
-- Sample table - Player

create table dbo.Player (
JerseyNumber tinyint not null primary key,
FirstName varchar(20) not null,
LastName varchar(20) not null,
Position char(2) not null
)

go

insert into dbo.Player (JerseyNumber, FirstName, LastName, Position)
values (2, 'Matt', 'Ryan', 'QB');
insert into dbo.Player (JerseyNumber, FirstName, LastName, Position)
values (11, 'Julio', 'Jones', 'WR');
insert into dbo.Player (JerseyNumber, FirstName, LastName, Position)
values (25, 'William', 'Moore', 'SS');
insert into dbo.Player (JerseyNumber, FirstName, LastName, Position)
values (84, 'Roddy', 'White', 'WR');

go

select JerseyNumber, FirstName, LastName, Position from dbo.Player;
