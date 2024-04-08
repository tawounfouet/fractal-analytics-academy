-- Step 1. Find Total Revenu for weekdays and weedends over 04months

SELECT 
	CASE
		WHEN DAYOFWEEK(order_date) BETWEEN 2 AND 6 THEN 'Weekday'
		WHEN DAYOFWEEK(order_date) IN (1, 7) THEN 'Weekend'
	END AS Day_of_Week,       
	Month(order_date) AS Month,
	Round(SUM(final_price),0) AS total_revenue
    
FROM orders
GROUP BY Day_of_week, Month
ORDER BY Day_of_week;