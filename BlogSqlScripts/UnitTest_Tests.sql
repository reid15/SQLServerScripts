

-- www.robertbreid.com
-- Run unit tests with tSQLt
-- Feb 25, 2015

-- Create test class

exec tSQLt.NewTestClass 'TestClass';
go

-- Test procs

-- TestDB_InsertPlayer
if (object_id('TestClass.[TestDB_InsertPlayer]')) is not null
	drop procedure TestClass.[TestDB_InsertPlayer]
go
create procedure TestClass.[TestDB_InsertPlayer]
as
begin
	if object_id('TestClass.expected') is not null 
		drop table TestClass.expected;
	dbcc checkident('dbo.Player', 'reseed', 4);

	select [PlayerId], [TeamId], [PositionId], [PlayerNumber], [PlayerFirstName], [PlayerLastName]
	into TestClass.expected
	from dbo.Player;

	declare @TeamId tinyint = 1
	declare @PositionId tinyint = 4
	declare @PlayerNumber tinyint = 25
	declare @PlayerFirstName varchar(20) = 'William'
	declare @PlayerLastName varchar(20) = 'Moore'

	insert into TestClass.expected([TeamId], [PositionId], [PlayerNumber], [PlayerFirstName], [PlayerLastName])
	values (@TeamId, @PositionId, @PlayerNumber, @PlayerFirstName, @PlayerLastName)
	
	exec [dbo].[TestDB_InsertPlayer] @TeamId, @PositionId, @PlayerNumber, @PlayerFirstName, @PlayerLastName
	
	exec tSQLt.assertEqualsTable 'TestClass.expected', 'dbo.Player';
end;
go

-- TestDB_GetPositionId
if (object_id('TestClass.[TestDB_GetPositionId]')) is not null
	drop procedure TestClass.[TestDB_GetPositionId]
go
create procedure TestClass.[TestDB_GetPositionId]
as
begin
	declare @PositionId tinyint;
	select @PositionId = dbo.TestDB_GetPositionId ('Quarterback');
	exec tSQLt.AssertEquals 1, @PositionId;
end;
go

-- Run tests -

exec tSQLt.Run 'TestClass';

go


