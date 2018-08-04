
-- Sample Tables And Data
-- Rob Reid - June 27, 2014

-- Clear existing versions

if (object_id('Student') is not null)
	drop table Student
if (object_id('Gender') is not null)
	drop table Gender
if (object_id('Major') is not null)
	drop table Major
go

-- Schema

create table Gender (
GenderId tinyint not null primary key clustered,
DisplayName nvarchar(10) not null
)

create table Major (
MajorId tinyint not null primary key clustered,
DisplayName nvarchar(10) not null
)

create table Student (
StudentId int not null primary key clustered,
FirstName varchar(20) not null,
MiddleName varchar(20) null,
LastName varchar(20) not null,
GenderId tinyint not null,
MajorId tinyint null,
EnrollmentDate date not null,
foreign key (GenderId) references Gender(GenderId),
foreign key (MajorId) references Major(MajorId) 
)

go

-- Data

insert into Gender (GenderId, DisplayName) values (1, 'Female')
insert into Gender (GenderId, DisplayName) values (2, 'Male')
insert into Gender (GenderId, DisplayName) values (3, 'Other')
insert into Gender (GenderId, DisplayName) values (4, 'Unknown')

insert into Major (MajorId, DisplayName) values (1, 'Math')
insert into Major (MajorId, DisplayName) values (2, 'English')
insert into Major (MajorId, DisplayName) values (3, 'Biology')

insert into Student (StudentId, FirstName, MiddleName, LastName, GenderId, MajorId, EnrollmentDate)
values (1, 'Mary', 'Beth', 'Smith', 1, 1, '2013-01-02')
insert into Student (StudentId, FirstName, LastName, GenderId, MajorId, EnrollmentDate)
values (2, 'John', 'Miller', 2, 2, '2012-09-01')
insert into Student (StudentId, FirstName, LastName, GenderId, MajorId, EnrollmentDate)
values (3, 'Jane', 'Doe', 1, 3, '2011-09-01')
insert into Student (StudentId, FirstName, LastName, GenderId, MajorId, EnrollmentDate)
values (4, 'Pat', 'Baker', 4, NULL, '2014-01-02')
insert into Student (StudentId, FirstName, LastName, GenderId, MajorId, EnrollmentDate)
values (5, 'Elizabeth', 'Parker', 1, NULL, '2013-11-01')
insert into Student (StudentId, FirstName, MiddleName, LastName, GenderId, MajorId, EnrollmentDate)
values (6, 'David', 'William', 'Stone', 1, 1, '2013-09-01')

go
