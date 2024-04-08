-- Finding Restaurants With No Items Ordered ç! 

/*  
	Task : Find the number of items ordered from each of the restaurants
    
How many time items for oders from each restaurant on the foodhunter app *

*/


SELECT r.restaurant_name, r.restaurant_id, r.cuisine, SUM(quantity) as item_quantity
FROM restaurants as r
LEFT JOIN food_items as fi ON r.restaurant_id = fi.restaurant_id
LEFT JOIN orders_items as oi ON fi.item_id = oi.item_id
GROUP BY r.restaurant_id
-- WHERE item_quantity=0; Where should not be used after aggregation, instead use the HAVING clause
HAVING item_quantity is NULL -- HAVING is used along with aggregate functions to add criteria
ORDER BY item_quantity;

/* We can observed that most of this restaurants where the were no orders are italias */



/*
SELECT r.restaurant_name, r.restaurant_id, r.cuisine, SUM(quantity) as item_quantity
FROM restaurant as r
LEFT JOIN food_items as fi ON r.restaurant_id = fi.restaurant_id
LEFT JOIN orders_items as oi ON fi.item_id = oi.item_id
GROUP BY r.restaurant_name, r.restaurant_id, r.cuisine;
*/


