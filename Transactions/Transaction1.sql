--planet Vega moves from constellation Lyra to constellation Dorado
SELECT * 
FROM Star_Constellation
WHERE constellation_name IN ('Lyra', 'Dorado')

GO

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;

    UPDATE Star 
    SET Star.constellation_name = 'Dorado'
    WHERE star_name = 'Vega';


    UPDATE star_constellation
    SET no_stars = no_stars - 1
    WHERE constellation_name = 'Lyra';

    UPDATE star_constellation
    SET no_stars = no_stars + 1
    WHERE constellation_name = 'Dorado';

COMMIT TRANSACTION;

GO

SELECT * 
FROM Star_Constellation
WHERE constellation_name IN ('Lyra', 'Dorado')