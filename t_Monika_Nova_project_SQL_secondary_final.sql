CREATE TABLE t_Monika_Nova_project_SQL_secondary_final  AS
SELECT
	c.country,
	c.population,
	e.year AS year_HDP,
	ROUND ( e.GDP / 1000000, 2 ) AS HDP_mil_dollars ,
	e.gini 
FROM countries c
LEFT JOIN economies e
	ON e.country = c.country 
WHERE c.continent = 'Europe'
	AND  e.year BETWEEN 2006 and 2018
	AND ROUND ( e.GDP / 1000000, 2 ) is not NULL
ORDER BY e.year ASC
;