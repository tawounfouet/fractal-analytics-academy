-- SELECT * FROM orders limit 5

-- show all data in the orders table
-- SELECT * FROM orders;
-- SELECT * FROM orders LIMIT 5;
-- SELECT * FROM orders LIMIT 10 offset 5;


-- show order_id, delivered_time, final_price, order_rating in the order table
-- select order_id, delivered_time, final_price, order_rating from orders;



-- number of order in the databse
-- select count(order_id) from orders;

-- number of unique orders id 
-- select count(distinct order_id) from orders;

-- how many drivers where needed to dilivers all the 43118 orders
-- select count(driver_id) from orders
-- select count(distinct driver_id) from orders;
-- the answer is 250 drivers


-- the latest order date : 2022-09-29 00:00:00
-- select order_date from orders
-- select max(order_date) from orders;

-- the oldest order date : 2022-06-01 00:00:00
-- select min(order_date) from orders;

-- Let's us try to understand how the 43118 orders have been distributed over the months 
-- Starting from the months of June-2022 up to the end of september

-- Total number of orders in the month of june : 12502
-- select count(order_id) from orders
-- where order_date >= '2022-06-01' and order_date <= '2022-06-30';
  
-- Total number of orders in the month of July : 11144
-- select count(order_id) from orders
-- where order_date >= '2022-07-01' and order_date <= '2022-07-31';

-- Let's now look the revenue of August but using between this time 
-- Total number of orders in the month of August : 10107
-- select count(order_id) from orders
-- where order_date between '2022-08-01' and '2022-08-30';

-- select count(order_id) as OrdersQuantity from orders
-- where order_date between '2022-08-01' and '2022-08-30';

-- Total number of orders in the month of Setptember : 9365
-- select count(order_id) as OrdersQuantity from orders
-- where order_date between '2022-09-01' and '2022-09-30';


-- Analysing the trend in sales
-- select count(order_id) as OrdersQuantity from orders group by order_date;
-- select order_date, count(order_id) as OrdersQuantity from orders group by order_date;

-- If we want the distribution by month, we have to employe datetime function in our queries
-- There are several fonctions such as : 
	-- MONTH() - returns month (1-12) from a date-time columns
    -- DAYOFWEEK() - returns day of week (1-7) from a date-time column 
									-- 1:Sunday, 7:Saturday
	
-- select month(order_date), count(order_id) as OrdersQuantity from orders group by month(order_date);
-- select month(order_date) as Order_Month, count(order_id) as OrdersQuantity from orders group by month(order_date);

-- If we wanted to arrange the monthly orders in ascending or descending order
-- select month(order_date) as Order_Month, count(order_id) as OrdersQuantity from orders group by Order_Month order by OrdersQuantity desc;

-- let's breakdown the single query into multiple lines for better lisibilty and comprehension
/*
SELECT MONTH(order_date) AS Order_Month, COUNT(order_id) AS OrderQuantity
FROM orders
GROUP BY Order_Month
ORDER BY OrderQuantity desc;
*/

-- So far we have deduce that the number of orders have been on a downward trend, let's see if the same trend exist in the revenu as well
SELECT MONTH(order_date) as Order_Month, COUNT(order_id) as OrderQuatity, SUM(final_price) as TotalRevenue
FROM orders
GROUP BY Order_Month
ORDER BY TotalRevenue desc;


-- Did Discounts have any impact on sales ?
-- Let's try to understand if discount have play any role in the company downdward trend revue 
-- Relationship between discount and revenu over the months
SELECT MONTH(order_date) as Order_Month, SUM(discount) as TotalDiscount, SUM(final_price) as TotalRevenue
FROM orders
GROUP BY Order_Month
ORDER BY Order_Month;


-- Use the ROUND function when a output as too many decimals
SELECT 
	MONTH(order_date) as Order_Month, 
	ROUND(SUM(discount),0)  as TotalDiscount, 
	ROUND(SUM(final_price), 0) as TotalRevenue
FROM orders

GROUP BY Order_Month
ORDER BY Order_Month;


-- ratio of 
SELECT 
	MONTH(order_date) as Order_Month, 
    ROUND(SUM(discount)/SUM(final_price), 5) as Discount_Sales_Ratio,
	ROUND(SUM(discount),0)  as TotalDiscount, 
	ROUND(SUM(final_price), 0) as TotalRevenue,
    COUNT(order_id) as OrderCount
FROM orders

GROUP BY Order_Month
ORDER BY Discount_Sales_Ratio;