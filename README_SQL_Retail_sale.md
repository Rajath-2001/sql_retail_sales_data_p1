
#  SQL Retail Sales Analysis Project

##  Project Overview

**Project Title**: SQL-Based Retail Sales Analysis  
**Database**: `sql_project_p1`

This project demonstrates the application of core SQL skills to analyze retail sales data. It involves database setup, data cleaning, exploration, and solving practical business problems using SQL queries. The project helps in understanding customer behavior, product performance, and sales trends.

---

##  Project Objectives

1. **Set up the retail database** – Create a database and define the schema to store transaction data.
2. **Clean the data** – Identify and handle missing values.
3. **Explore the data** – Derive insights through basic exploratory SQL queries.
4. **Answer business questions** – Use SQL to solve real-world problems in the retail domain.

---

##  Project Structure

### 1. Database Setup

```sql
CREATE DATABASE sql_project_p1;
USE sql_project_p1;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Cleaning & Exploration

- Check for null values across all columns
- Count total and unique customer records
- Explore category distribution

### 3. Business Problem Solving

#### Key Queries Included:

1. Sales on a specific date (`2022-11-05`)
2. High-quantity clothing sales in Nov-2022
3. Total sales and order count per category
4. Average age of customers in the 'Beauty' category
5. High-value transactions (total_sale > 1000)
6. Transactions by gender and category
7. Monthly average sales and best months using window functions
8. Top 5 customers based on total spending
9. Unique customer count per category
10. Shift-based order classification (Morning, Afternoon, Evening)

```sql
-- Example: Best-selling month per year
SELECT 
    year,
    month,
    Average_sales
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS Average_sales,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS sales_rank
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS ranked_months
WHERE sales_rank = 1;
```

---

## Key Insights

- **Top Categories**: Identified categories driving most sales.
- **Customer Insights**: Found the most loyal and high-spending customers.
- **Seasonal Trends**: Monthly analysis highlighted peak sales periods.
- **Shift Patterns**: Sales are distributed in the morning, afternoon, and evening.

---

##  Tech Stack

- **Language**: SQL (MySQL)
- **Environment**: MySQL Workbench 
- **Techniques Used**: CTEs, Aggregations, Window Functions, Filtering

---

##  Author

Rajath S  
PGDM - Business Analytics  
Nitte School of Management, Bangalore

---



