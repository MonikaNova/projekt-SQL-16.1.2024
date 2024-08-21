SELECT *,
	CASE 
		WHEN difference_pay > 10 THEN 1
		ELSE 0
	END AS increase_pay,
	CASE 
		WHEN difference_pri > 10 THEN 1
		ELSE 0
	END AS increase_pri
FROM 
	(SELECT *,
		ROUND((average_payroll * 100) /average_payroll2,0) - 100 AS difference_pay,
		ROUND((average_price * 100) /average_price2,0) - 100 AS difference_pri
	FROM 
		(SELECT 
			*
		FROM 
			(SELECT DISTINCT  
				tmn.year_payroll,
				ROUND(AVG(average_payroll),0 ) AS average_payroll,
				ROUND(AVG(food_price),0 ) AS average_price
			FROM t_Monika_Nova_project_SQL_primary_final tmn 
			GROUP BY year_payroll) AS tab_payroll 
		LEFT JOIN 
			(SELECT DISTINCT  
				tmn.year_payroll AS year_payroll2,
				ROUND(AVG(average_payroll),0 ) AS average_payroll2,
				ROUND(AVG(food_price),0 ) AS average_price2
			FROM t_Monika_Nova_project_SQL_primary_final tmn 
			GROUP BY year_payroll) AS tab_payroll2
		ON tab_payroll.year_payroll = tab_payroll2.year_payroll2 +1) AS payroll_price) AS payroll_price 
;