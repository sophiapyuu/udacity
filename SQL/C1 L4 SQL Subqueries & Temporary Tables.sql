--SQL Subqueries & Temporary Tables

--Concepts 12
--1 FIND # OF EVENTS FOR EACH DAY FOR EACH channel
SELECT DATE_TRUNC('day', occurred_at) AS day,
	COUNT(channel) AS events, channel
FROM web_events
GROUP BY day, channel
ORDER BY 1, 2

--QUIZ answer 2017 01 01 direct, 2016, 12, 21
SELECT DATE_TRUNC('day', occurred_at) AS day,
	COUNT(channel) AS events
FROM web_events
GROUP BY day
ORDER BY 2 DESC

--2
SELECT*
FROM
  (SELECT DATE_TRUNC('day', occurred_at) AS day,
  	COUNT(channel) AS events, channel
  FROM web_events
  GROUP BY day, channel
  ORDER BY 2 DESC ) sub

--3
SELECT channel, AVG(events)
FROM
  (SELECT DATE_TRUNC('day', occurred_at) AS day,
  	COUNT(channel) AS events, channel
  FROM web_events
  GROUP BY day, channel
  ORDER BY 2 DESC ) sub
GROUP BY channel

--Concepts 17
--1
SELECT DATE_TRUNC('month', MIN(occurred_at)) AS first_month
FROM orders

--2 Nest subquery result
SELECT AVG(standard_qty) as AVGstandard_qty,
       AVG(gloss_qty) as AVGgloss_qty, AVG(poster_qty) as AVGposter_qty,
       SUM(total_amt_usd) as total_spent
FROM orders
WHERE DATE_TRUNC('month', occurred_at) =
    (SELECT DATE_TRUNC('month', MIN(occurred_at)) AS first_month
    FROM orders)


--Concepts 18
--1 find # each channel by each account
SELECT COUNT(*) as frequency, w.channel, a.name  --COUNT(*)
FROM web_events AS w
JOIN accounts AS a
ON w.account_id = a.id
GROUP BY a.name, w.channel
ORDER BY a.name,  1 DESC


--2 RETURN THE MOST/MAX USED ACCOUNT inline?
SELECT MAX(frequency), t1.name
    FROM (SELECT COUNT(*) as frequency, channel as channel, a.name as name--COUNT(*)
      FROM web_events AS w
      JOIN accounts AS a
      ON w.account_id = a.id
      GROUP BY a.name, w.channel
    ) AS t1
GROUP BY t1.name


--3 PART 3 create a new table that eliminates non max frequency
-- take all results then match it to MAX result and return resulting table


SELECT *
FROM
        (SELECT MAX(frequency) AS MAX, t1.name
        FROM (SELECT COUNT(*) as frequency, channel as channel, a.name as name--COUNT(*)
          FROM web_events AS w
          JOIN accounts AS a
          ON w.account_id = a.id
          GROUP BY a.name, w.channel
          ORDER BY a.name,  1 DESC
        ) AS t1
        GROUP BY t1.name)  AS t3
  JOIN (
    SELECT COUNT(*) as MAX, channel, a.name  AS name--COUNT(*)
    FROM web_events AS w
    JOIN accounts AS a
    ON w.account_id = a.id
    GROUP BY a.name, channel
    ORDER BY a.name,  1 DESC
  ) AS original
ON original.name = t3.name AND t3.MAX = original.MAX


--3 more efficient way to join
SELECT t3.name, t3.channel, t3.frequency
FROM (SELECT COUNT(*) as frequency, channel as channel, a.name as name--COUNT(*)
      FROM web_events AS w
      JOIN accounts AS a
      ON w.account_id = a.id
      GROUP BY a.name, w.channel
    ) AS t3
JOIN (SELECT MAX(frequency), t1.name
    FROM (SELECT COUNT(*) as frequency, channel as channel, a.name as name--COUNT(*)
      FROM web_events AS w
      JOIN accounts AS a
      ON w.account_id = a.id
      GROUP BY a.name, w.channel
        ) AS t1
    GROUP BY t1.name
  ) as t2
ON t2.name = t3.name AND t2.max = t3.frequency


--Concepts 20
--1 provide name of sales_rep in EACH region filtered by LARGEST total_amt_usd
SELECT s.name as salesRep, r.name, SUM(total_amt_usd)
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY s.name, r.name

--now use previous table to join for max for each region
SELECT t1.region,  MAX(t1.sales)
FROM
    (SELECT s.name as salesRep, r.name as region, SUM(total_amt_usd) as sales
    FROM orders o
    JOIN accounts a
    ON o.account_id = a.id
    JOIN sales_reps s
    ON s.id = a.sales_rep_id
    JOIN region r
    ON r.id = s.region_id
    GROUP BY s.name, r.name) t1
GROUP BY t1.region

--now JOIN both tables to get new table that displaces sales rep name and max sales for each region_id
-- match t2 with t1
SELECT t3.salesrep, t3.region, t3.sales
    FROM (SELECT s.name as salesRep, r.name as region, SUM(total_amt_usd) sales
    FROM orders o
    JOIN accounts a
    ON o.account_id = a.id
    JOIN sales_reps s
    ON s.id = a.sales_rep_id
    JOIN region r
    ON r.id = s.region_id
    GROUP BY s.name, r.name) t3
JOIN (SELECT t1.region region,  MAX(t1.sales) sales
      FROM
          (SELECT s.name as salesRep, r.name as region, SUM(total_amt_usd) as sales
          FROM orders o
          JOIN accounts a
          ON o.account_id = a.id
          JOIN sales_reps s
          ON s.id = a.sales_rep_id
          JOIN region r
          ON r.id = s.region_id
          GROUP BY s.name, r.name) t1
      GROUP BY t1.region) t2
