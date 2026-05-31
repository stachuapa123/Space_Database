CREATE OR ALTER VIEW Observatory_spendings AS

SELECT MS.observatory_id, MAX(observatory_name) AS observatory_name,
	COUNT(MS.celestial_name) AS no_observatories_monitoring,
	SUM(cost) AS Total_cost_per_year
FROM Monitor_Schedule MS
	INNER JOIN Celestial_Body
	ON MS.celestial_name = Celestial_Body.body_name
	INNER JOIN Observatory
	ON MS.observatory_id = Observatory.observatory_id
GROUP BY MS.observatory_id;

GO
-- calculate the sum of the spendings on monitoring made by a particular observatory

SELECT * FROM Observatory_spendings 
WHERE observatory_id = 'S2000001'

