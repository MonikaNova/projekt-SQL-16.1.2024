CREATE TABLE t_Monika_Nova_project_SQL_primary_final AS 
SELECT
		cpc.name AS food_category, cp.value AS food_price, 
		cpc.price_value AS value, cpc.price_unit AS unit,
		cp.date_from AS year_price,
		cpib.name AS industry, cpay.value AS average_payroll, 
		payroll_year AS year_payroll
FROM (SELECT 
			category_code, 
			YEAR(cp.date_from) AS date_from,
			ROUND(AVG(value),0) AS value  
			FROM czechia_price cp
			WHERE region_code is NULL 
			GROUP BY category_code, YEAR(cp.date_from) ) AS cp
JOIN (SELECT 
			industry_branch_code,
			payroll_year,
			ROUND(AVG(value),0)AS value
			FROM czechia_payroll cpay
			WHERE cpay.value_type_code = 5958 AND cpay.calculation_code = 100 AND industry_branch_code is not NULL AND payroll_year < 2021
			GROUP BY industry_branch_code,  payroll_year) AS cpay
		ON cp.date_from = cpay.payroll_year
JOIN czechia_price_category cpc
		ON cp.category_code = cpc.code
JOIN czechia_payroll_industry_branch cpib
		ON cpay.industry_branch_code = cpib.code
;