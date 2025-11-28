-- SQL Server 2022

--https://learn.microsoft.com/en-us/sql/sql-server/what-s-new-in-sql-server-2022?view=sql-server-ver16#language

-- GREATEST and LEAST:
-- Return the greatest/least of values from 2 or more columns.

DROP TABLE IF EXISTS #Temperature;
 
CREATE TABLE #Temperature(
   City varchar(20) NOT NULL,
   JuneTemperature tinyint NOT NULL,
   JulyTemperature tinyint NOT NULL,
   AugustTemperature tinyint NOT NULL
);
 
INSERT INTO #Temperature(City, JuneTemperature, JulyTemperature, AugustTemperature) VALUES
('Atlanta', 90, 95, 93),
('Phoenix', 110, 115, 113),
('Chicago', 85, 90, 92);
 
SELECT City, JuneTemperature, JulyTemperature, AugustTemperature,
    LEAST(JuneTemperature, JulyTemperature, AugustTemperature) as LowTemp,
    GREATEST(JuneTemperature, JulyTemperature, AugustTemperature) as HighTemp
FROM #Temperature;

-- GENERATE_SERIES:
SELECT * FROM GENERATE_SERIES(1, 10);

--In this example, GENERATE_SERIES will return 10 rows, with the numbers from 1 to 10 as values. 
-- I’ve used this a few times in Postgres, especially in generating test data.
-- You can also specify a third parameter, in this case to return all of the even numbers in the sequence 2 to 10.
SELECT * FROM GENERATE_SERIES(2, 10, 2);

-- DATETRUNC:
-- DATETRUNC will truncate a date, using the specified date part.
-- In this case, the function will return a datetime of the first day of the current month.
SELECT DATETRUNC(MONTH, GETDATE());

-- DATE_BUCKET:
-- DATE_BUCKET lets a user define time periods that can be used to group or aggregate data.
-- If we want to use one week as a bucket, this query will return a datetime with the start of the window for today’s date.
SELECT DATE_BUCKET(WEEK, 1, GETDATE());

--We can also define the starting data to use for the buckets (The default is Jan 1, 1900).
SELECT DATE_BUCKET(WEEK, 1, GETDATE(), CAST('2022-01-01' as datetime));

--This query will take dates and a count for that date, group them into date buckets of one week, and give the count sum for each window/bucket.
WITH cte_sales as (
    SELECT * FROM (VALUES
    ('2022-10-01', 300),
    ('2022-09-30', 125),
    ('2022-10-10', 550),
    ('2022-10-20', 735),
    ('2022-10-05', 250),
    ('2022-10-07', 97),
    ('2022-10-11', 135),
    ('2022-10-21', 900)
) as t(date, count)
)
SELECT DATE_BUCKET(WEEK, 1, CAST(s.date as date)) as bucket_start, 
    SUM(s.count) as count_total
FROM cte_sales as s
GROUP BY DATE_BUCKET(WEEK, 1, CAST(s.date as date))
ORDER BY 1;

-- IS [NOT] DISTINCT FROM:

-- IS DISTINCT FROM gives a way to make a comparison that will takes NULLs into account.
-- This comparison won’t return a result, since we can’t compare a number to NULL:
SELECT 1 WHERE 1 <> NULL;

-- This query will return a result:
SELECT 1 WHERE 1 IS DISTINCT FROM NULL;

-- We can also use NOT in the comparison:
SELECT 1 WHERE 1 IS NOT DISTINCT FROM 1;

-- WINDOW:

-- WINDOW lets us define a partition and order clause once, and refer to it with a Window function.
WITH cte_sales as (
    SELECT * FROM (VALUES
    ('2022-09-30', 300),
    ('2022-09-30', 125),
    ('2022-10-01', 550),
    ('2022-10-01', 735),
    ('2022-10-01', 250),
    ('2022-10-02', 97),
    ('2022-10-02', 135),
    ('2022-10-02', 900)
) as t(date, count)
)
SELECT s.date, 
    ROW_NUMBER() OVER w as row_order,
    COUNT(s.count) OVER w as item_count,
    AVG(s.count) OVER w as item_avg
FROM cte_sales as s
WINDOW w as (PARTITION BY s.date ORDER BY s.count);

-- This allows us to define the PARTITION and ORDER BY values once, and use that clause for multiple window functions.

--JSON:

--ISJSON = Returns 1 if the supplied string is valid JSON.
--TRUE:
SELECT ISJSON('{ "version": 2022}');

--The following returns false, since the attribute name isn’t quote delimited.
SELECT ISJSON('{ version: 2022}');

-- JSON_OBJECT – Takes name/value pairs and returns them as JSON.
SELECT TOP 3 JSON_OBJECT('name': name, 'type': type_desc)
FROM sys.objects;

-- Result:
--{"name":"sysrscols","type":"SYSTEM_TABLE"}
--{"name":"sysrowsets","type":"SYSTEM_TABLE"}
--{"name":"sysclones","type":"SYSTEM_TABLE"}

-- JSON_ARRAY – Returns a string of an array of the specified items. 
-- I assume you would use this along with JSON_OBJECT if you were trying to build a JSON document with arrays.
SELECT TOP 3 JSON_ARRAY('name', name, 'type', type_desc)
FROM sys.objects;

-- Result:
--["name","sysrscols","type","SYSTEM_TABLE"]
--["name","sysrowsets","type","SYSTEM_TABLE"]
--["name","sysclones","type","SYSTEM_TABLE"]

--JSON_PATH_EXISTS – Return 1 if the specified attribute is in the JSON document.
--TRUE:
SELECT JSON_PATH_EXISTS('{"db_engine":"SQL Server", "version":2022}', '$.version');

--FALSE:
SELECT JSON_PATH_EXISTS('{"db_engine":"SQL Server", "version":2022}', '$.version.year');

-- Bit Manipulation:
-- These functions will take either numeric or binary data type values.
-- For my examples, I’ll use the integer 1001, which is 1111101001 in binary.

-- LEFT_SHIFT
-- In this example, LEFT_SHIFT will shift 1001 2 places to the left, and replace those spaces with 0, so we end up with 111110100100, 
-- which is 4004 as an integer. So we’re multiplying our value by 2^2(4).
SELECT LEFT_SHIFT(1001, 2);

-- RIGHT_SHIFT will drop the last two values, so in this case we end up with 250(11111010). So dividing by 2^2(4) and dropping the remainder.
SELECT RIGHT_SHIFT(1001, 2);
 
--BIT_COUNT – counts the number of 1s in your binary value, so for 1001 we would get 7.
SELECT BIT_COUNT(1001);

--GET_BIT – Get the value at the designated position in the binary value. The rightmost value is 0, and counts up moving to the left. 
-- For 1001, the third value from the right is 0.
SELECT GET_BIT(1001, 2);

--SET_BIT – In this example, set the bit at position 3 to a value of 0.
-- Which returns 993(1111100001)
SELECT SET_BIT(1001, 3, 0);