ON t2.region = t3.region AND t2.sales = t3.sales

--2
-- Table for region with largest (sum) of sales
-- Northeast 7744405.36
SELECT t1.region, MAX(t1.sales)
FROM
    (SELECT r.name as region, SUM(total_amt_usd) as sales
    FROM orders o
    JOIN accounts a
    ON o.account_id = a.id
    JOIN sales_reps s
    ON s.id = a.sales_rep_id
    JOIN region r
    ON r.id = s.region_id
    GROUP BY r.name) t1
WHERE t1.sales = 7744405.36
GROUP BY t1.region

--COUNT # OF ORDERS FROM Northeast
--Northeast	2357
SELECT r.name as region, COUNT (*) ordersPlaced
    FROM orders o
    JOIN accounts a
    ON o.account_id = a.id
    JOIN sales_reps s
    ON s.id = a.sales_rep_id
    JOIN region r
    ON r.id = s.region_id
    GROUP BY r.name

--ANSWER TO 2
SELECT t3.region,  t3.ordersPlaced
FROM(
  SELECT r.name as region, COUNT (*) ordersPlaced
      FROM orders o
      JOIN accounts a
      ON o.account_id = a.id
      JOIN sales_reps s
      ON s.id = a.sales_rep_id
      JOIN region r
      ON r.id = s.region_id
      GROUP BY r.name
)t3
JOIN (
  SELECT t1.region, MAX(t1.sales)
  FROM
      (SELECT r.name as region, SUM(total_amt_usd) as sales
      FROM orders o
      JOIN accounts a
      ON o.account_id = a.id
      JOIN sales_reps s
      ON s.id = a.sales_rep_id
      JOIN region r
      ON r.id = s.region_id
      GROUP BY r.name) t1
  WHERE t1.sales = 7744405.36
  GROUP BY t1.region
) t2
ON t2.region = t3.region


--#3
-- Query to figure out account Name associated with MAX standard_qty
SELECT a.name as accountName, SUM(o.standard_qty) as totalStanQty
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1
ORDER BY totalStanQty DESC
LIMIT 1

--SAME AS ABOVE BUT WITH SUBQUERY
SELECT MAX(totalStanQty)
FROM (
  SELECT a.name as accountName, SUM(o.standard_qty) as totalStanQty, SUM(o.total) totalQty
  FROM orders o
  JOIN accounts a
  ON o.account_id = a.id
  GROUP BY 1
) t1

--all accounts with SUM total purchases evaluated against account with MAX
SELECT COUNT(*)
FROM(
  SELECT a.name as accountName, SUM(o.standard_qty) as totalStanQty, SUM(o.total) totalQty
  FROM orders o
  JOIN accounts a
  ON o.account_id = a.id
  GROUP BY 1
  HAVING SUM(o.total) >
  (
    SELECT totalQty
    FROM (
      SELECT a.name as accountName, SUM(o.standard_qty) as totalStanQty, SUM(o.total) totalQty
      FROM orders o
      JOIN accounts a
      ON o.account_id = a.id
      GROUP BY 1
      ORDER BY 2 DESC
      LIMIT 1
    ) t1 )
  ) counter

--#4 WRONG REDO
--Find customer who spent the MOST AS MY SUBQUERY

SELECT t1.accountName
FROM (
  SELECT a.name as accountName, SUM(total_amt_usd) as totalSpent
  FROM orders o
  JOIN accounts a
  ON o.account_id = a.id
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 1
)t1

--use HAVING to match channels
SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id AND a.id =  (SELECT id
                     FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
                           FROM orders o
                           JOIN accounts a
                           ON a.id = o.account_id
                           GROUP BY a.id, a.name
                           ORDER BY 3 DESC
                           LIMIT 1) inner_table)
GROUP BY 1, 2
ORDER BY 3 DESC;


--#5
--TOP 10 SPENDING CUSOMTERS
SELECT t1.accountName, totalSpent
FROM (
  SELECT a.name as accountName, SUM(total_amt_usd) as totalSpent
  FROM orders o
  JOIN accounts a
  ON o.account_id = a.id
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 10
)t1

--NOW YOU WANT AVERAGE SPENT  304846.969000000000
SELECT AVG(t2.totalSpent)
FROM (
  SELECT t1.accountName, totalSpent
  FROM (
    SELECT a.name as accountName, SUM(total_amt_usd) as totalSpent
    FROM orders o
    JOIN accounts a
    ON o.account_id = a.id
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 10
  )t1

)t2

--#6 filter for companies that spent more per order, on avg compared to average of all orders
--first find average of all orders
SELECT AVG(total_amt_usd)
FROM orders

SELECT o.account_id, AVG(total_amt_usd) as AVGSpent
FROM orders o
GROUP BY 1
HAVING AVG(total_amt_usd) > (
  SELECT AVG(total_amt_usd)
  FROM orders o
)

SELECT AVG(t1.AVGSpent)
FROM (
  SELECT o.account_id, AVG(total_amt_usd) as AVGSpent
  FROM orders o
  GROUP BY 1
  HAVING AVG(total_amt_usd) > (
    SELECT AVG(total_amt_usd)
    FROM orders o
  )) t1


--Concepts 7
--1

--2

--Concepts 7
--1

--2

--Concepts 7
--1

--2


--Concepts 7
--1

--2

--Concepts 7
--1

--2

--Concepts 7
--1

--2

--Concepts 7
--1

--2
