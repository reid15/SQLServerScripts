
-- SQL Server 2017

------------------------------
-- T-SQL Functions
------------------------------

-- TRIM
-- Trim spaces from beginning and end of string - LTRIM + RTRIM

declare @Test varchar(20) = '  Test string   ';
select @Test as OriginalString, trim(@Test) as TrimmedString;

-- CONCAT_WS:
-- Concatenate with separator. The first argument is a string that will be used as the separator. 
-- Any number of string arguments can follow and these string will be combined into one string, with the designated separator between each value.

select concat_ws(',', 'First', 'Second', 'Third', 'Fourth');

-- TRANSLATE
-- TRANSLATE can be thought of as an extension of REPLACE. We can define a list of characters that we want replaced in a string, 
-- and then a list of the characters to replace them with.

select translate('[Test string]', '[]', '()');

-- STRING_AGG
-- STRING_AGG is similar to CONCAT_WS, except it will concatenate values from a column instead of a list of values. 
-- The second argument is the string to use as the value separator. 

drop table if exists #Test;
create table #Test(Team varchar(20) not null primary key);
insert into #Test values('Falcons'), ('Saints'), ('Panthers'), ('Buccaneers');
select string_agg(Team, ':') from #Test;

-- We can also use the WITHIN GROUP clause to specify the order of the items in the delimited list.
select string_agg(Team, ':') within group(order by Team desc) from #Test;

------------------------------
-- Python Integration
------------------------------

EXEC sp_configure 'external scripts enabled', 1;
GO
RECONFIGURE;
GO
EXEC sp_configure 'external scripts enabled';
GO

drop table if exists dbo.Team;
create table dbo.Team(Team varchar(20) not null primary key);
insert into dbo.Team values('Falcons'), ('Saints'), ('Panthers'), ('Buccaneers');

-- Test

exec sp_execute_external_script @language = N'Python', @script = N'for x in InputDataSet.Team: print(x)', @input_data_1 = N'select Team from dbo.Team';

go

------------------------------
-- Graph Tables
------------------------------

-- Node table

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

-- Edge table

drop table if exists dbo.PlatoonsWith;
 
create table dbo.PlatoonsWith(
PlatoonName varchar(10) not null
) as Edge;
 
select * from dbo.PlatoonsWith;

-- Create relationships
-- First update the $node_id column names

declare @Node1 nvarchar(1000);
declare @Node2 nvarchar(1000);
 
select @Node1 = [$node_id_24EDA31E76B94E4BB8BE6162D275364F]
from dbo.Player
where Team = 'ATL' and Number = 2;
 
select @Node2 = [$node_id_24EDA31E76B94E4BB8BE6162D275364F]
from dbo.Player
where Team = 'ATL' and Number = 11;
 
insert into dbo.PlatoonsWith([$from_id_9BB8EDEBA50343C3BF0B715FE6E36FF2], [$to_id_13446ABFD4BE4CDAB73D3F91490082F3], PlatoonName)
values (@Node1, @Node2, 'Offense');
 
select * from dbo.PlatoonsWith;

-- Query graph data

select p1.FirstName + ' ' + p1.LastName as Player1, p1.Position as Player1Position,
    pw.PlatoonName, p2.FirstName + ' ' + p2.LastName as Player2, p2.Position as Player2Position
from dbo.Player as p1, dbo.PlatoonsWith as pw, dbo.Player as p2
where match(p1-(pw)->p2)
    and p1.Number = 2
    and p2.Team = 'ATL';

go
