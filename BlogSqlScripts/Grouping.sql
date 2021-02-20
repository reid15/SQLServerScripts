
-- Examples for ROLLUP, CUBE and GROUPING SETS
-- sqlrob.com

-- Table and Data

DROP TABLE IF EXISTS dbo.Sales;

CREATE TABLE dbo.Sales(
Country varchar(10) NOT NULL,
StateProvince varchar(20) NOT NULL,
City varchar(20) NOT NULL,
SalesCount tinyint NOT NULL
);

INSERT INTO dbo.Sales(Country, StateProvince, City, SalesCount) VALUES
('Canada', 'Ontario', 'Toronto', 5),
('Canada', 'Ontario', 'London', 2),
('US', 'Georgia', 'Atlanta', 10),
('US', 'Georgia', 'Columbus', 1),
('Canada', 'British Columbia', 'Vancouver', 3),
('US', 'Texas', 'Dallas', 8),
('US', 'Texas', 'Houston', 11);

-- Sales by Country and State

SELECT Country, StateProvince, SUM(SalesCount) as TotalSalesCount 
FROM dbo.Sales
GROUP BY Country, StateProvince
ORDER BY Country, StateProvince;

-- Grouping Sets

SELECT Country, StateProvince, SUM(SalesCount) as TotalSalesCount
FROM dbo.Sales
GROUP BY GROUPING SETS (
	(Country), (Country, StateProvince), ()
)
ORDER BY Country, StateProvince;

-- Cube

SELECT Country, StateProvince, SUM(SalesCount) as TotalSalesCount 
FROM dbo.Sales
GROUP BY CUBE(Country, StateProvince)
ORDER BY Country, StateProvince;

-- Rollup

SELECT Country, StateProvince, SUM(SalesCount) as TotalSalesCount 
FROM dbo.Sales
GROUP BY ROLLUP(Country, StateProvince)
ORDER BY Country, StateProvince;
