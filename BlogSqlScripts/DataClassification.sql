
-- SQL Data Discovery and Classification

drop table if exists dbo.DataClassification;

create table dbo.DataClassification(
CustomerId int not null primary key identity(1,1),
FirstName varchar(50) not null,
LastName varchar(50) not null,
DOB date not null,
SSN char(9) not null,
CreditCardNumber varchar(16) null
);

go
