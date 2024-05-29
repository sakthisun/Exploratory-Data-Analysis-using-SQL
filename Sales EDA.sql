-- Sale analysis
-- Total orders of the company

select count(order_id) as Total_orders
from sales;

-- Total Revenue of the company

Select round(sum(s.product_quantity * p.product_price), 2) as Total_Revenue
from sales s
left join product p on s.product_id = p.product_id;


-- Revenue distribution by Year

Select year(s.order_date) as Year, round(sum(s.product_quantity * p.product_price), 2) as Revenue
from sales s
left join product p on s.product_id = p.product_id
group by year(s.order_date);

-- Revenue distribution by month

Select monthname(s.order_date) as Month, round(sum(s.product_quantity * p.product_price), 2) as Revenue
from sales s
left join product p on s.product_id = p.product_id
group by monthname(s.order_date);


-- Revenue distribution by quarter

with cte as
(Select  case 
		when month(s.order_date) between 1 and 3 then '1st Quarter'
        when month(s.order_date) between 4 and 6 then '2nd Quarter'
        when month(s.order_date) between 7 and 9 then '3rd Quarter'
        when month(s.order_date) between 10 and 12 then '4th Quarter' end as Quarter_description , 
        s.order_date as Order_date, 
        p.product_name as Item,
        s.product_quantity as Quantity,
        p.product_price as price,
        (s.product_quantity * p.product_price) as Invoice
from sales s
left join product p on s.product_id = p.product_id)

select quarter_description, round(sum(Invoice)) as Revenue
from cte
group by quarter_description;


-- Maximum order value

select Max((s.product_quantity * p.product_price)) as Order_value
from sales s 
join product p on s.product_id =  p.product_id;

-- Product analysis
-- Total number of products available

select count(distinct product_name) As Product_count
from product;

-- Top 5 expensive products

Select distinct product_name, product_price
from product
order by product_price desc
limit 5;

-- Top 5 products by revenue

with cte_product as
(Select s.product_id, p.product_name, s.product_quantity * p.product_price as Invoice
from sales s 
join product p on s.product_id = s.product_id)

select product_name, count(Product_name) as Order_qty, Round(sum(Invoice), 2) as Revenue
from cte_product
group by product_name
order by revenue desc
limit 5;


-- customer analysis
-- Total number of customers

select distinct count(cust_id) as Total_customers
from customer;

-- Total customer by age category

with cte_age as
(select cust_id, cust_age,
case 
	when cust_age between 10 and 18 then 'Teen'
    when cust_age between 19 and 40 then 'Young'
    else  'old'
    end as age_group
from customer)

select age_group, count(age_group)
from cte_age
group by age_group;


















