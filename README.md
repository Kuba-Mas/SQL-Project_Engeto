# SQL-Project_Engeto
SQL projekt v rámci Datové akademie (Na Discordu jsem "Jakub M.")

Pro přípravu „primary“ tabulky jsem využil tabulky czechia_payroll, czechia_payroll_industry_branch, czechia_price a czechia_price category.
Druhou tabulku jsem vytvořil spojením tabulek countries a economies.

Ve výzkumných otázkách jsem zkoumal období let 2006-2018, jelikož u cen potravin máme k dispozici data za uvedené roky. U let před rokem 2006 a po roce 2018 máme sice data o mzdách, ale tato data nelze s cenami potravin jakkoliv porovnávat. U výzkumných otázek týkající se meziročního nárůstu cen potravin pracuji s obdobím do roku 2017, jelikož pro rok 2018 nejsou známy data roku následujícího a není ted možnost výpočtu meziročního nárůstu/poklesu.

Výzkumné otázky a odpovědi na ně:

1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

  Mzdy ve všech odvětvích po celé sledované období nerostou. Dle výsledků je celkem 23 případů napříč odvětvími a roky, kdy průměrná roční mzda je nižší než v          předchozím roce.
  Pokles průměrné roční mzdy se netýkal pouze čtyř odvětví. Těmi jsou: Zpracovatelský průmysl, Doprava a skladování, Zdravotní a sociální péče, Ostatní činnosti. 

2. Kolik je možní si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

  V roce 2006 bylo možné koupit 1287 kilogramů chleba a 1437 litrů mléka. V roce 2018 bylo možné koupit 1342 kilogramů chleba a 1642 litrů mléka.

3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuálně meziroční nárůst)?

  Nejnižší průměrný meziroční nárůst cen je u rajských jablek a to -3,81 %. Lze tedy říct, že cena rajských jablek ve sledovaném období celkově klesá.

4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10%)?

  Takových roků je několik (2010, 2011, 2012). Např. v roce 2010 byl meziroční růst cen potravin 3,17%, zatímco růst mezd byl 2,16%, což znamená, že meziroční růst cen   potravin byl v tomto roce o 31,86% vyšší než růst mezd.

5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

  Meziroční změny výše HDP nemají na výši cen potravin a mezd souvislost, která by se dala nazvat pravidlem. Ve výsledcích můžeme totiž zjistit, že při růstu HDP došlo   ve sledovaných letech jak růstu, tak i k poklesu cen potravin. Dále pak mzdy rostou jak při růstu, tak i poklesu HDP.


