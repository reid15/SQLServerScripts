
-- SQL Graph

-- Node

drop table if exists dbo.Player;

create table dbo.Player(
Team char(3) not null,
Number tinyint not null,
FirstName varchar(50),
LastName varchar(50),
Position char(2),
primary key(Team, Number)
) as Node;

insert into dbo.Player values ('ATL', 2, 'Matt', 'Ryan', 'QB');
insert into dbo.Player values ('ATL', 11, 'Julio', 'Jones', 'WR');
insert into dbo.Player values ('ATL', 21, 'Desmond', 'Trufant', 'CB');
insert into dbo.Player values ('ATL', 44, 'Vic', 'Beasley', 'LB');

select * from dbo.Player;

-- Edge

drop table if exists dbo.PlatoonsWith;

create table dbo.PlatoonsWith(
PlatoonName varchar(10) not null
) as Edge;

select * from dbo.PlatoonsWith;

-- Insert Edges
-- Update columns names if table is regenerated

declare @Node1 nvarchar(1000);
declare @Node2 nvarchar(1000);

select @Node1 = [$node_id_4FE94CB5420E440DA5CE8FE7781FA404]
from dbo.Player
where Team = 'ATL' and Number = 2;

select @Node2 = [$node_id_4FE94CB5420E440DA5CE8FE7781FA404]
from dbo.Player
where Team = 'ATL' and Number = 11;

insert into dbo.PlatoonsWith([$from_id_64FB3EBE4E3449D5A59D79FB0F8FA857], [$to_id_6A42816479484605BCD86836DFE8122B], PlatoonName)
values (@Node1, @Node2, 'Offense');

select * from dbo.PlatoonsWith;

-- Query for relationships

select p1.FirstName + ' ' + p1.LastName as Player1, p1.Position as Player1Position,
	pw.PlatoonName, p2.FirstName + ' ' + p2.LastName as Player2, p2.Position as Player2Position
from dbo.Player as p1, dbo.PlatoonsWith as pw, dbo.Player as p2
where match(p1-(pw)->p2)
	and p1.Number = 2
	and p2.Team = 'ATL';

go

-- Deleting Nodes 

delete
from dbo.Player
where Number = 2
	and Team = 'ATL';
	
select * from dbo.Player;
select * from dbo.PlatoonsWith;

go



