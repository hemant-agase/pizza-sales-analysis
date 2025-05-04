# PIZZA SALES ANALYSIS

create schema pizza_sales;
# import table .csv
# select defalut db 
USE pizza_sales;
#show table 
select * from pizza_sales;

# prepare Problem statements
# KPIs
# 1.calculate total revenue 
select sum(total_price) as Total_Revenue  from pizza_sales;
###(Total_Revenue = 817860.049999

# 2.calculate Average Order Value
select (sum(total_price)/ count(distinct order_id )) as Average_Order_Value  from pizza_sales;
###(Average Order Value = 38.307262295081635)

# 3.calculate Total Pizzas Sold
select sum(quantity) as Total_Pizzas_Sold  from pizza_sales;
###(Total Pizzas Sold = 49574 )

# 4.calculate Total orders 
select count(distinct order_id) as Total_Orders from pizza_sales;
###(Total_Orders = 21350 )

# 5.calculate average pizza per order
select 
round(sum(quantity)/count(distinct order_id),2) as Avg_PizzaPerOrder 
from pizza_sales;
###(average pizza per order = 2.32)

select version(); # (8.0.41)

# CHARTS 
# 1. Daily trend by total orders
 
describe pizza_sales;         # date as text format so that can be change datatype 

 
 SELECT DISTINCT order_date FROM pizza_sales LIMIT 10; # cheak date format its return 01-01-2015 ddmmyyyy 
														# so it can change standard format string to date 
                                                        
select 
dayname(str_to_date(order_date, '%d-%m-%y' )) as order_day,
count(distinct order_id) as total_order 
from pizza_sales
group by dayname(str_to_date(order_date, '%d-%m-%y' ));
# output 
-- Friday	3463
-- Monday	2836
-- Saturday	3053
-- Sunday	2633
-- Thursday	3292
-- Tuesday	2963
-- Wednesday	3110 

# 2. monthly trend for total orders

select 
monthname(str_to_date(order_date, '%d-%m-%y')) as order_month,
count(distinct order_id) as total_orders
from pizza_sales
group by monthname(str_to_date(order_date, '%d-%m-%y'))
order by count(distinct order_id) desc;
##output 
-- July			1935
-- May			1853
-- January		1845
-- August		1841
-- March		1840
-- April		1799
-- November		1792
-- June			1773
-- February		1685
-- December		1680
-- September	1661
-- October		1646

# 3. % of sales by pizza category 
select 
pizza_category,
round(sum(total_price),2) as total_sales,
round(sum(total_price)*100/(select sum(total_price) from pizza_sales),2) as per_of_sales
from pizza_sales
group by pizza_category;
## uotput 
-- Classic	220053.1	26.91
-- Veggie	193690.45	23.68
-- Supreme	208197		25.46
-- Chicken	195919.5	23.96

# 4. % of sales by pizza size 
select 
pizza_size,
round(sum(total_price),2) As total_sales,
round(sum(total_price)*100/(select sum(total_price) from pizza_sales ),2) As per_of_sales
from pizza_sales
group by pizza_size
order by  per_of_sales desc;
## output 
-- L	375318.7	45.89
-- M	249382.25	30.49
-- S	178076.5	21.77
-- XL	14076		1.72
-- XXL	1006.6		0.12

# 5. total pizza sold by pizza category 
select
pizza_category,
sum(quantity) As total_pizza_sold 
from pizza_sales
group by pizza_category;
## Output 
-- Classic	14888
-- Veggie	11649
-- Supreme	11987
-- Chicken	11050

# 6. Top 5 Pizzas by Revenue
select 
pizza_name,
sum(total_price)
from pizza_sales
group by pizza_name 
order by sum(total_price) desc limit 5;
## output 
-- The Thai Chicken Pizza			43434.25
-- The Barbecue Chicken Pizza		42768
-- The California Chicken Pizza		41409.5
-- The Classic Deluxe Pizza			38180.5
-- The Spicy Italian Pizza	3		4831.25

# 6. bottom 5 Pizzas by Revenue
select pizza_name,
sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by sum(total_price) asc limit 5;
## output
-- the Brie Carre Pizza				11588.4999999999
-- The Green Garden Pizza			13955.75
-- The Spinach Supreme Pizza		15277.75
-- The Mediterranean Pizza			15360.5
-- The Spinach Pesto Pizza			15596

# Top 5 Pizzas by Quantity
select pizza_name,
sum(quantity) as total_quantity 
from pizza_sales
group by pizza_name
order by sum(quantity) desc limit 5;
## output
-- The Classic Deluxe Pizza		2453
-- The Barbecue Chicken Pizza	2432
-- The Hawaiian Pizza			2422
-- The Pepperoni Pizza			2418
-- The Thai Chicken Pizza		2371

# Bottom 5 Pizzas by Quantity
select pizza_name,
sum(quantity) as total_quantity 
from pizza_sales
group by pizza_name
order by sum(quantity) asc limit 5;
## output
-- The Brie Carre Pizza			490
-- The Mediterranean Pizza		934
-- The Calabrese Pizza			937
-- The Spinach Supreme Pizza	950
-- The Soppressata Pizza		961

# Top 5 Pizzas by Total Orders
select pizza_name,
count(distinct order_id) as total_order
from pizza_sales
group by pizza_name
order by sum(quantity) desc limit 5;
## output
-- The Classic Deluxe Pizza		2329
-- The Barbecue Chicken Pizza	2273
-- The Hawaiian Pizza			2280
-- The Pepperoni Pizza			2278
-- The Thai Chicken Pizza		2225

# Bottom 5 Pizzas by Total Orders
select pizza_name,
count(distinct order_id) as total_order
from pizza_sales
group by pizza_name
order by sum(quantity) asc limit 5;
## output
-- The Brie Carre Pizza		480
-- The Mediterranean Pizza		912
-- The Calabrese Pizza			918
-- The Spinach Supreme Pizza	918
-- The Soppressata Pizza		941

# connect sql server to PBI 


