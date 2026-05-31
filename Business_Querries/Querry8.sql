-- Selecting the planets with added info about the stars that they are surrounding
CREATE OR ALTER VIEW Stars_and_planets2 AS
SELECT star_name,
	COUNT(*) OVER (PARTITION BY star_name) AS star_count -- counting how many times a star appears in this table
	,planet_name, orbit_time, semi_major_axis
FROM Planet P
INNER JOIN Solar_System SL
ON P.solar_system_name = SL.solar_system_name
INNER JOIN Star S
ON SL.center_star = S.star_name;
GO

SELECT * ,
POWER(orbit_time, 2) AS 'T^2',
POWER(semi_major_axis, 3) AS 'R^3',
ROUND((POWER(orbit_time, 2) / (POWER(semi_major_axis, 3))),3) AS Kepler_3rd_law_dependency
FROM Stars_and_planets2 AS SP2
WHERE star_count > 1
ORDER BY star_count DESC

/*kepler's 3rd law states that the semi major axis of the planets orbit and the time of the planets orbit are 
  dependent in a way that always (T^2/R^3) is constant for all the planets that surround a certain star
  here is the table to check it*/
