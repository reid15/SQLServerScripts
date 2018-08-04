
use TestDB;

drop function if exists dbo.IntToString;
go
create function dbo.IntToString(
@Input int
) 
returns char(4)
as

begin
declare @InputNumber as int = @Input;
declare @ReturnString as varchar(4) = '';
declare @Placeholder int = 0;
if (@InputNumber >= 729000)
  begin
	set @Placeholder = floor(@InputNumber / 729000);
	set @InputNumber = @InputNumber - (@Placeholder * 729000);
	set @ReturnString = @ReturnString + char(@Placeholder + 33);
  end
else
	set @ReturnString = @ReturnString + ' ';
if (@InputNumber >= 8100)
  begin
	set @Placeholder = floor(@InputNumber / 8100);
	set @InputNumber = @InputNumber - (@Placeholder * 8100);
	set @ReturnString = @ReturnString + char(@Placeholder + 33);
  end
else
	set @ReturnString = @ReturnString + ' ';
if (@InputNumber >= 90)
 begin
	set @Placeholder = floor(@InputNumber / 90);
	set @InputNumber = @InputNumber - (@Placeholder * 90);
	set @ReturnString = @ReturnString + char(@Placeholder + 33);
  end
else
	set @ReturnString = @ReturnString + ' ';
set @ReturnString = @ReturnString + char((@InputNumber % 90) + 33);
return cast(@ReturnString as char(4));

end
go

select dbo.IntToString(16200)
select dbo.IntToString(16290)

create table dbo.KeyInt (
KeyId int not null identity(1,1) primary key,
CreatedDate datetime not null default getdate(),
DisplayName varchar(50) not null,
IsActive bit not null default(1)
);
go

insert into dbo.KeyInt(DisplayName)
values ('Random Display String')
go 2000000

select count(*) from  dbo.KeyInt;
go

-- KeyString

create table dbo.KeyString (
KeyId char(4) collate SQL_Latin1_General_CP1_CS_AS not null primary key,
CreatedDate datetime not null default getdate(),
DisplayName varchar(50) not null,
IsActive bit not null default(1)
);
go

insert into dbo.KeyString(KeyId, DisplayName)
select dbo.IntToString(KeyId), DisplayName
from dbo.KeyInt;

go

select count(*) from  dbo.KeyString;
go

-- Join Table

drop table if exists dbo.JoinTable;
go
create table dbo.JoinTable(
IntKeyId int not null unique,
StringKeyId char(4) collate SQL_Latin1_General_CP1_CS_AS not null unique,
primary key (IntKeyId, StringKeyId)
);

insert into dbo.JoinTable(IntKeyId, StringKeyId)
select KeyID, dbo.IntToString(KeyId)
from dbo.KeyInt;

select count(*) from  dbo.JoinTable;
go

select * from dbo.KeyInt
select * from dbo.KeyString

dbcc dropcleanbuffers;

set statistics io on
set statistics time on

select * from dbo.KeyInt as k join dbo.JoinTable as j on j.IntKeyId = k.KeyID where k.KeyID = 1000000
select * from dbo.KeyString as k join dbo.JoinTable as j on j.StringKeyId = k.KeyId where k.KeyID = '"5BG'

set statistics time off

set statistics time on
select * from dbo.KeyInt as k join dbo.JoinTable as j on j.IntKeyId = k.KeyID;
select * from dbo.KeyString as k join dbo.JoinTable as j on j.StringKeyId = k.KeyId;
set statistics time off

go
