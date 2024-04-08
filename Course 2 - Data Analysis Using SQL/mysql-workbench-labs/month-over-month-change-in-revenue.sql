    -- Compare Month-On-Month Change in Revenue
    
    -- Step 3. Find the percentage change in Revenue
    
    SELECT *,
           LAG(total_revenue) OVER (PARTITION BY Day_of_Week ORDER BY Month) AS previous_prev
    FROM (
        SELECT 
            CASE
                WHEN DAYOFWEEK(order_date) BETWEEN 2 AND 6 THEN 'Weekday'
                WHEN DAYOFWEEK(order_date) IN (1, 7) THEN 'Weekend'
            END AS Day_of_Week,
            MONTH(order_date) AS Month,
            ROUND(SUM(final_price), 0) AS total_revenue
        FROM orders
        GROUP BY Day_of_Week, Month
        -- WHERE order_date >= '2022-04-01' AND order_date < '2022-08-01'
    ) AS t1