-- SQL Retail Sales Analysis
create database sql_project_p1;
use sql_project_p1;
-- CREATE TABLE
DROP TABLE if exists retail_sales;
CREATE TABLE retail_sales 
(
			transactions_id	int primary key,
			sale_date DATE,
			sale_time TIME,
			customer_id INT,
			gender VARCHAR(15),
			age INT,
			category VARCHAR(15),
			quantiy INT,
			price_per_unit FLOAT,
			cogs FLOAT,
			total_sale float
);
SELECT * FROM retail_sales
LIMIT 10;


SELECT 
	count(*)
FROM retail_sales;

-- Data Cleaning
SELECT * FROM retail_sales 
WHERE 
transactions_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR
age IS NULL
OR
category IS NULL
OR
quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

-- Data Exploration

-- How many sales you have ?

SELECT COUNT(*) AS total_sales FROM retail_sales;

-- How many Unique customers we have?
SELECT COUNT(DISTINCT customer_id) AS total_unique_customers FROM retail_sales;

-- Total how many categories do we have ?
SELECT COUNT(DISTINCT category ) AS total_categories FROM retail_sales;

-- Data analysis and Business key problems

-- Q1 Write a SQL query to retrieve all columns for sales made on 2022-11-05

SELECT * 
FROM retail_sales
 WHERE sale_date = '2022-11-05';	
 
 -- Q2 Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 10 in month of Nov-2022
 
 SELECT *
 FROM retail_sales
 WHERE category='Clothing'
 AND
 quantiy >= 4
 AND
 MONTH(sale_date)=11
 AND
 YEAR(sale_date)=2022;	
 
 -- Q3 Write a SQL query to calculate the total sales for each category
 
 SELECT 
 category,
 SUM(total_sale) AS net_sales,
 COUNT(*) AS total_orders
 FROM retail_sales GROUP BY 
 category; 
 
 -- Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.alter
 
 SELECT
     ROUND( AVG(AGE),2 ) AS Average_age
 FROM retail_sales
 WHERE category='Beauty';
 
 
-- Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales 
WHERE total_sale > 1000;

-- Q6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

SELECT
     category,
     gender,
     COUNT(transactions_id) AS Number_of_transaction
FROM retail_sales 
GROUP
    BY
    category,
    gender
ORDER BY 1;

-- Q7 Write a SQL query to calculate the average sale for each month . Find out best selling month in each year

SELECT 
    year,
    month,
    Average_sales
FROM (
    SELECT 
        YEAR(sale_date) AS Year,
        MONTH(sale_date) AS Month,
        AVG(total_sale) AS Average_sales,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS sales_rank
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS ranked_months
WHERE sales_rank = 1;

-- Q8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
 GROUP BY customer_id 
 order by SUM(total_sale) DESC
 LIMIT 5;

-- Q9 Write a SQL query to find the number of unique customers who purchased items from each category


SELECT 
    category,
    COUNT(DISTINCT(customer_id)) AS count_of_unique_customers
FROM retail_sales 
GROUP BY category;

-- Q10 Write a SQL query to create each shift and number of orders (Example morning <=12,Afternoon Between 12 & 17 , Evening>17)

WITH hourly_sale
AS 
(
SELECT *,
 CASE 
    WHEN HOUR(sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END as shift
FROM retail_sales
)
SELECT 
   shift,
   COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift ;

-- End of Project




    
    











