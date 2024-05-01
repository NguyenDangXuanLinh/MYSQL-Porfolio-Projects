-- Using Common Table Expressions (CTE)
-- A CTE allows you to define a subquery block that can be referenced within the main query. 
-- It is particularly useful for recursive queries or queries that require referencing a higher level
-- this is something we will look at in the next lesson/


# CTEs start using a "With" Keyword. Now we get to name this CTE anything we want
#Then we say as and within the parenthesis we build our subquery/table we want
	
WITH CTE_Example AS 
(
SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary), AVG(salary)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
-- directly after using it we can query the CTE
SELECT *
FROM CTE_Example;



SELECT *
FROM CTE_Example;



WITH CTE_Example AS 
(
SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
-- notice here I have to use back ticks to specify the table names  - without them it doesn't work
SELECT gender, ROUND(AVG(`SUM(salary)`/`COUNT(salary)`),2)
FROM CTE_Example
GROUP BY gender;


-- Create multiple CTEs with just one With Expression

WITH CTE_Example AS 
(
SELECT employee_id, gender, birth_date
FROM employee_demographics dem
WHERE birth_date > '1985-01-01'
), -- just have to separate by using a comma
CTE_Example2 AS 
(
SELECT employee_id, salary
FROM parks_and_recreation.employee_salary
WHERE salary >= 50000
)
-- Join these two CTEs together
SELECT *
FROM CTE_Example cte1
LEFT JOIN CTE_Example2 cte2
	ON cte1. employee_id = cte2. employee_id;


-- we can rename using CTE
WITH CTE_Example (gender, sum_salary, min_salary, max_salary, count_salary) AS 
(
SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
-- notice I have to use back ticks to specify the table names  - without them it doesn't work
SELECT gender, ROUND(AVG(sum_salary/count_salary),2)
FROM CTE_Example
GROUP BY gender;


























