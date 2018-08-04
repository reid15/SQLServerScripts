
-- Joins - ints vs. strings

-- Blog post: Integers vs Strings For Joins
-- http://robertbreid.com/2017/01/08/integers-vs-strings-for-joins/
-- January 8, 2017

if object_id('dbo.[State]') is not null
	drop table dbo.[State];
go

create table dbo.[State] (
StateId smallint not null identity(1,1),
StateCode char(2) not null,
StateName varchar(30) not null
);

create unique index IX_State_StateCode on dbo.[State] (StateCode);
create unique index IX_State_StateId on dbo.[State] (StateId);

-- US States

insert into dbo.[State](StateCode, StateName) values ('AK', 'Alaska');
insert into dbo.[State](StateCode, StateName) values ('AL', 'Alabama');
insert into dbo.[State](StateCode, StateName) values ('AR', 'Arkansas');
insert into dbo.[State](StateCode, StateName) values ('AZ', 'Arizona');
insert into dbo.[State](StateCode, StateName) values ('CA', 'California');
insert into dbo.[State](StateCode, StateName) values ('CO', 'Colorado');
insert into dbo.[State](StateCode, StateName) values ('CT', 'Connecticut');
insert into dbo.[State](StateCode, StateName) values ('DC', 'District of Columbia');
insert into dbo.[State](StateCode, StateName) values ('DE', 'Delaware');
insert into dbo.[State](StateCode, StateName) values ('FL', 'Florida');
insert into dbo.[State](StateCode, StateName) values ('GA', 'Georgia');
insert into dbo.[State](StateCode, StateName) values ('HI', 'Hawaii');
insert into dbo.[State](StateCode, StateName) values ('IA', 'Iowa');
insert into dbo.[State](StateCode, StateName) values ('ID', 'Idaho');
insert into dbo.[State](StateCode, StateName) values ('IL', 'Illinois');
insert into dbo.[State](StateCode, StateName) values ('IN', 'Indiana');
insert into dbo.[State](StateCode, StateName) values ('KS', 'Kansas');
insert into dbo.[State](StateCode, StateName) values ('KY', 'Kentucky');
insert into dbo.[State](StateCode, StateName) values ('LA', 'Louisiana');
insert into dbo.[State](StateCode, StateName) values ('MA', 'Massachusetts');
insert into dbo.[State](StateCode, StateName) values ('MD', 'Maryland');
insert into dbo.[State](StateCode, StateName) values ('ME', 'Maine');
insert into dbo.[State](StateCode, StateName) values ('MI', 'Michigan');
insert into dbo.[State](StateCode, StateName) values ('MN', 'Minnesota');
insert into dbo.[State](StateCode, StateName) values ('MO', 'Missouri');
insert into dbo.[State](StateCode, StateName) values ('MS', 'Mississippi');
insert into dbo.[State](StateCode, StateName) values ('MT', 'Montana');
insert into dbo.[State](StateCode, StateName) values ('NC', 'North Carolina');
insert into dbo.[State](StateCode, StateName) values ('ND', 'North Dakota');
insert into dbo.[State](StateCode, StateName) values ('NE', 'Nebraska');
insert into dbo.[State](StateCode, StateName) values ('NH', 'New Hampshire');
insert into dbo.[State](StateCode, StateName) values ('NJ', 'New Jersey');
insert into dbo.[State](StateCode, StateName) values ('NM', 'New Mexico');
insert into dbo.[State](StateCode, StateName) values ('NV', 'Nevada');
insert into dbo.[State](StateCode, StateName) values ('NY', 'New York');
insert into dbo.[State](StateCode, StateName) values ('OH', 'Ohio');
insert into dbo.[State](StateCode, StateName) values ('OK', 'Oklahoma');
insert into dbo.[State](StateCode, StateName) values ('OR', 'Oregon');
insert into dbo.[State](StateCode, StateName) values ('PA', 'Pennsylvania');
insert into dbo.[State](StateCode, StateName) values ('RI', 'Rhode Island');
insert into dbo.[State](StateCode, StateName) values ('SC', 'South Carolina');
insert into dbo.[State](StateCode, StateName) values ('SD', 'South Dakota');
insert into dbo.[State](StateCode, StateName) values ('TN', 'Tennessee');
insert into dbo.[State](StateCode, StateName) values ('TX', 'Texas');
insert into dbo.[State](StateCode, StateName) values ('UT', 'Utah');
insert into dbo.[State](StateCode, StateName) values ('VA', 'Virginia');
insert into dbo.[State](StateCode, StateName) values ('VT', 'Vermont');
insert into dbo.[State](StateCode, StateName) values ('WA', 'Washington');
insert into dbo.[State](StateCode, StateName) values ('WI', 'Wisconsin');
insert into dbo.[State](StateCode, StateName) values ('WV', 'West Virginia');
insert into dbo.[State](StateCode, StateName) values ('WY', 'Wyoming');
insert into dbo.[State](StateCode, StateName) values ('AP', 'Armed Forces Pacific');
insert into dbo.[State](StateCode, StateName) values ('AA', 'Armed Forces Americas');
insert into dbo.[State](StateCode, StateName) values ('AE', 'Armed Forces Europe');
insert into dbo.[State](StateCode, StateName) values ('AS', 'American Samoa');
insert into dbo.[State](StateCode, StateName) values ('GU', 'Guam');
insert into dbo.[State](StateCode, StateName) values ('MP', 'Northern Mariana Islands');
insert into dbo.[State](StateCode, StateName) values ('PR', 'Puerto Rico');
insert into dbo.[State](StateCode, StateName) values ('VI', 'Virgin Islands'); 
insert into dbo.[State](StateCode, StateName) values ('FM', 'Federated States of Micronesia');
insert into dbo.[State](StateCode, StateName) values ('MH', 'Marshall Islands');
insert into dbo.[State](StateCode, StateName) values ('PW', 'Palau');

