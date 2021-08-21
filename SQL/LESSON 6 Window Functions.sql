--Window Functions

--Concepts 6
--1
SELECT standard_amt_usd,
	SUM(standard_amt_usd) OVER
	(ORDER BY occurred_at
    )AS runningTotal
FROM orders

--2
SELECT standard_amt_usd,
			 DATE_TRUNC('year', occurred_at) as year,
       SUM(standard_amt_usd) OVER
       (PARTITION BY DATE_TRUNC('year', occurred_at) ORDER BY occurred_at)
       AS running_total
FROM orders

--Concepts 12
--1

SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', occurred_at) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS sum_std_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS count_std_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS avg_std_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS min_std_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS max_std_qty
FROM orders

--2

SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', occurred_at) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id ) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id ) AS sum_std_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id ) AS count_std_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id ) AS avg_std_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id ) AS min_std_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id) AS max_std_qty
FROM orders

--3
Dense rank turns to the same rank 1 for all rows without the ORDER BY clause.
Also, I do not see incremental changes.

--Concepts 15
--1 WRONG, but close
SELECT id, account_id, total,
RANK() OVER (PARTITION BY account_id ORDER BY total DESC)
AS total_rank
FROM orders


--Concepts 18
--1
SELECT id,
       account_id,
       DATE_TRUNC('year',occurred_at) AS year,
       DENSE_RANK() OVER account_year_window AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER account_year_window AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER account_year_window AS count_total_amt_usd,
       AVG(total_amt_usd) OVER account_year_window AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER account_year_window AS min_total_amt_usd,
       MAX(total_amt_usd) OVER account_year_window AS max_total_amt_usd
FROM orders
WINDOW account_year_window AS
 (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at))


--Concepts 22
--1

SELECT occurred_at,
			 total_Revenue,
			 LAG(total_Revenue) OVER (ORDER BY occurred_at) AS lag,
			 LEAD(total_Revenue) OVER (ORDER BY occurred_at) AS lead,
			 total_Revenue - LAG(total_Revenue) OVER (ORDER BY occurred_at) AS lag_difference,
			 LEAD(total_Revenue) OVER (ORDER BY occurred_at) - total_Revenue AS lead_difference
FROM
(SELECT occurred_at,
			 SUM(total_amt_usd) AS total_Revenue
	FROM orders
 GROUP BY 1
) t1





--Concepts 15
--1

--Concepts 15
--1










--Concepts 15
--1

--Concepts 15
--1
