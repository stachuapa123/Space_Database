CREATE OR ALTER VIEW MassRank AS 
    SELECT *,
        ROW_NUMBER() OVER 
        (
            PARTITION BY celestial_type 
            ORDER BY mass_exp_10 DESC, mass_scientific_notation DESC
        ) as bigRank, 
        ROW_NUMBER() OVER 
        (
            PARTITION BY celestial_type 
            ORDER BY mass_exp_10 ASC, mass_scientific_notation ASC
        ) as smallRank
    FROM Celestial_Types;
GO
/* Mass is in exponential notation so the view MassRank is used to order the data from the heaviest 
(first to rank the exponent, then mantissa)
in a particular celestial type (1 is the heaviest)*/
SELECT
    celestial_type,
    ROUND(AVG(diameter), 0) AS average_diameter,
    MAX(diameter) AS max_diameter, 
    ROUND(STDEV(diameter), 0) AS diameter_std,
    
    ROUND(AVG(surface_temperature), 0) AS average_temperature,
    MAX(surface_temperature) AS temperature_max,
    ROUND(STDEV(surface_temperature), 0) AS temperature_std,

    MAX(CASE WHEN bigRank = 1 THEN mass_scientific_notation END) 
    || ' * 10^' || 
    CAST(MAX(mass_exp_10) AS VARCHAR(2)) 
    || ' kg ' AS maximum_mass,

    MAX(CASE WHEN smallRank = 1 THEN mass_scientific_notation END)
    || ' * 10^' ||
    MIN(mass_exp_10)
    || ' kg ' AS minimum_mass
FROM MassRank
GROUP BY celestial_type;
/* group the smaller celestials (moons and planets) into 4 subgroups to see if there is any difference in their statistics 
(mean, max and std for diameter and temperature), max and min for the masses
the querry uses a view from the previous querry( gas planets, solid planets, moons with shorter perionds , moons with longer periods)*/
--SELECT * FROM MassRank