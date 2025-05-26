SELECT * FROM project.pizza;

          #Customer prefernce
#1. Top 5 most ordered pizza types and sizes
select pizza_type,
pizza_size,
count(*) as order_count
from pizza
group by Pizza_Type, Pizza_Size
order by order_count desc
Limit 5;

#2. customer preference on weekends
Select*
from
(
select Is_weekend, 
pizza_type,
count(*) as order_count
from pizza
group by Is_weekend, pizza_type
order by Is_weekend, order_count desc
) as temp
where Is_weekend= 1;

#3. Top pizza type per location
select*
from
(
select Location,
pizza_type,
count(*) as order_count,
rank() over (partition by location order by count(*) desc) as pizza_rnk
from pizza
group by location, Pizza_Type
order by order_count desc
) ranked
where pizza_rnk=1;

#4. Toppings count vs Pizza Type and size
select Pizza_type,
Pizza_size,
avg(Toppings_count) as avg_topping
from pizza
group by Pizza_Type, Pizza_Size
order by avg_topping desc;

#5. Most buy locations during peak hour
select*
from
(
select location,
peak_hour,
count(*) as order_count
from pizza
group by location , Peak_Hour
order by order_count desc
) as p
where peak_hour=1
limit 5;

   #Delivery Improvement 
#6. restaurant with the highest avergae delay
select Restaurant_name,
avg(delay_min) as avg_delay
from pizza
group by Restaurant_Name 
order by avg_delay desc;

#7. traffic level imapact on delivery time

select traffic_level,
avg(Delivery_duration_min) as avg_duration
from pizza
group by traffic_level
order by avg_duration desc;

#8. average delivery time by distance buckets

select
   case
     when(distance_km)<2 then "0-2 km"
     when(distance_km) between 2 and 5 then "2-5 km"
     else "5+ km"
   end as distance_range,
   avg(delivery_duration_min) as avg_duration_min
   from pizza
   group by distance_range;

#9. Delivery time variation on peak vs non-peak hours 

select peak_hour,
avg(delivery_duration_min) as avg_duration
from pizza
group by Peak_Hour;

#10. Factors leading to delivery delays

select traffic_level,
distance_km,
pizza_complexity,
count(*) as delay_count
from pizza
group by Traffic_Level, Distance_km, Pizza_Complexity
order by delay_count desc
limit 10;