go

if object_id('dbo.FirstName') is not null
	drop table dbo.FirstName;

create table dbo.FirstName (FirstName varchar(20) not null);

insert into dbo.FirstName values ('John');
insert into dbo.FirstName values ('Mary');
insert into dbo.FirstName values ('Ravi');
insert into dbo.FirstName values ('Sally');
insert into dbo.FirstName values ('Juan');
insert into dbo.FirstName values ('Jennifer');
insert into dbo.FirstName values ('Demarcus');
insert into dbo.FirstName values ('Juanita');
insert into dbo.FirstName values ('Donald');
insert into dbo.FirstName values ('Hillary');
insert into dbo.FirstName values ('Bob');
insert into dbo.FirstName values ('Shira');


go
if object_id('dbo.LastName') is not null
	drop table dbo.LastName;

create table dbo.LastName (LastName varchar(20) not null);

insert into dbo.LastName values ('Trump');
insert into dbo.LastName values ('Clinton');
insert into dbo.LastName values ('Johnston');
insert into dbo.LastName values ('Smith');
insert into dbo.LastName values ('Roderiguez');
insert into dbo.LastName values ('Jones');
insert into dbo.LastName values ('Lee');
insert into dbo.LastName values ('Park');
insert into dbo.LastName values ('Singh');
insert into dbo.LastName values ('Woods');
insert into dbo.LastName values ('Hobo');
insert into dbo.LastName values ('Burger');

go

-- Customer

if object_id('dbo.[Customer]') is not null
	drop table dbo.[Customer];
go
create table dbo.[Customer] (
CustomerId int not null primary key identity(1,1),
FirstName varchar(20) not null,
LastName varchar(20) not null,
StateId smallint not null,
StateCode char(2) not null
);
go

-- Customer indexes 

create nonclustered index IX_Customer_StateCode on dbo.[Customer] (StateCode)
include ([CustomerId],[FirstName],[LastName]);

create nonclustered index IX_Customer_StateId on dbo.[Customer] (StateId)
include ([CustomerId],[FirstName],[LastName]);

go

-- Customer inserts

insert into dbo.[Customer](FirstName, LastName, StateId, StateCode)
select f.FirstName, l.LastName, s.StateId, s.StateCode 
from dbo.[State] as s
cross join dbo.FirstName as f
cross join dbo.LastName as l;
go 225

select count(*) as CustomerCount from dbo.[Customer];

go

-- Comparison Queries - Set actual execution plan on

select c.CustomerId, c.FirstName, c.LastName, s.StateName
from dbo.Customer as c
join dbo.[State] as s
	on s.StateId = c.StateId;

select c.CustomerId, c.FirstName, c.LastName, s.StateName
from dbo.Customer as c
join dbo.[State] as s
	on s.StateCode = c.StateCode;

go

