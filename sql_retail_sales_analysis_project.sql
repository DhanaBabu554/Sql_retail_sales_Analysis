create database sql_retail_sales_analysis;

use sql_retail_sales_analysis;

create table sales(
transaction_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(10),
age int,
category varchar(20),
quantity int,
price_per_unit int,
cogs int,
total_sales int
);

select * from sales
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or 
cogs is null
or
total_sale is null;

select * from sales;

select  * from sales 
limit 10;
# Data Exploration

# how many sales you have
select count(*) from sales;

# how many unique customers you have
select  count(distinct customer_id) as numberofcustomers 
from sales;

# how many Distinct category 
select distinct category from sales;

# Data Analysis & Business problems

# 1.write a sql query to retrieve all columns for sales made on '2022-11-05'

select * from sales 
where 
sale_date='2022-11-05';

# 2.write a sql query to retrieve all transcations where category is 'clothing' and the quantity sold is more than 4
#the month of nov-2022

select*
from sales
where category='clothing'
and
year(sale_date)='2022'
and
month(sale_date)='11'
and
quantiy>=3;

# 3.write a sql query to calculate the total sales for each category
select  
category,
sum(total_sale)  as total_sale,
count(*) as total_orders
from sales 
group by category;

# write a sql query To find the average age customers who purchased items from the 'Beauty' category

select
round(avg(age),2) as average_age
from sales
where 
category='beauty';

# 5.write a sql query  to find all transactions where the total sale is greater than 1000

select * from sales 
where
total_sale> 1000;

# 6.write a sql query find the total number of transactions made each gender and each category

select 
gender,
category ,
count(transactions_id) as total_transactions from sales
group by 
gender,
category
order by gender;

# 7.write a sql query to calculate the avg sale for each month. Find out best selling month in each year
select 
years,
months,
average_sale
 from
(select
    year(sale_date) as years,
    month(sale_date) as months,
    avg(total_sale) as average_sale,
    rank() over(partition by year(sale_date) order by avg(total_sale)) as ranks
from sales
group by years,months
) as t1
 where ranks=1;

#8. write sql query to find the top 5 customers based on the highest total sales

select 
customer_id,
sum(total_sale)  as total_sale
from sales
group by customer_id
order by total_sale desc
limit 5;

# 9. write a sql query to find the number of unique customers who purchased items  from each category

select
category,
count( distinct customer_id) as total_unique_costomers
from sales
group by category;

# 10.write a sql query to create each shift and number of orders (example morning <=12,afternoon <=17,evening)

with hours_shitf
as
(select *,
      case
          when hour(sale_time) <12 then "Morning"
          when  hour(sale_time) between 12 and 17 then "Afternoon"
          else "evening"
      end as shift    
from sales)
select shift,
count(transactions_id) from hours_shitf
group by shift;

select * from sales;











