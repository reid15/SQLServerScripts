
-- SQL Server Policy Based Management
-- www.sqlrob.com
-- March 19, 2015
-- Run on user database

-- Create Condition

Declare @condition_id int
EXEC msdb.dbo.sp_syspolicy_add_condition @name=N'TableName', @description=N'', @facet=N'Table', @expression=N'<Operator>
  <TypeClass>Bool</TypeClass>
  <OpType>NOT_LIKE</OpType>
  <Count>2</Count>
  <Attribute>
    <TypeClass>String</TypeClass>
    <Name>Name</Name>
  </Attribute>
  <Constant>
    <TypeClass>String</TypeClass>
    <ObjType>System.String</ObjType>
    <Value>tbl%</Value>
  </Constant>
</Operator>', @is_name_condition=4, @obj_name=N'tbl%', @condition_id=@condition_id OUTPUT
Select @condition_id

GO

-- Create Policy

Declare @object_set_id int
EXEC msdb.dbo.sp_syspolicy_add_object_set @object_set_name=N'TableName_ObjectSet', @facet=N'Table', @object_set_id=@object_set_id OUTPUT
Select @object_set_id

Declare @target_set_id int
EXEC msdb.dbo.sp_syspolicy_add_target_set @object_set_name=N'TableName_ObjectSet', @type_skeleton=N'Server/Database/Table', @type=N'TABLE', @enabled=True, @target_set_id=@target_set_id OUTPUT
Select @target_set_id

EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database/Table', @level_name=N'Table', @condition_name=N'', @target_set_level_id=0
EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database', @level_name=N'Database', @condition_name=N'', @target_set_level_id=0

GO

Declare @policy_id int
EXEC msdb.dbo.sp_syspolicy_add_policy @name=N'TableName', @condition_name=N'TableName', @policy_category=N'', @description=N'', @help_text=N'', @help_link=N'', @schedule_uid=N'00000000-0000-0000-0000-000000000000', @execution_mode=0, @is_enabled=False, @policy_id=@policy_id OUTPUT, @root_condition_name=N'', @object_set=N'TableName_ObjectSet'
Select @policy_id

GO

-- Create Tables

if object_id('tblTable') is not null
	drop table tblTable
go
create table tblTable (
TableId int not null identity(1,1) primary key,
ModifiedAt datetime not null,
SortOrder int not null,
DisplayName varchar(20) not null)
go

if object_id('Table2') is not null
	drop table Table2
go
create table Table2 (
TableId int not null identity(1,1) primary key,
ModifiedAt datetime not null,
SortOrder int not null,
DisplayName varchar(20) not null)
go

