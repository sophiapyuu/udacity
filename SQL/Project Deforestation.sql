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

e. 511370 loss_sq_mi

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
SELECT (forest_1990- forest_2016)/2.59 as loss_sq_mi
FROM difference
--part 2 take results and compare
--PER	Peru	2016	494208.49
SELECT *
FROM land_area
WHERE year = 2016

SELECT
(SELECT *
FROM land_area
WHERE year = 2016 ) AS t1,
