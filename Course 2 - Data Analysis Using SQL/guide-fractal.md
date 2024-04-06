


```bash

### Creating a new admin user
```bash

# Connect to the MySQL server using the root user and password
mysql -u root -p 
# Enter password: ********


# Provide a MySQL user name when you invoke mysql and, most likely, a password
# username : awf
# password : awf
# host : localhost
# database : all
# privileges : all
# grant option : yes
CREATE USER 'awf'@'localhost' IDENTIFIED BY 'awf';
GRANT ALL PRIVILEGES ON *.* TO 'awf'@'localhost' WITH GRANT OPTION;


mysql -u awf -p 

# 
CREATE DATABASE IF NOT EXISTS food_delivery;

# dump the database
mysql -u awf -p food_delivery < food_delivery_dataset.sql

# dump the database
mysqldump -u awf -p --no-create-info food_delivery > food_delivery.sql


# Create SQLite database: Create an empty SQLite database using the sqlite3 command-line tool.
sqlite3 food_db.sqlite

# Import MySQL data into SQLite (optional): If you exported the data from MySQL, you can import it into the SQLite database.
sqlite3 food_db.sqlite < food_delivery.sql


# create sqlite database using food_delivery.sql
sqlite3 food_db.sqlite < food_delivery.sql

```

```bash
SELECT * FROM food_delivery INTO OUTFILE "/Users/awf/Projects/coursera/fractal-analytics-data-science/Course 2 - Data Analysis Using SQL/file.csv"

FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n';


```


### Synergix Case Study

```bash
mysql -u awf -p 


# Create a new database
#CREATE DATABASE IF NOT EXISTS synergix;
create database synergix;

# Use the database
USE synergix;


# basic query

SELECT YEAR(Pos_date) AS date_year,
	SUM(revenue) AS Total_Revenue, 
	SUM(CASE WHEN segment = 'Hair Care' THEN revenue ELSE 0 END) AS Hair_Care_Revenue,
    SUM(CASE WHEN segment = 'Makeup' THEN revenue ELSE 0 END) AS Makeup_Revenue,
    SUM(CASE WHEN segment = 'SkinCare' THEN revenue ELSE 0 END) AS Skin_Care_Revenue
FROM pos_data 
GROUP BY date_year;


# Now Find the percentage  change in this  revenue using the concpet of window function


SELECT date_year,
    Total_Revenue,
   (Total_Revenue - LAG(Total_Revenue, 1) OVER (ORDER BY date_year)) / LAG(Total_Revenue, 1) OVER (ORDER BY date_year) * 100 AS Total_Revenue_Percentage_Change,
    Hair_Care_Revenue,
    (Hair_Care_Revenue - LAG(Hair_Care_Revenue, 1) OVER (ORDER BY date_year)) / LAG(Hair_Care_Revenue, 1) OVER (ORDER BY date_year) * 100 AS Hair_Care_Revenue_Percentage_Change,
    Makeup_Revenue,
    (Makeup_Revenue - LAG(Makeup_Revenue, 1) OVER (ORDER BY date_year)) / LAG(Makeup_Revenue, 1) OVER (ORDER BY date_year) * 100 AS Makeup_Revenue_Percentage_Change,
    Skin_Care_Revenue,
    (Skin_Care_Revenue - LAG(Skin_Care_Revenue, 1) OVER (ORDER BY date_year)) / LAG(Skin_Care_Revenue, 1) OVER (ORDER BY date_year) * 100 AS Skin_Care_Revenue_Percentage_Change
FROM (
    SELECT YEAR(Pos_date) AS date_year,
        SUM(revenue) AS Total_Revenue, 
        SUM(CASE WHEN segment = 'Hair Care' THEN revenue ELSE 0 END) AS Hair_Care_Revenue,
        SUM(CASE WHEN segment = 'Makeup' THEN revenue ELSE 0 END) AS Makeup_Revenue,
        SUM(CASE WHEN segment = 'SkinCare' THEN revenue ELSE 0 END) AS Skin_Care_Revenue
    FROM pos_data 
    GROUP BY date_year
) AS subquery;


SELECT date_year,
    Total_Revenue,
   (Total_Revenue - LAG(Total_Revenue) OVER (ORDER BY date_year)) / LAG(Total_Revenue) OVER (ORDER BY date_year) * 100 AS Total_Revenue_Percentage_Change,
    Hair_Care_Revenue,
    (Hair_Care_Revenue - LAG(Hair_Care_Revenue) OVER (ORDER BY date_year)) / LAG(Hair_Care_Revenue) OVER (ORDER BY date_year) * 100 AS Hair_Care_Revenue_Percentage_Change,
    Makeup_Revenue,
    (Makeup_Revenue - LAG(Makeup_Revenue) OVER (ORDER BY date_year)) / LAG(Makeup_Revenue) OVER (ORDER BY date_year) * 100 AS Makeup_Revenue_Percentage_Change,
    Skin_Care_Revenue,
    (Skin_Care_Revenue - LAG(Skin_Care_Revenue) OVER (ORDER BY date_year)) / LAG(Skin_Care_Revenue) OVER (ORDER BY date_year) * 100 AS Skin_Care_Revenue_Percentage_Change
FROM (
    SELECT YEAR(Pos_date) AS date_year,
        SUM(revenue) AS Total_Revenue, 
        SUM(CASE WHEN segment = 'Hair Care' THEN revenue ELSE 0 END) AS Hair_Care_Revenue,
        SUM(CASE WHEN segment = 'Makeup' THEN revenue ELSE 0 END) AS Makeup_Revenue,
        SUM(CASE WHEN segment = 'SkinCare' THEN revenue ELSE 0 END) AS Skin_Care_Revenue
    FROM pos_data 
    GROUP BY date_year
) AS subquery;

# Prodcuct Based Analysis of SalesS


#
SELECT 
	SKU_ID,
    SUM(`Revenue`) AS Totale_Revenue
FROM pos_data
GROUP BY SKU_ID
ORDER BY Totale_Revenue DESC


SELECT 
	SKU_ID,
    SUM(`Revenue`) AS Totale_Revenue,
    SUM(`Page_traffic`) AS Total_Traffic
FROM pos_data
GROUP BY SKU_ID
ORDER BY Totale_Revenue DESC

;


# now find traffic contribution for each product

SELECT 
    SKU_ID, total_revenue, total_traffic,
CASE 
    WHEN total_revenue!=0 and total_traffic!=0 THEN `A`
    WHEN total_revenue=0 and total_traffic!=0 THEN `B`
    WHEN total_revenue!=0 and total_traffic=0 THEN `C`
    WHEN total_revenue=0 and total_traffic=0 THEN `D`
    END AS `prod_type`
FROM 
(
    SELECT 
        SKU_ID,
        SUM(`Revenue`) AS total_revenue,
        SUM(`Page_traffic`) AS total_traffic
    FROM pos_data
    GROUP BY SKU_ID
    ORDER BY totale_revenue ASC
) AS subquery