-- Converting Raw Data into a Structured Relational Dataset

/* CRUD Operations */

-- Create new database call competitor_analysis
/*
create database  competitor_analysis;
use competitor_analysis;
*/

-- create vendors tables
/* create a table called vendors with the columns company_id, name, website, number of users, and number of the cities 
	the primary_key : it's a constraints that uniquely identify each record in table
     -> Let's used company_id for our vendor table
*/
-- CREATE TABLE vendors (company_id varchar(5) primary key, name char(255), website varchar(255), num_users int, num_cities int);

-- Let's now insert values in our newly created table
/* Add the company_id, name, website, number of users, and number of the cities 
 into the vendors table of the competitor analyisis whose values are : 
 ('C3' 'ZippyEats', "https://www.zippy-eats.com", '7770' 11),
 ('C4' 'FlavourGo', "https://www.flavour-go.com", '9789' 18)
 */

/*
 INSERT INTO competitor_analysis.vendors (company_id, name, website, num_users, num_cities)
 VALUES 
	('C1', 'FoodBae', "https://www.food-bae.com", '8450', 15),
    ('C2', 'Yumzo', "https://www.yumzo.com", '9670', 18),
	('C3', 'ZippyEats', "https://www.zippy-eats.com", '7770', 11),
	('C4', 'FlavourGo', "https://www.flavour-go.com", '9789', 18);
*/

select * from vendors;
    
 
 
 
 