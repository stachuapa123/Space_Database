SELECT Celestial_Body.body_name, date_of_discovery, diameter, Observer.observer_id, observer_name, observer_surname
FROM Observer 
INNER JOIN Discovered 
	ON Observer.observer_id = Discovered.observer_id
INNER JOIN Discovery
	ON Discovered.discovered_body_name = Discovery.discovered_body_name
INNER JOIN Celestial_Body
	ON Discovery.discovered_body_name = Celestial_Body.body_name
  LEFT JOIN Planet
	ON Celestial_body.body_name = Planet.planet_name
  LEFT JOIN Star
	ON Celestial_body.body_name = Star.star_name
  LEFT JOIN Moon
	ON Celestial_body.body_name = Moon.moon_name
ORDER BY diameter DESC
-- show the names of observers who discovered the largest objects