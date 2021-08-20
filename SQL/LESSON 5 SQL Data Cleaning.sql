--SQL DATA CLEANING

--Concepts 7
--1



--Concepts 7
--1
SELECT DISTINCT RIGHT(website, 3)
FROM accounts

--2
SELECT DISTINCT LEFT(name, 1), COUNT(*)
FROM accounts
GROUP BY 1
ORDER BY 2 DESC

--3 WRONG
SELECT SUM(num) as number, SUM(letter) as letter
FROM
(SELECT name,
	CASE WHEN LEFT(UPPER(name),1) IN ('0', '1', '2', '3', '4', '5', '6', '7','8', '9') THEN 1 ELSE 0 END as num,
	CASE WHEN LEFT(UPPER(name), 1) IN ('0', '1', '2', '3', '4', '5', '6', '7','8', '9') THEN 0 ELSE 1 END AS letter
FROM accounts
) t1
--4

SELECT SUM(isVowel) as isVowel, sum(isNotVowel) as other
FROM
(SELECT name,
	CASE WHEN LEFT(UPPER(name),1) IN ('A', 'E', 'I', 'O', 'U') THEN 1 ELSE 0 END AS isVowel,
	CASE WHEN LEFT(UPPER(name),1) NOT IN ('A', 'E', 'I', 'O', 'U') THEN 1 ELSE 0 END AS isNotVowel
FROM accounts
) t1

--Concepts 11
--1
SELECT CONCAT(s.id, '_', r.name) as EMP_ID_REGION, s.name
FROM sales_reps s
JOIN region r
ON r.id = s.region_id

--2
SELECT CONCAT(a.name, '(', a.lat, a.long, ')') as huh,
 				CONCAT(LEFT(primary_poc, 1), RIGHT(primary_poc, 1), '@', a.website) as emailID
FROM accounts a

--3
SELECT CONCAT(account_id, '_', channel, '_', COUNT (*))
FROM web_events
GROUP BY account_id, channel
ORDER BY account_id

--Concepts 13
--1
SELECT *
FROM sf_crime_data
LIMIT 10

--4
SELECT date, CAST(date as DATE) as date2
FROM sf_crime_data
LIMIT 10

--Concepts 17
--1
SELECT primary_poc, POSITION(' ' IN primary_poc) as index,
			LEFT(primary_poc, POSITION(' ' IN primary_poc) ) as firstName,
			SUBSTR(primary_poc, POSITION(' ' IN primary_poc)) AS lastName
FROM accounts
--2
SELECT name,
LEFT(name, POSITION(' ' IN name) ) as firstName,
SUBSTR(name, POSITION(' ' IN name)) AS lastName
FROM sales_reps

 --OR
 SELECT name, LEFT(name, STRPOS(name, ' ') )
as firstNAME,
RIGHT (name, LENGTH(name) -  STRPOS(name, ' ')) as lastname
FROM sales_reps

--Concepts 19
--1
SELECT CONCAT( RTRIM(LEFT(primary_poc, POSITION(' ' IN primary_poc))), '.',
TRIM(SUBSTR(primary_poc, POSITION(' ' IN primary_poc))),'@', TRIM(name), '.com')
FROM accounts

--Query to answer quiz questions
SELECT *
FROM
(SELECT CONCAT( RTRIM(LEFT(primary_poc, POSITION(' ' IN primary_poc))), '.',
TRIM(SUBSTR(primary_poc, POSITION(' ' IN primary_poc))),'@', TRIM(name), '.com') as email
FROM accounts
) t1
WHERE t1.email = 'Terrilyn.Kesler@Costco.com' OR
     t1.email = 'Melva.Lyall@Boeing.com' OR
     t1.email = 'Parker.Hoggan@GE.com' OR
     t1.email = 'Denis.Gros@Microsoft.com'

--Query to answer quiz 2
SELECT *
FROM
		 (SELECT CONCAT( RTRIM(LEFT(primary_poc, POSITION(' ' IN primary_poc))), '.',
		 TRIM(SUBSTR(primary_poc, POSITION(' ' IN primary_poc))),'@',REPLACE(name, ' ', ''), '.com') as email
		 FROM accounts
		 ) t1
		 WHERE t1.email = 'Savanna.Gayman@UnitedHealthGroup.com' OR
		      t1.email = 'Serafina.Banda@BerkshireHathaway.com' OR
		      t1.email = 'Sung.Shields@ExxonMobil.com' OR
		      t1.email = 'Florentino.Madrigal@J.P.MorganChase.com'

--query TO ANSWER QUIZ 3
WITH password as
(
SELECT primary_poc, CONCAT (
  LOWER(LEFT(primary_poc, 1)),
  SUBSTR(primary_poc, POSITION(' ' IN primary_poc)-1, 1),
  LOWER(SUBSTR(primary_poc, POSITION(' ' IN primary_poc)+1, 1)),
  RIGHT(TRIM(primary_poc),1),
POSITION(' ' IN primary_poc)-1,
   LENGTH(primary_poc)-1-(POSITION(' ' IN primary_poc)-1),
 UPPER(REPLACE(name, ' ', ''))
)
FROM accounts
       )
SELECT *
FROM password
WHERE concat = 'pebs56CHEVRON' OR
      concat = 'eaet410WALGREENSBOOTSALLIANCE' OR
      concat = 'foml108J.P.MORGANCHASE'

--2 REPLACE spaces in string to no spaces aka eliminate spaces
SELECT CONCAT(RTRIM(LEFT(primary_poc, POSITION(' ' IN primary_poc))), '.',
TRIM(SUBSTR(primary_poc, POSITION(' ' IN primary_poc))),'@', REPLACE(name, ' ', ''), '.com') as email
FROM accounts

--3
SELECT primary_poc, CONCAT (
  LOWER(LEFT(primary_poc, 1)),
  SUBSTR(primary_poc, POSITION(' ' IN primary_poc)-1, 1),
  LOWER(SUBSTR(primary_poc, POSITION(' ' IN primary_poc)+1, 1)),
  RIGHT(TRIM(primary_poc),1),
POSITION(' ' IN primary_poc)-1,
   LENGTH(primary_poc)-1-(POSITION(' ' IN primary_poc)-1),
 UPPER(REPLACE(name, ' ', ''))
) as password
FROM accounts

--Concepts 22 WRONG!!
--2
SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

--3
SELECT COALESCE(a.id, a.id) filled_id, COALESCE(o.account_id, a.id) as account_id ,a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

--4
SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, COALESCE(o.account_id, a.id) as account_id ,
o.occurred_at,
COALESCE(o.standard_qty, 0) as standard_qty,
COALESCE(o.gloss_qty, 0) as gloss_qty,
COALESCE(o.poster_qty, 0) as poster_qty,
COALESCE(o.total,0) total,
COALESCE(o.standard_amt_usd,0) standard_amt_usd,
COALESCE(o.gloss_amt_usd,0) gloss_amt_usd,
COALESCE(o.poster_amt_usd,0) poster_amt_usd,
COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

--6
WITH coalexample as (
SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, COALESCE(o.account_id, a.id) account_id, o.occurred_at, COALESCE(o.standard_qty, 0) standard_qty, COALESCE(o.gloss_qty,0) gloss_qty, COALESCE(o.poster_qty,0) poster_qty, COALESCE(o.total,0) total, COALESCE(o.standard_amt_usd,0) standard_amt_usd, COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, COALESCE(o.poster_amt_usd,0) poster_amt_usd, COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id)
SELECT COUNT(*)
FROM coalexample
