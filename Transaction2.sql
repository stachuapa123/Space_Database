SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- Agata Gwiezdna 'F1234567890' leaves from Mauna Kea 'G1000001', she was not the boss
BEGIN TRANSACTION;

    UPDATE Work
    SET date_of_end = '2026-01-26'
    WHERE observer_id = 'F1234567890' 
      AND observatory_id = 'G1000001'
      AND date_of_end IS NULL;  

    UPDATE Observatory
    SET boss_id = NULL
    WHERE boss_id = 'F1234567890'
        AND Observatory_id = 'G1000001' 

COMMIT TRANSACTION;

SELECT observer_name, observer_surname, date_of_start, date_of_end FROM Work
INNER JOIN Observer
ON Work.observer_id = Observer.observer_id
WHERE Work.observer_id = 'F1234567890'