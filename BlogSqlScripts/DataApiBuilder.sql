
-- Data API Builder - Test Database

-- Clean existing objects

DROP TABLE IF EXISTS dbo.Player;
DROP TABLE IF EXISTS dbo.Team;

GO

-- Tables

CREATE TABLE dbo.Team (
	TeamId TINYINT NOT NULL PRIMARY KEY,
	TeamName VARCHAR(30) NOT NULL,
	TeamNickName VARCHAR(30) NOT NULL
);

CREATE TABLE dbo.Player(
	PlayerId INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TeamId TINYINT NOT NULL REFERENCES dbo.Team(TeamId),
	JerseyNumber TINYINT NOT NULL,
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	Position VARCHAR(2) NOT NULL,
	CONSTRAINT uq_Player_TeamJersey UNIQUE (TeamId, JerseyNumber)
);

GO

-- Data

INSERT INTO dbo.Team(TeamId, TeamName, TeamNickName)
VALUES
	(1, 'Atlanta', 'Falcons'),
	(2, 'Carolina', 'Panthers'),
	(3, 'New Orleans', 'Saints'),
	(4, 'Tampa Bay', 'Buccaneers');

INSERT INTO dbo.Player(TeamId, JerseyNumber, FirstName, LastName, Position)
VALUES
	(1, 9, 'Michael', 'Penix', 'QB'),
	(2, 9, 'Bryce', 'Young', 'QB'),
	(3, 2, 'Spencer', 'Rattler', 'QB'),
	(4, 6, 'Baker', 'Mayfield', 'QB');

GO

-- Select Data

SELECT * FROM dbo.Team;

SELECT * FROM dbo.Player;

GO

