SALES--Revenue per transaction
SELECT TRANSACTION_ID,

transaction_qty*unit_price
AS revenue
FROM 
BRIGHT_COFFEE_CASESTUDY.SALES.COFFEE_SHOP;

--We use COUNT to count our IDs not SUM
--This is the total number of sales/transactions made
SELECT
COUNT(transaction_id) AS number_of_transactions
FROM
BRIGHT_COFFEE_CASESTUDY.SALES.COFFEE_SHOP;

--COUNT the number of different shops we have in this data
SELECT COUNT(DISTINCT store_id) AS number_of_shops
FROM
BRIGHT_COFFEE_CASESTUDY.SALES.COFFEE_SHOP;

--To show us the name of the different store location which is actually 3 different shops
SELECT DISTINCT store_location,
store_id
FROM
BRIGHT_COFFEE_CASESTUDY.SALES.COFFEE_SHOP;

--How to calculate the revenue by store loction
SELECT store_location,
SUM(transaction_qty*unit_price) AS revenue
FROM
BRIGHT_COFFEE_CASESTUDY.SALES.COFFEE_SHOP
GROUP BY store_location;

--What time does the shop opens
SELECT
MIN(transaction_time) opening_time
FROM
BRIGHT_COFFEE_CASESTUDY.SALES.COFFEE_SHOP;

--What time does the shop close
SELECT
MAX(transaction_time) closing_time
FROM
BRIGHT_COFFEE_CASESTUDY.SALES.COFFEE_SHOP;

SELECT product_category,
SUM(transaction_qty*unit_price) AS revenue,
store_location,
transaction_date,
transaction_time,
CASE
WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN '01.Morning'
WHEN transaction_time BETWEEN '12:00:00' AND  '15:59:59' THEN  '02.Afternoon'
WHEN transaction_time BETWEEN '16:00:00' AND '19:59:59' THEN '03.Evening'
WHEN transaction_time >= '20:00:00' THEN '04.Night'
END AS time_bucket
FROM BRIGHT_COFFEE_CASESTUDY.SALES.COFFEE_SHOP
WHERE transaction_date >'2023-05-01'
GROUP BY product_category,
transaction_date,
store_location,
time_bucket,
transaction_time
ORDER BY revenue DESC;
