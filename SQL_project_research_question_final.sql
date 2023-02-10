--- Research questions-----

---- Question number 1 ------

CREATE OR REPLACE VIEW v2_salary_average AS (
SELECT
	year_of_measurement,
	industry_name,
	ROUND (AVG (salary),0) AS salary_avg
FROM t_jakub_masak_project_sql_primary_final tjmpspf
WHERE industry_code IS NOT NULL
GROUP BY industry_name, year_of_measurement
);


CREATE OR REPLACE VIEW v2_next_salary_avg AS (
SELECT
	year_of_measurement,
	industry_name,
	salary_avg,
	LEAD (salary_avg,1) OVER (PARTITION BY industry_name ORDER BY industry_name, year_of_measurement) next_salary_avg
FROM v2_salary_average vsa
);


SELECT
	year_of_measurement,
	industry_name,
	salary_avg,
	next_salary_avg,
	next_salary_avg - salary_avg AS difference_salary
FROM v2_next_salary_avg vnsa
WHERE next_salary_avg IS NOT NULL AND (next_salary_avg - salary_avg) < 0
ORDER BY year_of_measurement ASC;



---- Question number 2 ------

CREATE OR REPLACE VIEW v_milk_bread AS (
SELECT
	food_name,
	ROUND (AVG (food_price),2) AS avg_food_price,
	food_price_value,
	food_price_unit,
	year_of_measurement,
	ROUND (AVG (salary),0) AS avg_salary
FROM t_jakub_masak_project_sql_primary_final tjmpspf 
WHERE food_name IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované') AND year_of_measurement IN (2006,2018)
GROUP BY food_name, year_of_measurement
ORDER BY year_of_measurement
);

SELECT
	food_name,
	avg_food_price
	food_price_value,
	food_price_unit,
	year_of_measurement,
	avg_salary,
	ROUND (avg_salary/avg_food_price) AS amount_of_food
FROM v_milk_bread vmb;


---- Question number 3 ------

CREATE OR REPLACE VIEW v_food_price_avg AS (
SELECT
	year_of_measurement,
	food_name,
	ROUND (AVG (food_price),2) AS food_price_avg
FROM t_jakub_masak_project_sql_primary_final tjmpspf 
GROUP BY food_name, year_of_measurement
);


CREATE OR REPLACE VIEW v_next_food_price_avg AS (
SELECT
	year_of_measurement,
	food_name,
	food_price_avg,
	LEAD (food_price_avg,1) OVER (PARTITION BY food_name ORDER BY food_name, year_of_measurement) next_food_price_avg
FROM v_food_price_avg vfpa
);


CREATE OR REPLACE VIEW v_food_price_increase AS (
SELECT 
	year_of_measurement,
	food_name,
	food_price_avg,
	next_food_price_avg,
	ROUND (((next_food_price_avg - food_price_avg)/next_food_price_avg)*100,2) AS food_price_percent_increase
FROM v_next_food_price_avg vnfpa
WHERE year_of_measurement != 2018
GROUP BY year_of_measurement, food_name
ORDER BY food_name, year_of_measurement
);


SELECT
	food_name,
	ROUND (AVG (food_price_percent_increase),2)
FROM v_food_price_increase vfpi
GROUP BY food_name
ORDER BY AVG (food_price_percent_increase);


---- Question number 4 ------

---- Získání tabulky vývoje cen potravin


CREATE OR REPLACE VIEW v_all_food_year_difference AS (
SELECT
	year_of_measurement,
	ROUND (AVG (food_price_percent_increase),2) AS food_price_percent_difference
FROM v_food_price_increase vfpi
GROUP BY year_of_measurement
);


------ Získání tabulky vývoje mezd

CREATE OR REPLACE VIEW v2_next_salary_avg  AS (
SELECT
	year_of_measurement,
	industry_name,
	salary_avg,
	LEAD (salary_avg,1) OVER (PARTITION BY industry_name ORDER BY industry_name, year_of_measurement) next_salary_avg
FROM v2_salary_average vsa
);

CREATE OR REPLACE VIEW v_salary_increase AS (
SELECT
	year_of_measurement,
	industry_name,
	salary_avg,
	next_salary_avg,
	ROUND (((next_salary_avg - salary_avg)/next_salary_avg)*100,2) AS salary_percent_increase
FROM v2_next_salary_avg vnsa 
WHERE year_of_measurement != 2018
GROUP BY year_of_measurement, industry_name
ORDER BY industry_name, year_of_measurement
);



CREATE OR REPLACE VIEW v_all_salary_difference AS (
SELECT
	year_of_measurement,
	ROUND (AVG (salary_percent_increase),2) AS payroll_percent_difference
FROM v_salary_increase vsi
GROUP BY year_of_measurement
);


------ Finální dotaz

SELECT 
	vafyd.year_of_measurement,
	food_price_percent_difference,
	vasd.payroll_percent_difference,
	(food_price_percent_difference - vasd.payroll_percent_difference) AS food_price_minus_salary
FROM v_all_food_year_difference vafyd
JOIN v_all_salary_difference vasd 
ON vafyd.year_of_measurement = vasd.year_of_measurement;


---- Question number 5 ------

CREATE OR REPLACE VIEW v_czech_republic_GDP_next_year AS (
SELECT
	country,
	YEAR,
	GDP,
	LEAD (GDP,1) OVER (PARTITION BY country ORDER BY country, year) next_year_GDP
FROM t_jakub_masak_project_sql_secondary_final tjmpssf
WHERE country = 'Czech republic' AND YEAR BETWEEN 2006 AND 2018
ORDER BY YEAR
);


CREATE OR REPLACE VIEW v_czech_republic_gdp_difference AS (
SELECT
	country,
	YEAR,
	GDP,
	next_year_gdp,
	ROUND (((next_year_gdp - GDP)/next_year_gdp)*100,2) AS gdp_difference
FROM v_czech_republic_gdp_next_year vcrgny
);


SELECT
	vcrgd.YEAR,
	vcrgd.gdp_difference,
	vafyd.food_price_percent_difference,
	vasd.payroll_percent_difference
FROM v_czech_republic_gdp_difference vcrgd
JOIN v_all_food_year_difference vafyd
	ON vcrgd.`YEAR` = vafyd.year_of_measurement
JOIN v_all_salary_diffrence vasd
	ON vcrgd.`YEAR` = vasd.year_of_measurement
;


