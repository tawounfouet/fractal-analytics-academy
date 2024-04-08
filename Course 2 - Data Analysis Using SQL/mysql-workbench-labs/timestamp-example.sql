SELECT MONTH(order_date) AS month, driver_id, AVG(TIMESTAMPDIFF(MINUTE, order_time, delivered_time)) AS avg_time
FROM orders
GROUP BY month, driver_id