SELECT 
	industry,
	rust_pokles,
	COUNT(*) AS cetnost_zmen
FROM 
(SELECT DISTINCT  
	tmn.industry,
	tmn.year_payroll,
	tmn.average_payroll,
	tmn2.year_payroll AS year_payroll2,
	tmn2.average_payroll AS average_payroll2,
	tmn.average_payroll - tmn2.average_payroll AS mezirocni_rozdil,
	CASE 
		WHEN tmn.average_payroll - tmn2.average_payroll >= 0 THEN "rust"
		ELSE "pokles"
	END AS rust_pokles
FROM t_Monika_Nova_project_SQL_primary_final tmn 
LEFT JOIN t_Monika_Nova_project_SQL_primary_final tmn2 
	ON tmn.year_payroll = tmn2.year_payroll +1
	AND tmn.industry = tmn2.industry 
WHERE tmn2.year_payroll IS NOT NULL 
ORDER BY year_payroll, industry) AS payroll_tab
GROUP BY industry, rust_pokles
ORDER BY COUNT(*) DESC, industry
;