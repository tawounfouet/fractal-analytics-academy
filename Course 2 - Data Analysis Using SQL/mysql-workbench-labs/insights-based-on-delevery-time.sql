-- Insights Based on Delery Time

/* TIMESTAMPDIFF() - extracts hour/minute/second as per the requirement */

-- select * from orders;

/*
SELECT Month(order_date) as OrderMonth,
AVG(TIMESTAMPDIFF(MINUTE, order_time, delivered_time)) as average_delivery_time
FROM orders
GROUP BY OrderMonth
*/

/*
select * from
(
	SELECT month, driver_id, avg_time, RANK() OVER (PARTITION BY month ORDER BY avg_time) AS driver_rank
	FROM MONTH(order_date) as month, driver_id, AVG(minute(TIMEDIFF(delivered_time, order_time))) as avg_time
		FROM orders
        GROUP BY month, driver_id
	) AS query_1
) AS query_2
where driver_rank between 1 and 5;
*/

SELECT *
FROM (
    SELECT month, driver_id, avg_time, RANK() OVER (PARTITION BY month ORDER BY avg_time) AS driver_rank
    FROM (
        SELECT MONTH(order_date) AS month, driver_id, AVG(TIMESTAMPDIFF(MINUTE, order_time, delivered_time)) AS avg_time
        FROM orders
        GROUP BY month, driver_id
    ) AS query_1
) AS query_2
WHERE driver_rank BETWEEN 1 AND 5;


