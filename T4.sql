SELECT budget
FROM Observatory
WHERE observatory_id = 'S2000001';

GO 

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; -- a disruptor transaction
-- just to see what happens
BEGIN TRANSACTION;

UPDATE Observatory
SET budget = budget / 2
WHERE observatory_id = 'S2000001';

COMMIT TRANSACTION;

SELECT budget
FROM Observatory
WHERE observatory_id = 'S2000001';