USE Pizza_Store;
SELECT * FROM pizza_sales;

ALTER TABLE pizza_sales 
ALTER COLUMN order_time TIME;

SELECT * FROM pizza_sales;

-- Total Revenue of Pizza Store 

SELECT ROUND(SUM(total_price),2) AS Total_Revenue 
    FROM pizza_sales;
    
-- Average Order Value 

SELECT 
    ROUND(SUM(total_price) / COUNT(DISTINCT order_id), 2) AS Average_Order_Value
    FROM pizza_sales;

-- Total Pizza sold 

SELECT 
    SUM(quantity) AS Total_pizza 
    FROM pizza_sales;

-- Total number of order placed 

SELECT 
    COUNT(DISTINCT order_id) AS Total_Order_Number
    FROM pizza_sales;

-- Average Pizza per order 

SELECT 
    CAST(SUM(quantity) AS DECIMAL(10,2)) /
    CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))
     AS Avg_pizza_Order
    FROM pizza_sales;

-- Daily Trend for total orders

SELECT DATENAME(DW, order_date) AS Order_day,
    COUNT(DISTINCT order_id) AS Total_Orders
    FROM pizza_sales
    GROUP BY DATENAME(DW, order_date)
    ORDER BY Total_Orders DESC;

-- Monthly trend for total order 

SELECT DATENAME(MONTH,order_date) AS Month,
    COUNT(DISTINCT order_id) AS Total_order
    FROM pizza_sales
    GROUP BY DATENAME(MONTH,order_date)
    ORDER BY Total_order DESC;

-- Percentage of sales by pizza category

SELECT * FROM pizza_sales;

SELECT 
    pizza_category,
    (SUM(total_price)) 
    FROM pizza_sales
    GROUP BY pizza_category;
SELECT 
    pizza_category,
    ROUND(CAST((SUM(total_price)*100) AS DECIMAL(10,2)) 
    / CAST((SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2) ),2) AS PCT
    FROM pizza_sales
    GROUP BY pizza_category;

-- Percentage of sales by pizza size

-- SELECT 
--     pizza_size, 
--     ROUND(SUM(total_price),2) AS Total_sales,
--     ROUND(CAST((SUM(total_price)*100) AS DECIMAL(10,2)) 
--     / CAST((SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2) ),2) AS PCT
--     FROM pizza_sales
--     GROUP BY pizza_size;

SELECT 
    pizza_size, 
    ROUND(SUM(total_price),2) AS Total_sales,
    ROUND((SUM(total_price)*100)
    / (SELECT SUM(total_price) FROM pizza_sales),2) AS PCT
    FROM pizza_sales
    GROUP BY pizza_size;

-- Top 5 Best Seller By Revenue, Total Qunantity, and Total Order 

SELECT * FROM pizza_sales;
-- By revenue 
SELECT  pizza_name,
    SUM(total_price) As Total_sales
    FROM pizza_sales
    GROUP BY pizza_name
    ORDER BY Total_sales DESC;

SELECT TOP(5) pizza_name,
    SUM(total_price) As Total_sales
    FROM pizza_sales
    GROUP BY pizza_name
    ORDER BY Total_sales DESC;

-- by quantity
SELECT TOP(5) pizza_name,
    SUM(quantity) AS Total_quantity
    -- SUM(total_price) As Total_sales
    FROM pizza_sales
    GROUP BY pizza_name
    ORDER BY Total_quantity DESC;

SELECT  Top(5) pizza_name,
    SUM(quantity) AS Total_quantity,
    SUM(total_price) As Total_sales
    FROM pizza_sales
    GROUP BY pizza_name
    ORDER BY Total_quantity DESC,Total_sales DESC;

-- By Order 
SELECT  Top(5) pizza_name,
    COUNT(DISTINCT order_id) AS Total_order,
    SUM(quantity) AS Total_quantity,
    SUM(total_price) As Total_sales
    FROM pizza_sales
    GROUP BY pizza_name
    ORDER BY Total_order DESC;
