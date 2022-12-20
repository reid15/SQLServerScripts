
-- Generate Schedule

USE Schedule;

-- Cleanup

DROP TABLE IF EXISTS dbo.Match;
DROP TABLE IF EXISTS dbo.MatchDay;
DROP TABLE IF EXISTS dbo.Team;
DROP TABLE IF EXISTS dbo.Season;

-- Create Tables

CREATE TABLE dbo.Team(
	TeamId tinyint IDENTITY(1,1) NOT NULL PRIMARY KEY,
	TeamName varchar(30) NOT NULL UNIQUE
);

CREATE TABLE dbo.Season(
	SeasonId tinyint IDENTITY(1,1) NOT NULL PRIMARY KEY,
	SeasonName varchar(30) NOT NULL UNIQUE
);

CREATE TABLE dbo.MatchDay(
	MatchDayId smallint IDENTITY(1,1) NOT NULL PRIMARY KEY,
	SeasonId tinyint NOT NULL REFERENCES dbo.Season(SeasonId),
	WeekNumber tinyint NOT NULL,
	MatchDate date NOT NULL
);

CREATE TABLE dbo.Match(
	MatchId int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	MatchDayId smallint NOT NULL REFERENCES dbo.MatchDay(MatchDayId),
	HomeTeamId tinyint NOT NULL REFERENCES dbo.Team(TeamId),
	AwayTeamId tinyint NOT NULL REFERENCES dbo.Team(TeamId),
	UNIQUE(MatchDayId, HomeTeamId),
	UNIQUE(MatchDayId, AwayTeamId),
	CHECK(HomeTeamId <> AwayTeamId)
);

-- Data

INSERT INTO dbo.Team(TeamName) VALUES
('Arsenal'),
('Aston Villa'), 
('Bournemouth'),
('Brentford'),
('Brighton & Hove Albion'),
('Chelsea'),
('Crystal Palace'), 
('Everton'),
('Fulham'),
('Leeds United'), 
('Leicester City'),
('Liverpool'),
('Manchester City'), 
('Manchester United'),
('Newcastle United'),
('Nottingham Forest'),
('Southampton'),
('Tottenham Hotspur'), 
('West Ham United'),
('Wolverhampton Wanderers');

INSERT INTO dbo.Season(SeasonName) VALUES ('2022-23');

-- Generate Match Day records

DROP TABLE IF EXISTS #week;

CREATE TABLE #week(GameDate date NOT NULL);

INSERT INTO #week(GameDate) VALUES 
('2022 6 August'),
('2022 13 August'),
('2022 20 August'),
('2022 27 August'),
('2022 31 August'),
('2022 3 September'),
('2022 10 September'),
('2022 17 September'),
('2022 1 October'),
('2022 8 October'),
('2022 15 October'),
('2022 19 October'),
('2022 22 October'),
('2022 29 October'),
('2022 5 November'),
('2022 12 November'),
('2022 26 December'),
('2022 31 December'),
('2023 2 January'),
('2023 14 January'),
('2023 21 January'),
('2023 4 February'),
('2023 11 February'),
('2023 18 February'),
('2023 25 February'),
('2023 4 March'),
('2023 11 March'),
('2023 18 March'),
('2023 1 April'),
('2023 8 April'),
('2023 15 April'),
('2023 22 April'),
('2023 26 April'),
('2023 29 April'),
('2023 6 May'),
('2023 13 May'),
('2023 20 May'),
('2023 28 May');

--select * from #week;

INSERT INTO dbo.MatchDay(SeasonId, WeekNumber, MatchDate)
SELECT s.SeasonId, ROW_NUMBER() OVER (ORDER BY w.GameDate), w.GameDate
FROM dbo.Season as s
CROSS JOIN #week as w
WHERE s.SeasonName = '2022-23'
ORDER BY w.GameDate;

DROP TABLE IF EXISTS #week;

--SELECT * FROM dbo.Team;
--SELECT * FROM dbo.MatchDay;

-- Generate Schedule

-- Use a random order for teams

DROP TABLE IF EXISTS #TeamOrder;

CREATE TABLE #TeamOrder(TeamId tinyint NOT NULL, PairingNumber tinyint NOT NULL);

INSERT INTO #TeamOrder(TeamId, PairingNumber)
SELECT TeamId, ROW_NUMBER() OVER(ORDER BY NEWID()) as PairingNumber
FROM dbo.Team;

-- Match Pairing Numbers for each Match Day
WITH cte_pairings as (
	SELECT * FROM (
	VALUES (1, 20), (2,19), (3, 18), (4,17), (5, 16), (6, 15), (7, 14), (8, 13), (9, 12), (10, 11)
	) as t(Team1, Team2)
),
-- Get Match Days for first half of the season
cte_match_day as (
	SELECT md.MatchDayId, md.WeekNumber
	FROM dbo.MatchDay as md
	JOIN dbo.Season as s ON s.SeasonId = md.SeasonId
	WHERE md.WeekNumber <= 19
	AND s.SeasonName = '2022-23'
),
cte_match_day_pairing as (
	SELECT md.MatchDayId, md.WeekNumber, t.TeamId,
	CASE WHEN t.PairingNumber = 1 THEN 1
		WHEN (t.PairingNumber + md.WeekNumber) > 20 THEN ((t.PairingNumber + md.WeekNumber) % 20) + 1
		ELSE (t.PairingNumber + md.WeekNumber) END as PairingNumber
	FROM cte_match_day as md
	CROSS JOIN #TeamOrder as t
)
INSERT INTO dbo.Match(MatchDayId, HomeTeamId, AwayTeamId)
SELECT m1.MatchDayId, m1.TeamId as Team1, m2.TeamId as Team1
FROM cte_pairings as p
CROSS JOIN cte_match_day as md
JOIN cte_match_day_pairing as m1 ON m1.PairingNumber = p.Team1 AND m1.MatchDayId = md.MatchDayId
JOIN cte_match_day_pairing as m2 ON m2.PairingNumber = p.Team2 AND m2.MatchDayId = md.MatchDayId;

-- Use same matchups but reverse home/away for 2nd half of season

INSERT INTO dbo.Match(AwayTeamId, HomeTeamId, MatchDayId)
SELECT m.HomeTeamId, m.AwayTeamId, nmd.MatchDayId
FROM dbo.Match as m
JOIN dbo.MatchDay as md 
	ON md.MatchDayId = m.MatchDayId
-- Get the 2nd half Match Day - Add 19 for the 19 matches to generate
JOIN dbo.MatchDay as nmd
	ON nmd.WeekNumber = (md.WeekNumber + 19)
	AND nmd.SeasonId = md.SeasonId
WHERE md.SeasonId = 1;

-- Return Schedule

SELECT md.WeekNumber, md.MatchDate, ht.TeamName as HomeTeam, rt.TeamName as AwayTeam
FROM dbo.Match as m
JOIN dbo.MatchDay as md ON md.MatchDayId = m.MatchDayId
JOIN dbo.Team as ht ON ht.TeamId = m.HomeTeamId
JOIN dbo.Team as rt ON rt.TeamId = m.AwayTeamId
ORDER BY md.WeekNumber, ht.TeamName;
