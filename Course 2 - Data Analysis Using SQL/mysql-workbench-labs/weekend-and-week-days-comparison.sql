-- Step 2. Compare values with previous month for weekends and weekdays

-- Windows Functions 
/*  Understanding Windows Functions

Windows functions are mainly two types :
- Aggrate Window Functions : SUM(), AVG(), MAX(), MIN(), COUNT()
- Analytical Window Functions: LAG(), LEAD(), RANK, DENSE RANK(), ROW NUMBER()

Exple :
SELECT *,
	AVG(salary) OVER(partitiob by Dep_Id) AS Avg_Salary
FROM employee,


PARTITION BY :  specifies the columns by which rows are grouped within a window
The PARTITION BY clause in SQL window functions is used to partition the result set into groups of rows 
based on the values of one or more columns. Within each partition, the window function is applied independently,
 allowing for separate calculations to be performed on each group of rows. 
 
 We use the PARTITION BY clause to create a subset of rows on which a window function can be applied
 In a SQL query, the PARTITION BY clause is typically used to partition the result set into groups of rows
 based on the values of one or more columns. This partitioning allows window functions to be applied independently 
 within each group of rows. Therefore, it creates a subset of rows on which a window function can be applied.
*/
