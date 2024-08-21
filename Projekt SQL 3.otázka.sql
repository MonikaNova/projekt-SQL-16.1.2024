SELECT
	tab_price.food_category,
	MIN(procentni_zmena) AS mezirocni_zmena_cen
FROM 
(SELECT DISTINCT 
	tmn.food_category ,
	tmn.food_price ,
	tmn.year_price AS year_price,
	tmn2.food_category AS food_category2 ,
	tmn2.food_price AS food_price2 , 
	tmn2.year_price AS year_price2 ,
	ROUND(tmn.food_price / tmn2.food_price ,2) AS year_on_year_change,
	ROUND((tmn.food_price - tmn2.food_price) / tmn2.food_price * 100, 2) AS procentni_zmena
FROM t_Monika_Nova_project_SQL_primary_final tmn 
LEFT JOIN t_Monika_Nova_project_SQL_primary_final tmn2 
	ON tmn.food_category = tmn2.food_category  
	AND tmn.year_price = tmn2.year_price + 12
WHERE tmn2.food_category is not NULL
ORDER BY food_category, year_price) AS tab_price
GROUP BY tab_price.food_category
ORDER BY MIN(procentni_zmena)
;