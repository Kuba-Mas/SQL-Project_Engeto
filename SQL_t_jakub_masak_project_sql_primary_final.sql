CREATE OR REPLACE TABLE t_jakub_masak_project_sql_primary_final
SELECT
	cp.category_code AS food_code,
	cpc.name AS food_name,
	cp.value AS food_price,
	cpc.price_value AS food_price_value,
	cpc.price_unit AS food_price_unit,
	YEAR (cp.date_from) AS year_of_measurement,
	cp2.industry_branch_code AS industry_code,
	cpib.name AS industry_name,
	cp2.value AS salary
FROM czechia_price AS cp
JOIN czechia_payroll AS cp2
	ON YEAR (cp.date_from) = cp2.payroll_year
JOIN czechia_price_category AS cpc
	ON cpc.code = cp.category_code
JOIN czechia_payroll_industry_branch AS cpib
	ON cpib.code = cp2.industry_branch_code
WHERE cp2.value_type_code = 5958 AND YEAR (cp.date_from) BETWEEN 2006 AND 2018;








