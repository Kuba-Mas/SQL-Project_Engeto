CREATE OR REPLACE TABLE t_jakub_masak_project_sql_secondary_final
SELECT
	e.YEAR,
	e.country,
	e.GDP,
	e.gini,
	e.population
FROM economies e
JOIN countries c
ON e.country = c.country
WHERE c.continent = 'Europe' AND YEAR BETWEEN 2006 AND 2018;