#SQL Aggregations

#Concepts 7
#1
SELECT SUM(poster_qty)
FROM orders
723646

#2
SELECT SUM(standard_qty)
FROM orders
1938346

#3
SELECT SUM(total_amt_usd)
FROM orders
23141511.83

#4 WRONG (read question wrong)
SELECT standard_amt_usd + gloss_amt_usd as total_standard_gloss
FROM orders

5.
SELECT SUM(standard_amt_usd) / SUM(standard_qty) as price_per_unit_standard
FROM orders
4.99

#Concepts 11
#1
SELECT MIN(occurred_at)
FROM orders
2013-12-04

#2 - sort by date
SELECT occurred_at
FROM orders
ORDER BY
	occurred_at
LIMIT 1

#3
SELECT MAX(occurred_at)
FROM web_events
2017-01-01T23:51:09.000Z

#4
SELECT occurred_at
FROM web_events
ORDER BY
	occurred_at DESC
LIMIT 1
2017-01-01T23:51:09.000Z

#5
SELECT AVG(standard_amt_usd) as standardSpent, AVG(gloss_amt_usd) as glossSpent, AVG(poster_amt_usd) as posterSpent, AVG(standard_qty) as totalPaperAmount, AVG(gloss_qty) as totalGloss, AVG(poster_qty) as totalPoster
FROM orders
1399.3556915509259259	1098.5474204282407407	850.1165393518518519	280.4320023148148148	146.6685474537037037	104.6941550925925926

#6 WRONG
SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;


#Concepts 14
#1
SELECT account_id, occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1
2861
SELECT accounts.name
FROM accounts
WHERE id = 2861
DISH Network

#2
SELECT a.name, SUM(o.total_amt_usd) as totalSales
FROM orders as o
JOIN accounts as a
ON o.account_id = a.id
GROUP BY a.name

#3
SELECT w.occurred_at, w.channel, a.name
FROM web_events as w
JOIN accounts as a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1
2017-01-01T23:51:09.000Z	organic	Molina Healthcare

#4 CORRECT, but different syntax for same operation
SELECT COUNT ( channel), channel
FROM web_events
GROUP BY channel

EQUIVALENT TO
SELECT w.channel, COUNT(*)
FROM web_events w
GROUP BY w.channel

#5
SELECT a.primary_poc
FROM web_events as w
JOIN accounts as a
ON w.account_id = a.id
ORDER BY occurred_at
LIMIT 1
Leana Hawker

#6 WRONG
SELECT account_id,
	MIN(total_amt_usd)
FROM orders
GROUP BY account_id, total_amt_usd
ORDER BY total_amt_usd

#7
SELECT r.name, count (s.id)
FROM sales_reps AS s
JOIN region AS r
on s.region_id = r.id
GROUP BY r.name


#Concepts 17
#1
SELECT a.name,
	AVG (standard_qty) as avgStandard,
    AVG (gloss_qty) as avgGloss,
    AVG (poster_qty) as avgPoster
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
GROUP BY a.name

#2
SELECT a.name,
	AVG (standard_amt_usd) as spentStandard,
    AVG (gloss_amt_usd) as spentGloss,
    AVG (poster_amt_usd) as spentPoster
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
GROUP BY a.name

#3
SELECT s.name, w.channel, COUNT(*) as occurrences
FROM web_events as w
JOIN accounts as a
ON w.account_id = a.id
JOIN sales_reps as s
ON s.id = a.sales_rep_id
GROUP BY s.name, w.channel
ORDER BY occurrences DESC

#4
SELECT r.name, w.channel, COUNT(*) as occurrences
FROM web_events as w
JOIN accounts as a
ON w.account_id = a.id
JOIN sales_reps as s
ON s.id = a.sales_rep_id
JOIN region as r
ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY occurrences DESC

#Concepts 20 SUPER WRONG
#1 WRONG
SELECT DISTINCT r.name, a.name
FROM region AS r
JOIN sales_reps as s
ON r.id = s.region_id
JOIN accounts as a
ON a.sales_rep_id = s.id

#2 YES, WRONG
SELECT DISTINCT a.sales_rep_id, a.name
FROM region AS r
JOIN sales_reps as s
ON r.id = s.region_id
JOIN accounts as a
ON a.sales_rep_id = s.id


#Concepts 7
#1 34 of them
SELECT DISTINCT a.sales_rep_id, COUNT(a.sales_rep_id)
#SELECT s.id, s.name, COUNT(*) num_accounts same as above use (*) syntax
FROM accounts as a
JOIN sales_reps as s
ON s.id = a.sales_rep_id
GROUP BY a.sales_rep_id
HAVING COUNT(a.sales_rep_id) >5

#2 120 of them
SELECT o.account_id, count(o.account_id)
FROM accounts as a
JOIN orders as o
ON o.account_id = a.id
GROUP BY o.account_id
HAVING count(o.account_id) >20

#3 account id 3411  Leucadia National
SELECT o.account_id, count(o.account_id) as countHigh, a.name
FROM accounts as a
JOIN orders as o
ON o.account_id = a.id
GROUP BY o.account_id, a.name
HAVING count(o.account_id) >20
ORDER BY countHigh DESC

