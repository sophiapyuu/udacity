-- Deforestation

--Building A View CREATE
CREATE TABLE "flr" (
  SELECT *
  FROM forest_area

);



--1 Global Situation
a. 1990	41282694.9
SELECT forest_area_sqkm
FROM forest_area
WHERE country_name = 'World' AND year = 1990


b. 39958245.9 2016
SELECT SUM(forest_area_sqkm), year
FROM forest_area
WHERE year = 2016
GROUP BY year

c. percent change
WITH difference as (SELECT
  (SELECT forest_area_sqkm
  FROM forest_area
  WHERE year = 1990 AND country_name = 'World'
  ) as forest_1990,
  forest_area_sqkm as forest_2016, year
  FROM forest_area
  WHERE year = 2016 AND country_name = 'World'
)
SELECT forest_1990- forest_2016 as loss,
((forest_1990- forest_2016)/forest_1990) * 100 as percentChange
FROM difference


d. 1324449

WITH difference as (SELECT
  (SELECT forest_area_sqkm
  FROM forest_area
  WHERE year = 1990 AND country_name = 'World'
  ) as forest_1990,
  forest_area_sqkm as forest_2016, year
  FROM forest_area
  WHERE year = 2016 AND country_name = 'World'
)
SELECT forest_1990- forest_2016 as loss
FROM difference

e. Perfu

--part 1. take part d result and convert sq_km to sq_mi
WITH difference as (SELECT
(SELECT forest_area_sqkm
FROM forest_area
WHERE year = 1990 AND country_name = 'World'
) as forest_1990,
forest_area_sqkm as forest_2016, year
FROM forest_area
WHERE year = 2016 AND country_name = 'World'
)
SELECT country_name, ABS(total_area_sq_mi - (SELECT (forest_1990- forest_2016)/2.59 FROM difference))
FROM land_area
WHERE year=2016
ORDER BY 2 ASC

--2 Regional Outlook
--TABLE

--Create a table that shows the Regions and
--their percent forest area (sum of forest area divided by sum of land area) in 1990 and 2016.
-- (Note that 1 sq mi = 2.59 sq km).Based on the table you created, ....
--task 1 get sum of forest area divided by sum of land area
 SELECT *
 FROM forest_area f
 JOIN land_area l
 ON f.country_code = l.country_code
 AND ( (f.year = 1990  AND l.year = 1990) OR (f.year = 2016 AND l.year =2016) )

--total forest area
SELECT SUM(forest_area_sqkm) as total_forest_area
FROM forest_area
WHERE year = 2016 AND forest_area_sqkm >0

SELECT
forest_area_sqkm/ (SELECT SUM(forest_area_sqkm) as total_forest_area
FROM forest_area
WHERE year = 2016 AND forest_area_sqkm >0 ) *100 as percent_forest, f.country_name, year, r.region
FROM forest_area f
JOIN regions r
ON f.country_name = r.country_name
WHERE year = 2016


--join subtable with regions table
--highest relative Deforestation
--
--highest relative Deforestation for 2016 - is to join forest area to region group
-- sum forestation total
--then divide
SELECT SUM(sub.forest_percent)/COUNT(*), r.region, sub.year
FROM ( SELECT l.country_code, l.country_name, l.year, f.forest_area_sqkm/2.59 / l.total_area_sq_mi * 100 as forest_percent
 FROM forest_area f
 JOIN land_area l
 ON f.country_code = l.country_code
 AND ( (f.year = 1990  AND l.year = 1990) OR (f.year = 2016 AND l.year =2016) ) )as sub
JOIN regions r
ON sub.country_name = r.country_name
GROUP BY 2, 3
HAVING sub.year = 2016 AND sub.forest_percent >0
ORDER BY 1

SELECT SUM(
forest_area_sqkm/ (SELECT SUM(forest_area_sqkm) as total_forest_area
FROM forest_area
WHERE year = 2016 AND forest_area_sqkm >0 ) *100 ) as percent_forest,  r.region
FROM forest_area f
JOIN regions r
ON f.country_name = r.country_name
WHERE year = 2016
GROUP BY 2
ORDER BY 1

--2.1 Table percent forest area by region 1990
SELECT SUM(sub2.forest_percent)/COUNT(*), sub2.region, sub2.year
FROM
(SELECT *
FROM ( SELECT l.country_code, l.country_name, l.year, f.forest_area_sqkm/2.59 / l.total_area_sq_mi * 100 as forest_percent
 FROM forest_area f
 JOIN land_area l
 ON f.country_code = l.country_code
 AND ( (f.year = 1990  AND l.year = 1990) OR (f.year = 2016 AND l.year =2016) ) )as sub
JOIN regions r
ON sub.country_name = r.country_name
WHERE forest_percent > 0
 ) sub2
GROUP BY 2,3
HAVING sub2.year = 1990
ORDER BY 1


---3 COUNTRY LVL

--LARGEST AMOUNT DECREASE

---LARGEST PERCENT DECREASE
SELECT *
FROM ( SELECT l.country_code, l.country_name, l.year, f.forest_area_sqkm/2.59 / l.total_area_sq_mi * 100 as forest_percent
FROM forest_area f
JOIN land_area l
ON f.country_code = l.country_code
AND ( (f.year = 1990  AND l.year = 1990) OR (f.year = 2016 AND l.year =2016) )) as sub
