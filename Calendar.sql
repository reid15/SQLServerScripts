
-- Calendar table

-- Function to calculate date of Easter

DROP FUNCTION IF EXISTS dbo.GetEasterDate;
GO
-- Return the date of Easter for the given year
-- Algorithm from US Navy site:
-- http://aa.usno.navy.mil/faq/docs/easter.php

CREATE FUNCTION dbo.GetEasterDate(
	@Year SMALLINT
)
RETURNS DATE
AS
BEGIN
	DECLARE @c SMALLINT = FLOOR(@Year / 100);
	DECLARE @n SMALLINT = @Year - 19 * FLOOR(@Year / 19);
	DECLARE @k SMALLINT = FLOOR((@c - 17) / 25);
	DECLARE @i SMALLINT = @c - FLOOR(@c / 4) - FLOOR((@c - @k) / 3) + 19 * @n + 15;
	SET @i = @i - 30 * FLOOR(@i / 30 );
	SET @i = @i - FLOOR(@i / 28) * (1 - FLOOR(@i / 28) * FLOOR(29 / ( @i + 1)) * FLOOR((21 - @n) / 11));
	DECLARE @j SMALLINT = @Year + FLOOR(@Year / 4) + @i + 2 - @c + FLOOR(@c / 4);
	SET @j = @j - 7 * (@j / 7);
	DECLARE @l SMALLINT = @i - @j;

	DECLARE @Month TINYINT = 3 + FLOOR((@l + 40) / 44);
	DECLARE @Day TINYINT = @l + 28 - 31 * FLOOR(@Month/4);

	DECLARE @ReturnDate DATE = DATEFROMPARTS(@Year, @Month, @Day);
	RETURN @ReturnDate;
END

GO

-- SELECT dbo.GetEasterDate(2017); -- April 16, 2017

-- Calendar

-- Set start and end dates

DECLARE @StartDate DATE = '2017-01-01';
DECLARE @EndDate DATE = '2017-12-31';

DROP TABLE IF EXISTS dbo.Calendar;

CREATE TABLE dbo.Calendar (
DateKey INT NOT NULL CONSTRAINT PK_Calendar PRIMARY KEY,
[Date] DATE NOT NULL CONSTRAINT UC_Calendar_Date UNIQUE,
[Year] SMALLINT NOT NULL,
[Month] TINYINT NOT NULL,
[Day] TINYINT NOT NULL,
[Week] TINYINT NOT NULL,
[Quarter] TINYINT NOT NULL,
[WeekDay] TINYINT NOT NULL,
[DayOfYear] SMALLINT NOT NULL,
IsWeekend BIT NOT NULL,
IsHoliday BIT NOT NULL,
[MonthName] VARCHAR(20) NOT NULL,
WeekDayName VARCHAR(20) NOT NULL
);

WITH DateRange AS (
	SELECT @StartDate AS [Date]
	UNION ALL
	SELECT DATEADD(DAY, 1, [Date])
	FROM DateRange
	WHERE [Date] < @EndDate
)

INSERT INTO dbo.Calendar(DateKey, [Date], [Year], [Month], [Day], [Week], [Quarter], [WeekDay], [DayOfYear], IsWeekend, IsHoliday,
	[MonthName], WeekDayName)
SELECT CONVERT(VARCHAR(20), [Date], 112), [Date], DATEPART(YEAR, [Date]), DATEPART(MONTH, [Date]), DATEPART(DAY, [Date]), DATEPART(WEEK, [Date]), 
	DATEPART(QUARTER, [Date]), DATEPART(WEEKDAY, [Date]), DATEPART(DAYOFYEAR, [Date]), 
	CASE WHEN DATEPART(WEEKDAY, [Date]) IN (1,7) THEN 1 ELSE 0 END,
	0, DATENAME(MONTH, [Date]), DATENAME(WEEKDAY, [Date])
FROM DateRange
OPTION (MAXRECURSION 0);

------------------------------------------------
-- Set US holidays -----------------------------
------------------------------------------------

-- New Year's Day
UPDATE dbo.Calendar SET IsHoliday = 1 WHERE [Month] = 1 AND [Day] = 1;

-- MLK Day - 3rd Monday in January

UPDATE c
SET IsHoliday = 1
FROM dbo.Calendar as c
JOIN (
	SELECT DateKey,
		ROW_NUMBER() OVER (PARTITION BY [Year] ORDER BY DateKey) AS RowNumber
	FROM dbo.Calendar
	WHERE [Month] = 1
		AND [WeekDay] = 2
) AS z
ON z.DateKey = c.DateKey
	AND z.RowNumber = 3;

-- Presidents' Day - 3rd Monday in February

UPDATE c
SET IsHoliday = 1
FROM dbo.Calendar as c
JOIN (
	SELECT DateKey,
		ROW_NUMBER() OVER (PARTITION BY [Year] ORDER BY DateKey) AS RowNumber
	FROM dbo.Calendar
	WHERE [Month] = 2
		AND [WeekDay] = 2
) AS z
ON z.DateKey = c.DateKey
	AND z.RowNumber = 3;

-- Easter

UPDATE dbo.Calendar
SET IsHoliday = 1
WHERE [Date] IN (
	SELECT dbo.GetEasterDate([Year]) as EasterDate
	FROM dbo.Calendar
	GROUP BY [Year]
);

-- Memorial Day - Last Monday in May

UPDATE c
SET IsHoliday = 1
FROM dbo.Calendar as c
JOIN (
	SELECT DateKey,
		ROW_NUMBER() OVER (PARTITION BY [Year] ORDER BY DateKey DESC) AS RowNumber
	FROM dbo.Calendar
	WHERE [Month] = 5
		AND [WeekDay] = 2
) AS z
ON z.DateKey = c.DateKey
	AND z.RowNumber = 1;

-- Independence Day - July 4

UPDATE dbo.Calendar SET IsHoliday = 1 WHERE [Month] = 7 AND [Day] = 4;

-- Labor Day - 1st Monday in September

UPDATE c
SET IsHoliday = 1
FROM dbo.Calendar as c
JOIN (
	SELECT DateKey,
		ROW_NUMBER() OVER (PARTITION BY [Year] ORDER BY DateKey) AS RowNumber
	FROM dbo.Calendar
	WHERE [Month] = 9
		AND [WeekDay] = 2
) AS z
ON z.DateKey = c.DateKey
	AND z.RowNumber = 1;

-- Veterans Day - Nov 11

UPDATE dbo.Calendar SET IsHoliday = 1 WHERE [Month] = 11 AND [Day] = 11;

-- Thanksgiving - 4th Thursday of November

UPDATE c
SET IsHoliday = 1
FROM dbo.Calendar as c
JOIN (
	SELECT DateKey,
		ROW_NUMBER() OVER (PARTITION BY [Year] ORDER BY DateKey) AS RowNumber
	FROM dbo.Calendar
	WHERE [Month] = 11
		AND [WeekDay] = 5
) AS z
ON z.DateKey = c.DateKey
	AND z.RowNumber = 4;

-- Christmas - December 25

UPDATE dbo.Calendar SET IsHoliday = 1 WHERE [Month] = 12 AND [Day] = 25;

--

-- SELECT * FROM dbo.Calendar WHERE IsHoliday = 1;

GO

