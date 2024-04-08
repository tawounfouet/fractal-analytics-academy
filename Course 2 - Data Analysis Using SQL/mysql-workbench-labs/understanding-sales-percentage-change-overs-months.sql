-- Understand the Percentage Change in Sales Over Months

-- 1. Find Total Revenu for weekdays and weedends over 04months
-- 2. Compare values with previous month for weekends and weekdays
-- 3. Find the percentage change in Revenu

select *, 
	round((total_revenue - previous_prev / previous_prev) * 100) as Percentage_Change
		from
			(
				select *, 
					LAG(total_revenue) OVER (partition by Day_of_week) as previous_prev
				from 
			(
            SELECT 
				CASE
					WHEN DAYOFWEEK(order_date) BETWEEN 2 AND 6 THEN 'Weekday'
                    WHEN DAYOFWEEK(order_date) IN (1, 7) THEN 'Weekend'
				END AS Day_of_Week,
                Month(order_date) AS Month,
                Round(SUM(final_price),0) AS total_revenue
				FROM orders
                GROUP BY Day_of_week, Month
                ORDER BY Day_of_week
			) as t1
				
		) as t2;
		
				
				
			
 