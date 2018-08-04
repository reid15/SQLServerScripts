


set ansi_nulls on
go
set quoted_identifier on
go

-- Tables

if object_id('Customer') is not null
	drop table Customer
go
if object_id('Address') is not null
	drop table [Address]
go
if object_id('Gender') is not null
	drop table Gender
go


create table Gender(
Gender char(1) not null primary key clustered,
GenderDescription varchar(20) not null
)
go

create table Customer (
CustomerId int not null primary key clustered,
FirstName varchar(20) not null,
LastName varchar(20) not null,
AddressId int not null,
Gender char(1) not null
)
go

create table [Address] (
AddressId int not null primary key clustered,
AddressLine1 varchar(30) not null,
AddressLine2 varchar(30) not null,
City varchar(30) not null,
[State] char(2) not null,
ZipCode char(5) not null,
Country varchar(3) not null
)
go

-- Foreign Keys

alter table [dbo].[Customer] with check add constraint [FK_Customer_Gender]
foreign key ([Gender])
references [dbo].[Gender] ([Gender])

alter table [dbo].[Customer] with check add constraint [FK_Customer_Address]
foreign key ([AddressId])
references [dbo].[Address] ([AddressId])
go

-- Data

-- Gender
insert into Gender(Gender, GenderDescription) values ('F', 'Female')
insert into Gender(Gender, GenderDescription) values ('M', 'Male')
insert into Gender(Gender, GenderDescription) values ('U', 'Unknown')
go

-- Address
insert into [Address] (AddressId, AddressLine1, AddressLine2, City, [State], ZipCode, Country)
values (1, '123 Main St.', '', 'Decatur', 'GA', '30030', 'USA')

insert into [Address] (AddressId, AddressLine1, AddressLine2, City, [State], ZipCode, Country)
values (2, '456 Oak Rd.', '', 'Decatur', 'GA', '30034', 'USA')

insert into [Address] (AddressId, AddressLine1, AddressLine2, City, [State], ZipCode, Country)
values (3, '789 First St.', '', 'Atlanta', 'GA', '30301', 'USA')

insert into [Address] (AddressId, AddressLine1, AddressLine2, City, [State], ZipCode, Country)
values (4, '111 Second St.', '', 'Atlanta', 'GA', '30301', 'USA')

insert into [Address] (AddressId, AddressLine1, AddressLine2, City, [State], ZipCode, Country)
values (5, '222 Washington Ave', '', 'Atlanta', 'GA', '30302', 'USA')

insert into [Address] (AddressId, AddressLine1, AddressLine2, City, [State], ZipCode, Country)
values (6, '333 Pine Circle', '', 'Atlanta', 'GA', '30302', 'USA')

insert into [Address] (AddressId, AddressLine1, AddressLine2, City, [State], ZipCode, Country)
values (7, '444 Maple Ave.', '', 'Atlanta', 'GA', '30303', 'USA')

insert into [Address] (AddressId, AddressLine1, AddressLine2, City, [State], ZipCode, Country)
values (8, '555 King Blvd', '', 'Atlanta', 'GA', '30304', 'USA')

insert into [Address] (AddressId, AddressLine1, AddressLine2, City, [State], ZipCode, Country)
values (9, '666 Mitchell St.', '', 'Atlanta', 'GA', '30305', 'USA')

insert into [Address] (AddressId, AddressLine1, AddressLine2, City, [State], ZipCode, Country)
values (10, '777 Carter Pkwy', '', 'Atlanta', 'GA', '30305', 'USA')

go

-- Customer

insert into Customer (CustomerId, FirstName, LastName, Gender, AddressId)
values (1, 'Joe', 'Smith', 'M', 1)

insert into Customer (CustomerId, FirstName, LastName, Gender, AddressId)
values (2, 'Sara', 'Jones', 'F', 2)

insert into Customer (CustomerId, FirstName, LastName, Gender, AddressId)
values (3, 'Elizabeth', 'Miller', 'F', 3)

insert into Customer (CustomerId, FirstName, LastName, Gender, AddressId)
values (4, 'Mike', 'Baker', 'M', 4)

insert into Customer (CustomerId, FirstName, LastName, Gender, AddressId)
values (5, 'Rachel', 'Hunter', 'F', 5)

insert into Customer (CustomerId, FirstName, LastName, Gender, AddressId)
values (6, 'Pat', 'Wills', 'U', 6)

insert into Customer (CustomerId, FirstName, LastName, Gender, AddressId)
values (7, 'Steve', 'Cooper', 'M', 7)

insert into Customer (CustomerId, FirstName, LastName, Gender, AddressId)
values (8, 'Mary', 'Reece', 'F', 8)

insert into Customer (CustomerId, FirstName, LastName, Gender, AddressId)
values (9, 'Shannon', 'Parker', 'U', 9)

insert into Customer (CustomerId, FirstName, LastName, Gender, AddressId)
values (10, 'Tiffany', 'Jenkins', 'F', 10)

insert into Customer (CustomerId, FirstName, LastName, Gender, AddressId)
values (11, 'Tommy', 'Jenkins', 'M', 10)

go

select * from Gender
select * from [Address]
select * from Customer

go



