CREATE OR ALTER VIEW Stars_and_Planets AS
SELECT *,
CASE 
        WHEN planet_name IS NOT NULL 
		THEN 'Planet'
		WHEN star_name IS NOT NULL 
		THEN 'Star'
END AS celestial_type
FROM Celestial_Body CB
	LEFT JOIN Planet P
	ON  CB.body_name = P.planet_name
	LEFT JOIN Star S
	ON  CB.body_name = S.star_name 
WHERE planet_name IS NOT NULL 
   OR star_name IS NOT NULL;
-- creating a view of only the planets and stars and their info from a superclass Celestial_Body
GO 

SELECT body_name, diameter, mass_scientific_notation, ' * 10^' AS TEXT ,mass_exp_10 
FROM Stars_and_Planets AS SP
WHERE SP.celestial_type = 'Planet' AND diameter <= 
(SELECT MIN(Stars_and_Planets.diameter)
	FROM Stars_and_Planets
	WHERE Stars_and_Planets.celestial_type = 'Star')
ORDER BY diameter DESC

-- selecting all planets which are not larger (in diameter) than the smallest star