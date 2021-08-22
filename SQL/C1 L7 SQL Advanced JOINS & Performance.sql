--Advanced JOINS and Performance

--Concepts 3
--1
SELECT *
FROM accounts a
FULL JOIN sales_reps s
ON a.sales_rep_id = s.id

--1 unmatched
SELECT *
FROM accounts a
FULL JOIN sales_reps s
ON a.sales_rep_id = s.id
WHERE a.sales_rep_id IS NULL OR s.id IS NULL


--Concepts 6
--1
SELECT a.name as accountname,
	     a.primary_poc as poc, s.name as salesName
FROM accounts a
LEFT JOIN sales_reps s
ON a.sales_rep_id = s.id
AND a.primary_poc < s.name


--Concepts 9
--1 WRONG
SELECT
w1.account_id w1_aid,
w2.account_id w2_aid,
w1.occurred_at AS we1_occurred_at, w2.occurred_at w2_occured,
w1.channel as channel1,
w2.channel as channel2
FROM web_events w1
LEFT JOIN web_events w2
ON w1.account_id = w2.account_id
AND w2.occurred_at > w1.occurred_at
AND w2.occurred_at <= w1.occurred_at + INTERVAL '1 day'
ORDER BY w1.account_id, w2.occurred_at

--Concepts 12
--PART 1
SELECT *
FROM accounts a

UNION ALL

SELECT *
from accounts a2

--PART 2
SELECT *
FROM accounts a
WHERE a.name = 'Walmart'

UNION ALL

SELECT *
FROM accounts a2
WHERE a2.name = 'Disney'

--PART 3 using common table expression named double_accounts
WITH double_accounts AS(
  SELECT *
  FROM accounts a

  UNION ALL

  SELECT *
  from accounts a2)
SELECT count(*), name
FROM double_accounts
GROUP BY 2









--Concepts 15
--1





--Concepts 15
--1





--Concepts 15
--1





--Concepts 15
--1





--Concepts 15
--1





--Concepts 15
--1





--Concepts 15
--1





--Concepts 15
--1





--Concepts 15
--1
