SELECT 
	BOSS.observer_name AS Boss_name, 
	BOSS.observer_surname AS Boss_surname, 
	'is the boss of' AS 'Text',
	EMPLOYEE.observer_name AS Employee_name, 
	EMPLOYEE.observer_surname AS Employee_surname, 
	'in observatory' AS 'Text', Observatory_name
FROM Observer AS EMPLOYEE 
	INNER JOIN Work
		ON EMPLOYEE.observer_id = Work.observer_id
	INNER JOIN Observatory
		ON Work.observatory_id = Observatory.observatory_id 
	INNER JOIN Observer AS BOSS --self join here, however this self join is from a relationship Observer -> is boss in -> Observatory
		ON Observatory.boss_id = BOSS.observer_id
	WHERE
		Work.date_of_end IS NULL
		AND BOSS.observer_id != EMPLOYEE.observer_id --excludes someone to be their own boss
ORDER BY BOSS.observer_id

-- Who is the boss of who and in which observatories