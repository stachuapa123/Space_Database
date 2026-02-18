
SELECT planet_name, semi_major_axis, state_of_matter, Planet.solar_system_name FROM Planet
	INNER JOIN Celestial_Body
	ON Planet.planet_name = Celestial_Body.body_name
	INNER JOIN Solar_System
	ON Planet.solar_system_name = Solar_System.solar_system_name
	WHERE planet_name IN
		(
			SELECT planet_name
			FROM Planet P
			INNER JOIN Moon M
			ON P.planet_name = M.parent_planet_name
			GROUP BY planet_name
			HAVING (COUNT(*) > 1)
		)
		AND semi_major_axis >
		(	
			SELECT AVG(semi_major_axis)
			FROM Planet
			WHERE solar_system_name = 'The Solar System'
		);

-- select all the planets which have multiple moons and have a semi major axis larger than the on average a planet in our solar system
