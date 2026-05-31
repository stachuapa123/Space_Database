-- group the smaller celestials (moons and planets) into 4 subgroups 
-- gas planets, solid planets, moons with shorter orbit perionds (shorter than our moon) , moons with longer orbit periods
CREATE OR ALTER VIEW Celestial_Types AS
SELECT body_name, mass_scientific_notation, mass_exp_10, diameter, surface_temperature,
	CASE 
        WHEN planet_name IS NOT NULL 
		AND state_of_matter LIKE 'Gas'
		THEN 'Gas Planet'
		WHEN planet_name IS NOT NULL 
		AND state_of_matter LIKE 'Solid'
		THEN 'Solid Planet'
        WHEN moon_name IS NOT NULL 
		AND moon.orbit_time >= 1
		THEN 'Long day Moon'
		WHEN moon_name IS NOT NULL 
		AND moon.orbit_time < 1
		THEN 'Short day Moon'
        ELSE 'error' 
	END AS celestial_type
FROM Celestial_Body 
	LEFT JOIN Planet
	ON  Celestial_Body.body_name = Planet.planet_name
	LEFT JOIN Moon
	ON  Celestial_Body.body_name = Moon.moon_name 
WHERE planet_name IS NOT NULL 
   OR moon_name IS NOT NULL;

GO

SELECT celestial_type, COUNT(*) AS celestials_per_type
FROM Celestial_Types
GROUP BY celestial_type
ORDER BY celestials_per_type DESC
/* show how many of these types are in a database and */