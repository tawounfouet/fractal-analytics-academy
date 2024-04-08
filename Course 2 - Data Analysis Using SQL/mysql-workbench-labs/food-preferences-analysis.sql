-- Analysing the Food Preferences of Customers

/* Querying food_items Table
	cols : item_id, restaurant_id, item_name, food_type, price, calories
*/
-- select * from food_items;

/* Querying orders_items Table
	cols : order_id, item_id, quantity (quantity of the item ordered)
*/
-- select * from orders_items;

-- food_items & orders_items Tables have both in commun the item_id (which is the column we will use to join our table

/* Since the food_items have all the informations we need 
	-> let's join the orders_item with the food_items table using the left join
    -> Why LEFT JOIN ? 
		-> Simply because we want to extract all the informations from the orders item tables 
		and map the food type for each item for from food_item
*/
-- Let's write the query

-- select * from orders_items LEFT JOIN food_items ON orders_items.item_id = food_items.item_id;

-- select * from orders_items AS oi LEFT JOIN food_items as fi ON oi.item_id = fi.item_id;	

/* Counts the ... 
	counts : 64727
*/
-- select count(*) from orders_items AS oi LEFT JOIN food_items as fi ON oi.item_id = fi.item_id;	

/* Counts the ... 
	counts : 64727
*/
select count(*) from orders_items AS oi INNER JOIN food_items as fi ON oi.item_id = fi.item_id;	

-- Number of orders for each food_type
/*
SELECT 
	fi.food_type, 
	sum(oi.quantity) AS items_quantity 
FROM orders_items AS oi 
LEFT JOIN food_items AS fi 
ON oi.item_id = fi.item_id
GROUP BY fi.food_type;
*/

/* Output
food_type     | items_quantity
veg.            20959
Non-Veg		    60882
vegeterian.     2280
non-vegeterian  60882
*/

-- LIKE - used to match a single character or a set of characters
/*
select item_id,
	case 
		when food_type like "veg%" 
			then "veg"
        else
			"non-veg"
	end 
    as food_type_new
from food_items;
*/        
 
 
 
 /* output of the following query
	veg : 23239
    non-veg : 63077
 We can observe from our analysis that customers prefered ordering more 2* more non-veg  than veg
  -> actions : Foodhunter cool try to diversify their non-veg food 
 */
-- 
SELECT t2.food_type_new, sum(t1.quantity) AS item_quantity
FROM orders_items as t1
LEFT JOIN (
	select item_id,
	case 
		when food_type like "veg%" then "veg"
        else "non-veg"
	end as food_type_new
	from food_items
) as t2 
ON t1.item_id = t2.item_id
GROUP BY t2.food_type_new;




