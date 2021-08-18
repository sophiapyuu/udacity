#SQL JOINS

#Concepts.4
#1
SELECT *
FROM accounts
JOIN orders
ON orders.account_id = accounts.id;

#2
SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty,
			accounts.website, accounts.primary_poc
FROM accounts
JOIN orders
ON orders.account_id = accounts.id;

#Concepts 11
#1
SELECT accounts.primary_poc, web_events.occurred_at, web_events.channel
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
WHERE name = 'Walmart'

#2 WRONG
SELECT r.name region, s.name rep, a.name account
FROM sales_reps AS s
JOIN accounts AS a
ON a.sales_rep_id = s.id
JOIN region AS r
ON s.region_id = r.id
ORDER BY a.name

#3
SELECT r.name region, a.name account, o.total_amt_usd/(o.total +.01) AS unit_price
FROM sales_reps AS s
JOIN accounts AS a
ON a.sales_rep_id = s.id
JOIN region AS r
ON s.region_id = r.id
JOIN orders AS o
ON a.id = o.account_id
ORDER BY a.name

#Concepts 19
#1 WRONG
SELECT r.name as regionName, s.name as salesName, a.name as AccountName
FROM sales_reps as s
LEFT JOIN accounts as a
ON s.id = a.sales_rep_id
LEFT JOIN region as r
ON r.id = s.region_id
WHERE s.name LIKE 'S%' AND r.name = 'Midwest'
Order By
	a.name

#2
SELECT r.name as regionName, s.name as salesName, a.name as AccountName
FROM sales_reps as s
LEFT JOIN accounts as a
ON s.id = a.sales_rep_id
LEFT JOIN region as r
ON r.id = s.region_id
WHERE s.name LIKE 'S%' AND r.name = 'Midwest'
Order By
	a.name

#3
SELECT r.name as regionName, s.name as salesName, a.name as AccountName
FROM sales_reps as s
LEFT JOIN accounts as a
ON s.id = a.sales_rep_id
LEFT JOIN region as r
ON r.id = s.region_id
WHERE s.name LIKE '% K%' AND r.name = 'Midwest'
Order By
	a.name

#4
SELECT r.name as RegionName, a.name as AccountName, o.total_amt_usd/(o.total+.01) as unitPrice
FROM orders as o
LEFT JOIN accounts as a
ON o.account_id = a.id
LEFT JOIN sales_reps as s
ON a.sales_rep_id = s.id
LEFT JOIN region as r
ON s.region_id = r.id
WHERE o.standard_qty > 100;

#5 835
SELECT r.name as RegionName, a.name as AccountName, o.total_amt_usd/(o.total+.01) as unitPrice
FROM orders as o
LEFT JOIN accounts as a
ON o.account_id = a.id
LEFT JOIN sales_reps as s
ON a.sales_rep_id = s.id
LEFT JOIN region as r
ON s.region_id = r.id
WHERE o.standard_qty > 100 AND o.poster_qty >50
ORDER BY unitPrice

#6
SELECT r.name as RegionName, a.name as AccountName, o.total_amt_usd/(o.total+.01) as unitPrice
FROM orders as o
LEFT JOIN accounts as a
ON o.account_id = a.id
LEFT JOIN sales_reps as s
ON a.sales_rep_id = s.id
LEFT JOIN region as r
ON s.region_id = r.id
WHERE standard_qty > 100 AND poster_qty >50
ORDER BY
	unitPrice DESC

#7 1509
SELECT DISTINCT a.name, w.channel
FROM accounts as a
LEFT JOIN web_events as w
ON a.id = w.account_id
WHERE a.id = '1001'

#8 WRONG!!
SELECT *
FROM orders AS o
LEFT JOIN accounts AS a
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015'AND '01-01-2016'
ORDER BY o.occurred_at DESC;
