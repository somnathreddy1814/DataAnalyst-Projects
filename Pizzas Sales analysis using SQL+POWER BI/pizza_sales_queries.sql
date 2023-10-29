use [Pizza DB]
go

select * from pizza_sales;
---KPI's
---Total Revenue
select sum(total_price) as Total_Revenue from pizza_sales; 
--Average Order Value
select sum(total_price)/count(distinct(order_id)) as Average_Order_value from pizza_sales;
--Total pizzas sold
select sum(quantity) as Total_pizzas_sold from pizza_sales;
--Total Orders placed
select count(distinct(order_id)) as Orders_placed from pizza_sales;
--Average no of pizzas per order
select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct(order_id)) as decimal(10,2)) as decimal(10,2))as Average_pizzas_per_order from pizza_sales;





--Queries for charts
--Daily Trend of total orders
select DATENAME(DW,order_date) as order_day ,count(distinct(order_id)) as Total_orders from pizza_sales
group by datename(dw,order_date);
--Monthly Trend of total orders
select DATENAME(MONTH,order_date) as order_month ,count(distinct(order_id)) as Total_orders from pizza_sales
group by datename(MONTH,order_date)
order by Total_orders desc;


--percentage of sales by pizza category
select pizza_category,sum(total_price) as Total_price,sum(total_price)*100/(select sum(total_price) from pizza_sales) as percentage_of_sales
from pizza_sales 
--where month(order_date)=5
group by pizza_category;

--percentage of sales by pizza size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
--where DATEPART(quarter,order_date)=1
GROUP BY pizza_size
ORDER BY pizza_size

--total sales by pizza category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
--WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

--top 5 pizzas by revenue
select top 5 pizza_name,sum(total_price) as tot_revenue from pizza_sales
--where month(order_date)=3
group by pizza_name
order by tot_revenue desc;

--bottom 5 pizzas by revenue
select top 5 pizza_name,cast(sum(total_price) as decimal(10,2)) as tot_revenue from pizza_sales
--where month(order_date)=3
group by pizza_name
order by tot_revenue desc;

--top 5 pizzas by quantity
select top 5 pizza_name,sum(quantity) as no_of_pizzas_ordered from pizza_sales
group by pizza_name
order by no_of_pizzas_ordered desc;

--bottom 5 pizzas by quantity
select top 5 pizza_name,sum(quantity) as no_of_pizzas_ordered from pizza_sales
group by pizza_name
order by no_of_pizzas_ordered asc;

--top 5 pizzas by total orders
select top 5 pizza_name,count(distinct(order_id)) as no_of_orders from pizza_sales
group by pizza_name
order by no_of_orders desc;


--bottom 5 pizzas by total orders
select top 5 pizza_name,count(distinct(order_id)) as no_of_orders from pizza_sales
group by pizza_name
order by no_of_orders asc;







