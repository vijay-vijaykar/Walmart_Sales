-- create the table --
-- TIME_OF_DATE
SELECT time,
	  (CASE 
		    WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
			WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
			ELSE "Evening"
			END
	) as time_of_date
    FROM sales;
-- ----------------------------------------------------------------------------------------------------------------

SELECT * FROM sales;
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR (20) ;

UPDATE sales
SET time_of_day=
(CASE 
		    WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
			WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
			ELSE "Evening"
			END
); 
-- -------------------------------------------------------------------
-- DAY NAME

SELECT 
date,
DAYNAME(date) AS day_name
FROM sales;

ALTER TABLE sales
ADD COLUMN day_name VARCHAR(10);

UPDATE sales
SET day_name=DAYNAME(date);

-- month_name
SELECT date,MONTHNAME(date)
FROM sales;

ALTER TABLE sales ADD column month_name VARCHAR(10);

UPDATE sales
SET month_name = MONTHNAME(date);

--  ------------------------------------------------------------------

-- EDA to ans the listed questions --
-- generic questions --
--   ----------------------------------------------------
-- how many unique cities does the data have?
Select distinct(city)
from sales;
--  -----------------------------------------
-- in which city is each branch?

select distinct city,branch
from sales;
-- ------------------
--   product ---------------------------
-- how many unique product lines does the data have?
select count(distinct (product_line))
from sales;

--   What is the most common payment method?
select payment_method,count(payment_method) as cnt
from sales
group by payment_method
order by cnt desc;
-- --------------------------------------

-- What is the most selling product line? 
select product_line,count(product_line)as cnt
from sales
group by product_line
order by cnt desc
;
-- -------------------------------
-- What is the total revenue by month?
select month_name as month,sum(total) as total_revenue
from sales
group by month
order by total_revenue desc;
-- ------------------------------------
-- What month had the largest COGS?
select month_name,sum(cogs) as cogs_cnt
from sales
group by month_name
order by cogs_cnt desc;
--  ---------------------------------
-- What product line had the largest revenue?
select product_line,sum(total) as total_revenue
from sales
group by product_line
order by total_revenue desc;
-- -----------------------------------------------
-- What is the city with the largest revenue?
select city,branch,sum(total) as total_revenue
from sales
group by city,branch
order by total_revenue desc;

-- --------------------------------------------------
-- ------------------------------------------------------------------------------
-- Which branch sold more products than average product sold?--
Select branch,sum(quantity) as qty
from sales
group by branch
having qty > (select avg(quantity) from sales);
-- -------------------------
-- What is the most common product line by gender?
select gender,product_line,count(gender) as total_cnt
from sales
group by gender,product_line
order by total_cnt desc;
-- -------------------------------------------------------------------------
-- What is the average rating of each product line?
select product_line,round(avg(rating), 2) as avg_rating
from sales
group by product_line
order by avg_rating desc;
-- What product line had the largest VAT?
select product_line,avg(VAT) as avg_tax
from sales
group by product_line
order by avg_tax desc;

-- ----------------------------------------
-- Fetch each product line and add a column to those product line showing "Good", "Bad". 
-- Good if its greater than average sales

-- ---------------------------------------------------------------------------------------

-- sales questions------------------
-- 1. Number of sales made in each time of the day per weekday-----------

select time_of_day,count(*) as total_sales
from sales
where day_name='monday'
group by time_of_day
order by total_sales desc;

-- 2. Which of the customer types brings the most revenue?-------------
select customer_type,sum(total) as total_revenue
from sales
group by customer_type
order by total_revenue desc;

-- 3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?
select city,avg(VAT) as tax
from sales
group by city
order by tax desc;

-- 4. Which customer type pays the most in VAT?
select customer_type,avg(vat) as vat 
from sales
group by customer_type
order by vat desc;

-- ------------------------------------------------------------------------------------
-- customers questions------------------------

-- 1-How many unique customer types does the data have?
select distinct (customer_type)
from sales;

-- 2. How many unique payment methods does the data have?

-- 3. What is the most common customer type?
select customer_type,count(customer_type) as cnt
from sales
group by customer_type
order by cnt desc;

-- Which customer type buys the most?
select customer_type,count(*) as customer_count
from sales
group by customer_type
order by customer_count;

-- 5. What is the gender of most of the customers?
select gender,count(*) as gender_count
from sales
group by gender
order by gender_count desc;

-- 6. What is the gender distribution per branch?
select gender,count(*) as gender_count
from sales
where branch='a'
group by gender
order by gender_count desc;

select gender,count(*) as gender_count
from sales
where branch='b'
group by gender
order by gender_count desc;

select gender,count(*) as gender_count
from sales
where branch='c'
group by gender
order by gender_count desc;
--  question 6 answer --------------------------
select branch,gender,count(*) as gender_count
from sales
group by branch,gender
order by branch,gender;

-- 7. Which time of the day do customers give most ratings?
select time_of_day,avg(rating) as ratings
from sales
group by time_of_day
order by ratings desc;

-- 8. Which time of the day do customers give most ratings per branch
select branch,time_of_day,avg(rating) as ratings
from sales
group by branch,time_of_day
order by branch,ratings desc;

-- 9. Which day of the week has the best avg ratings?
select day_name,avg(rating) as ratings
from sales
group by day_name
order by ratings desc;

-- 10. Which day of the week has the best average ratings per branch?
select branch,day_name,avg(rating) as ratings
from sales
group by branch,day_name
order by branch,day_name,ratings desc;

--        END OF THE PROJECT-------------










