SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
--SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
--SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

BEGIN TRANSACTION;

DECLARE @InitialBudget DECIMAL(15, 2);

SELECT @InitialBudget = budget
FROM Observatory
WHERE observatory_id = 'S2000001';

PRINT 'INITIAL BUDGET: ';
PRINT @InitialBudget;

IF @InitialBudget <= 0
    BEGIN
        PRINT 'OBSERVATORY IS BROKE';
        ROLLBACK TRANSACTION;
        RETURN;
    END
--WAITFOR DELAY '00:00:10'; --execute the disruptor (phantom) transaction

DECLARE @TotalCost DECIMAL(15, 2); -- calculate the total cost of the monitoring

SELECT @TotalCost = 
	ISNULL(SUM(cost), 0.00)   
    FROM Monitor_Schedule MS
	INNER JOIN Celestial_Body
	ON MS.celestial_name = Celestial_Body.body_name
	WHERE MS.observatory_id = 'S2000001'
	GROUP BY MS.observatory_id;

PRINT 'TOTAL COST: ';
PRINT @TotalCost;

WAITFOR DELAY '00:00:10'; --execute the disruptor (fuzzy read) transaction

IF @InitialBudget < @TotalCost
    BEGIN
        PRINT 'OBSERVATORY CANNOT AFFORD MONITOR PAYMENTS';
        ROLLBACK TRANSACTION;
        RETURN; 
    END
ELSE
	UPDATE Observatory
		SET budget = budget - @TotalCost
		WHERE observatory_id = 'S2000001';

DECLARE @FinalBudget DECIMAL(15, 2);	

SELECT @FinalBudget = budget
FROM Observatory
WHERE observatory_id = 'S2000001';

PRINT 'INITIAL BUDGET - TOTAL COST ';
PRINT (@InitialBudget - @TotalCost);

PRINT 'FINAL BUDGET (it should be the same as above): ';
PRINT @FinalBudget;

COMMIT TRANSACTION;    

SELECT budget
FROM Observatory
WHERE observatory_id = 'S2000001';