#4 204 of them
SELECT o.account_id, SUM(o.total_amt_usd) as totalUSD
FROM accounts as a
JOIN orders as o
ON o.account_id = a.id
GROUP BY o.account_id
HAVING SUM(o.total_amt_usd) > 30000

#5 4321, 1901, 1671
SELECT o.account_id, SUM(o.total_amt_usd) as totalUSD
FROM accounts as a
JOIN orders as o
ON o.account_id = a.id
GROUP BY o.account_id
HAVING SUM(o.total_amt_usd) < 1000

#6 account_id 4211 EOG Rsources
SELECT o.account_id, SUM(o.total_amt_usd) as totalUSD, a.name
FROM accounts as a
JOIN orders as o
ON o.account_id = a.id
GROUP BY o.account_id, a.name
ORDER BY totalUSD DESC
LIMIT 1

#7 1901 Nike
SELECT o.account_id, SUM(o.total_amt_usd) as totalUSD, a.name
FROM accounts as a
JOIN orders as o
ON o.account_id = a.id
GROUP BY o.account_id, a.name
ORDER BY totalUSD
LIMIT 1

#8 46
SELECT DISTINCT a.name, w.channel, count (w.channel)
FROM web_events as w
JOIN accounts as a
ON w.account_id = a.id
WHERE channel = 'facebook'
GROUP BY w.channel, a.name
HAVING count (w.channel)>6

#9 GILEAD SCIENCES
SELECT DISTINCT a.name, w.channel, count (w.channel) as fbChannel
FROM web_events as w
JOIN accounts as a
ON w.account_id = a.id
WHERE channel = 'facebook'
GROUP BY w.channel, a.name
ORDER BY fbChannel DESC
LIMIT 1

#10 direct	5298
SELECT DISTINCT  w.channel, count (w.channel) as allChannel
FROM web_events as w
JOIN accounts as a
ON w.account_id = a.id
GROUP BY w.channel
ORDER BY allChannel DESC

#Concepts 27
#1
SELECT DATE_TRUNC('year', occurred_at), sum(total_amt_usd)
FROM orders
GROUP BY 1
ORDER BY 2 DESC

#2
SELECT DATE_PART('month', occurred_at), sum(total_amt_usd)
FROM orders
GROUP BY 1
ORDER BY 2 DESC

#3 2016 greatest # of orders, years 2013 and 2017 seems to be misrepresented
SELECT DATE_TRUNC('year', occurred_at), count (*)
FROM orders
GROUP BY 1
ORDER BY 2 DESC

#4 DEC
SELECT DATE_PART('month', occurred_at), count (*)
FROM orders
GROUP BY 1
ORDER BY 2 DESC

#5 05 2016
SELECT DATE_TRUNC('month', occurred_at), SUM(gloss_amt_usd)
FROM orders as o
JOIN accounts as a
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC
#Concepts 7
#1
SELECT account_id, total_amt_usd,
		CASE WHEN total_amt_usd > 3000 THEN 'Large'
				 WHEN total_amt_usd < 3000 THEN 'Small'
		END
FROM orders

#2 total # of items
SELECT  COUNT (*), CASE
		WHEN total > 2000 THEN 'At Least 2000'
		WHEN total > 1000 AND total <2000 THEN 'Between 1000 and 2000'
		WHEN total < 1000 THEN 'Less than 1000'
		END
FROM orders
GROUP BY 2

#3 SUPER WRONG
SELECT DISTINCT a.name, o.total_amt_usd,
		CASE WHEN SUM(total_amt_usd) > 200000 THEN 'Lvl Amazing'
				 WHEN SUM(total_amt_usd) < 200000 AND SUM(total_amt_usd) > 100000 THEN 'Lvl Average'
				 WHEN SUM(total_amt_usd) < 100000 THEN 'Lvl Crap'
		END
FROM orders as o
JOIN accounts as a
ON o.account_id = a.id
GROUP BY a.name, o.total_amt_usd


#4 SUPER WRONG
SELECT account_id, SUM(total_amt_usd),
		CASE WHEN sum(total_amt_usd) > 3000 THEN 'Large'
				 WHEN total_amt_usd < 3000 THEN 'Small'
		END
FROM orders
WHERE occurred_at BETWEEN '2016-01-01' AND '2018-01-01'
ORDER BY
	2 DESC

#5
SELECT s.name, COUNT(*) as totalOrders,
	CASE WHEN COUNT(*) >200  THEN 'top'
    	 WHEN COUNT(*) <200  THEN 'not'
    END
FROM sales_reps as s
JOIN accounts as a
ON s.id = a.sales_rep_id
JOIN orders as o
ON o.account_id = a.id
GROUP BY s.name
ORDER BY 2 DESC

#6 WRONG 
SELECT s.name, COUNT(*) as totalOrders, SUM(o.total_amt_usd) total_spent,
	CASE WHEN COUNT(*) >200 OR SUM(o.total_amt_usd) > 75000 THEN 'top'
		   WHEN COUNT(*) >150 OR SUM(o.total_amt_usd) > 50000 THEN 'middle'
    	 ELSE'low'
    END
FROM sales_reps as s
JOIN accounts as a
ON s.id = a.sales_rep_id
JOIN orders as o
ON o.account_id = a.id
GROUP BY s.name
ORDER BY 2 DESC
