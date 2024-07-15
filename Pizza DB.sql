CREATE TABLE pizza_sales_staging (
    pizza_id int,
	order_id int,
	pizza_name_id varchar(50),
	quantity smallint,
	order_date TEXT,
    order_time time,
	unit_price float,
	total_price float,
	pizza_size varchar(50),
	pizza_category varchar(50),
	pizza_ingredients varchar(200),
	pizza_name varchar(50)
);

select * from pizza_sales_staging


--Key Performance Indicators

--Calculate the Total Revenue

Select sum(total_price) as Total_Revenue from pizza_sales_staging

--Find the Average order Value

Select (sum(total_price)/count(Distinct order_id)) as Average_Order_Value from pizza_sales_staging

--Find the total pizza sold
	
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales_staging

--find the total orders

SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales_staging

--find the Average Pizzas Per Order

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Average_Pizzas_per_order
FROM pizza_sales_staging

--Daily Trends and Monthly Trends For Total Orders

SELECT 
    TO_CHAR(to_date(order_date, 'DD-MM-YYYY'), 'Day') AS order_day, 
    COUNT(DISTINCT order_id) AS order_count,
    EXTRACT(DOW FROM to_date(order_date, 'DD-MM-YYYY')) AS weekday_num
FROM 
    pizza_sales_staging
GROUP BY 
    TO_CHAR(to_date(order_date, 'DD-MM-YYYY'), 'Day'), 
    EXTRACT(DOW FROM to_date(order_date, 'DD-MM-YYYY'))
ORDER BY 
    weekday_num;

--Monthly Trends


SELECT 
    TO_CHAR(to_date(order_date, 'DD-MM-YYYY'), 'Month') AS order_month, 
    COUNT(DISTINCT order_id) AS order_count,
    EXTRACT(MONTH FROM to_date(order_date, 'DD-MM-YYYY')) AS month_num
FROM 
    pizza_sales_staging
GROUP BY 
    TO_CHAR(to_date(order_date, 'DD-MM-YYYY'), 'Month'), 
    EXTRACT(MONTH FROM to_date(order_date, 'DD-MM-YYYY'))

--Find the percentage of sales by pizza category

SELECT pizza_category,CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales_staging) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales_staging
GROUP BY pizza_category
ORDER BY total_revenue DESC

--Find the percentage of sales by pizza size

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) from pizza_sales_staging) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales_staging
GROUP BY pizza_size
ORDER BY pizza_size

-- Find the Top 5 Pizzas by Revenue

SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales_staging
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5

--Find the  Bottom 5 Pizzas by Revenue

SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales_staging
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5

--Find the  Top 5 Pizzas by Quantity

SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales_staging
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5

--Find the bottom 5 pizzas by Quantity

SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales_staging
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5

--find the Top 5 Pizzas by Total Orders

SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales_staging
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5

--find the bottom 5 Pizzas by Total Orders

SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales_staging
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5




--Total Pizza Sold by Pizza Category










