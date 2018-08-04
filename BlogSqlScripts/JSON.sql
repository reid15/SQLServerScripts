
-- SQL Server - JSON
-- SQL Rob - https://robertbreid.com/

-- Test Data
drop table if exists dbo.JsonTest;

create table dbo.JsonTest(
FirstName varchar(20) null,
LastName varchar(20) not null,
StatusCode varchar(10) not null
);
insert into dbo.JsonTest(FirstName, LastName, StatusCode) values ('Mike', 'Smith', 'Inactive');
insert into dbo.JsonTest(FirstName, LastName, StatusCode) values ('Jane', 'Doe', 'Active');
insert into dbo.JsonTest(FirstName, LastName, StatusCode) values (NULL, 'Jones', 'Pending');

select * from dbo.JsonTest;

-- Returning relational data as JSON

select FirstName, LastName, StatusCode FROM dbo.JsonTest FOR JSON AUTO;
select FirstName, LastName, StatusCode, 'Atlanta' as [Address.City], 'GA' as [Address.State] FROM dbo.JsonTest FOR JSON PATH, ROOT('People');
select FirstName, LastName, StatusCode FROM dbo.JsonTest FOR JSON PATH, INCLUDE_NULL_VALUES, WITHOUT_ARRAY_WRAPPER;

-- Each JSON node to its own row

declare @JSON as varchar(4000) = '[{"FirstName":"Mike","LastName":"Smith","StatusCode":"Inactive"},{"FirstName":"Jane","LastName":"Doe","StatusCode":"Active"},{"LastName":"Jones","StatusCode":"Pending"}]';

SELECT * FROM OPENJSON(@JSON);
go

-- JSON to rows and columns - Matching column names

declare @JSON as varchar(4000) = '[{"FirstName":"Mike","LastName":"Smith","StatusCode":"Inactive"},{"FirstName":"Jane","LastName":"Doe","StatusCode":"Active"},{"LastName":"Jones","StatusCode":"Pending"}]';

SELECT * FROM OPENJSON(@JSON)
WITH (
FirstName varchar(20),
LastName varchar(20),
StatusCode varchar(10)
);
go

-- -- JSON to rows and columns - Mapping column/attribute names

declare @JSON as varchar(4000) = '[{"FirstName":"Mike","LastName":"Smith","StatusCode":"Inactive"},{"FirstName":"Jane","LastName":"Doe","StatusCode":"Active"},{"LastName":"Jones","StatusCode":"Pending"}]';

SELECT * FROM OPENJSON(@JSON)
WITH (
GivenName varchar(20) '$.FirstName',
Surname varchar(20) '$.LastName',
StatusCode varchar(10)
);
go

-- JSON functions

declare @JSON as varchar(4000) = '[{"FirstName":"Mike","LastName":"Smith","StatusCode":"Inactive", "Language":["English","Spanish"]},{"FirstName":"Jane","LastName":"Doe","StatusCode":"Active"}]';
declare @NotJson as varchar(4000) = 'Not a JSON string';

-- Return bit to determine if a string is valid JSON or not
SELECT ISJSON(@JSON);
SELECT ISJSON(@NotJson);

-- Get scalar value - 0 based array
SELECT JSON_VALUE(@JSON, '$[1].FirstName');

-- Return JSON fragment or array of values
SELECT JSON_QUERY(@JSON, '$[0].Language');

-- Default is lax mode - returns NULL on error
-- Strict will raise error

SELECT JSON_QUERY(@JSON, 'lax $[1].Language');
SELECT JSON_QUERY(@JSON, 'strict $[1].Language');

GO
