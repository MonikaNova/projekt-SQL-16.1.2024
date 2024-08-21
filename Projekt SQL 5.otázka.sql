SELECT *,
	ROUND((average_payroll1 * 100) /average_payroll,0) - 100 AS difference_pay1,
	ROUND((average_price1 * 100) /average_price,0) - 100 AS difference_pri1,
	ROUND((average_payroll2 * 100) /average_payroll1,0) - 100 AS difference_pay2,
	ROUND((average_price2 * 100) /average_price1,0) - 100 AS difference_pri2,
	ROUND((HDP_mil_dollars1 * 100) /HDP_mil_dollars,0) - 100 AS difference_HDP1
FROM
(SELECT 
	price_payroll_HDP1.year_price,
	price_payroll_HDP1.average_price,
	price_payroll_HDP1.average_payroll,
	price_payroll_HDP1.HDP_mil_dollars,
	price_payroll_HDP2.year_price AS year_price1,
	price_payroll_HDP2.average_price AS average_price1,
	price_payroll_HDP2.average_payroll AS average_payroll1,
	price_payroll_HDP2.HDP_mil_dollars AS HDP_mil_dollars1,
	price_payroll_HDP3.year_price AS year_price2,
	price_payroll_HDP3.average_price AS average_price2,
	price_payroll_HDP3.average_payroll AS average_payroll2,
	price_payroll_HDP3.HDP_mil_dollars AS HDP_mil_dollars2
FROM 
	(SELECT 
		country,
		ROUND(AVG(food_price),0) AS average_price,
		year_price,
		ROUND(AVG(average_payroll),0) AS average_payroll,
		year_payroll,
		HDP_mil_dollars,
		year_HDP
	FROM 
	(SELECT 
		*
	FROM t_Monika_Nova_project_SQL_primary_final tmn11
	LEFT JOIN t_Monika_Nova_project_SQL_secondary_final tmn22
		ON tmn11.year_price = tmn22.year_HDP
	WHERE tmn22.country = 'Czech Republic') AS price_payroll_HDP 
	GROUP BY year_price, year_payroll, year_HDP) AS price_payroll_HDP1
LEFT JOIN 
	(SELECT 
		country,
		ROUND(AVG(food_price),0) AS average_price,
		year_price,
		ROUND(AVG(average_payroll),0) AS average_payroll,
		year_payroll,
		HDP_mil_dollars,
		year_HDP
	FROM 
	(SELECT 
		*
	FROM t_Monika_Nova_project_SQL_primary_final tmn11
	LEFT JOIN t_Monika_Nova_project_SQL_secondary_final tmn22
		ON tmn11.year_price = tmn22.year_HDP
	WHERE tmn22.country = 'Czech Republic') AS price_payroll_HDP 
	GROUP BY year_price, year_payroll, year_HDP) AS price_payroll_HDP2
ON price_payroll_HDP1.year_price = price_payroll_HDP2.year_price - 1 
LEFT JOIN 
	(SELECT 
		country,
		ROUND(AVG(food_price),0) AS average_price,
		year_price,
		ROUND(AVG(average_payroll),0) AS average_payroll,
		year_payroll,
		HDP_mil_dollars,
		year_HDP
	FROM 
	(SELECT 
		*
	FROM t_Monika_Nova_project_SQL_primary_final tmn11
	LEFT JOIN t_Monika_Nova_project_SQL_secondary_final tmn22
		ON tmn11.year_price = tmn22.year_HDP) AS price_payroll_HDP 
	GROUP BY year_price, year_payroll, year_HDP) AS price_payroll_HDP3
ON price_payroll_HDP1.year_price = price_payroll_HDP3.year_price - 2) AS price_payroll_HDP;

	