ALTER TABLE Observatory   --add a budget to an observatory (how much money does it have)
    ADD budget DECIMAL(15, 2);
ALTER TABLE Monitor_schedule --add a yearly cost for monitoring a planet 
    ADD cost DECIMAL(15, 2);


UPDATE Observatory SET budget = 15000000.00 WHERE observatory_id = 'G1000001'; 
UPDATE Observatory SET budget = 12500000.00 WHERE observatory_id = 'G1000002'; 
UPDATE Observatory SET budget = 9000000.00  WHERE observatory_id = 'G1000003'; 
UPDATE Observatory SET budget = 2000000.00  WHERE observatory_id = 'G1000004'; 
UPDATE Observatory SET budget = 5500000.00  WHERE observatory_id = 'G1000005'; 
UPDATE Observatory SET budget = 8000000.00  WHERE observatory_id = 'G1000006'; 
UPDATE Observatory SET budget = 3000000.00  WHERE observatory_id = 'G1000007'; 
UPDATE Observatory SET budget = 4200000.00  WHERE observatory_id = 'G1000008'; 
UPDATE Observatory SET budget = 11000000.00 WHERE observatory_id = 'G1000009'; 
UPDATE Observatory SET budget = 6700000.00  WHERE observatory_id = 'G1000010'; 

UPDATE Observatory SET budget = 90000000.00 WHERE observatory_id = 'S2000001';
UPDATE Observatory SET budget = 800000000.00 WHERE observatory_id = 'S2000002'; 
UPDATE Observatory SET budget = 65000000.00 WHERE observatory_id = 'S2000003'; 
UPDATE Observatory SET budget = 72000000.00 WHERE observatory_id = 'S2000004'; 
UPDATE Observatory SET budget = 55000000.00 WHERE observatory_id = 'S2000005'; 
UPDATE Observatory SET budget = 45000000.00 WHERE observatory_id = 'S2000006'; 
UPDATE Observatory SET budget = 10000000.00 WHERE observatory_id = 'S2000007'; 
UPDATE Observatory SET budget = 10000000.00 WHERE observatory_id = 'S2000008'; 
UPDATE Observatory SET budget = 85000000.00 WHERE observatory_id = 'S2000009'; 
UPDATE Observatory SET budget = 50000000.00 WHERE observatory_id = 'S2000010'; 

UPDATE Monitor_Schedule SET cost = 5000.00  WHERE monitor_id = 10000000001;
UPDATE Monitor_Schedule SET cost = 12000.00 WHERE monitor_id = 10000000002;
UPDATE Monitor_Schedule SET cost = 4500.00  WHERE monitor_id = 10000000003;
UPDATE Monitor_Schedule SET cost = 8000.00  WHERE monitor_id = 10000000004;
UPDATE Monitor_Schedule SET cost = 15000.00 WHERE monitor_id = 10000000005;
UPDATE Monitor_Schedule SET cost = 3000.00  WHERE monitor_id = 10000000006;
UPDATE Monitor_Schedule SET cost = 2500.00  WHERE monitor_id = 10000000007;
UPDATE Monitor_Schedule SET cost = 11000.00 WHERE monitor_id = 10000000008;
UPDATE Monitor_Schedule SET cost = 9500.00  WHERE monitor_id = 10000000009;
UPDATE Monitor_Schedule SET cost = 13500.00 WHERE monitor_id = 10000000010;
UPDATE Monitor_Schedule SET cost = 2000.00  WHERE monitor_id = 10000000011;
UPDATE Monitor_Schedule SET cost = 2200.00  WHERE monitor_id = 10000000012;
UPDATE Monitor_Schedule SET cost = 7500.00  WHERE monitor_id = 10000000013;
UPDATE Monitor_Schedule SET cost = 6000.00  WHERE monitor_id = 10000000014;
UPDATE Monitor_Schedule SET cost = 8500.00  WHERE monitor_id = 10000000015;