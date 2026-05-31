CREATE OR ALTER VIEW Densities AS
  SELECT
    body_name,
    ROUND((mass_exp_10 + LOG10(mass_scientific_notation)), 2) AS log_of_mass,
    diameter AS diameter_km,
    ROUND (LOG10(diameter),4) AS log10_of_diameter,
    ROUND ( (mass_exp_10 + LOG10((mass_scientific_notation)) ) - (LOG10((diameter)) * 3),2) AS density_coefficient, 
    CASE 
        WHEN planet_name IS NOT NULL 
		THEN 'Planet'
		WHEN star_name IS NOT NULL 
		THEN 'Star'
        WHEN moon_name IS NOT NULL 
		THEN 'Moon'
		WHEN black_hole_name IS NOT NULL 
		THEN 'Black_hole'
        ELSE 'error' 
	END AS celestial_type,

    CASE
        WHEN planet_name IS NOT NULL 
		THEN state_of_matter
		WHEN star_name IS NOT NULL 
		THEN star_type
		WHEN black_hole_name IS NOT NULL 
		THEN B.type_
        ELSE '-' 
	END AS Subtype

    FROM Celestial_Body CB
    LEFT JOIN Planet P
	ON  CB.body_name = P.planet_name
	LEFT JOIN Moon
	ON  CB.body_name = Moon.moon_name
    LEFT JOIN Black_Hole B
	ON  CB.body_name = B.black_hole_name
	LEFT JOIN Star S
	ON  CB.body_name = S.star_name
  GO
  /* a querry to show which exact types of celestial bodies tend to be the most dense, here are 5 most dense and 5 least dense 
  the density coefficient is not the exact density value, but its logarithm, it is done like this because database does not store large numbers such as 10^41, but 
  its exponent and mantissa*/
  SELECT TOP(5) * FROM Densities
  ORDER BY density_coefficient DESC

  SELECT TOP(5) * FROM Densities
  ORDER BY density_coefficient ASC

