SELECT 
	food_category , 
	value ,
	unit ,
	food_price , 
	year_price ,
	average_payroll_industry ,
	year_payroll ,
	ROUND(average_payroll_industry / food_price,0) AS koupene_mnozstvi 
FROM 
(SELECT DISTINCT  
	food_category , 
	value,
	unit, 
	food_price , 
	year_price ,
	ROUND(AVG(average_payroll),0) AS average_payroll_industry ,
	year_payroll ,
	MIN(year_payroll) OVER () AS min_year_payroll ,
	MAX(year_payroll) OVER () AS max_year_payroll
FROM t_Monika_Nova_project_SQL_primary_final tmn 
WHERE LOWER(food_category) LIKE '%mléko%' OR LOWER(food_category) LIKE '%chléb%'
GROUP BY food_category, year_price) AS chleb_mleko 
WHERE min_year_payroll = year_payroll OR max_year_payroll = year_payroll
;