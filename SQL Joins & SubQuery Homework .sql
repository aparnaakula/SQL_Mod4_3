--Week 5 - Wednesday Questions 
--1. List all customers who live in Texas (use JOINs) 
select first_name, last_name
from customer 
inner join address
on customer.address_id::text= address.address_id::text
where district::text = 'Texas';

--2. Get all payments above $6.99 with the Customer's Full Name
select *
from customer
full join payment 
on customer.customer_id = payment.customer_id 
where amount > 6.99; 

--3. Show all customers names who have made payments over $175(use subqueries) 
select first_name , last_name 
from customer 
where customer_id in (
	select customer_id 
	from payment
	group by customer_id 
	having  sum(amount) > 175
);

--4. List all customers that live in Nepal (use the city table) 
-- My database had wrong data type and column name in customer and address tables. Updated the column name - address_id to address on Customer to match with address table
-- Query--
/* alter table customer
rename column address_id to address */

--The data was missing for this scenario, so added data to my table customer to verify my query
--Query--
/*insert into customer(
customer_id,first_name,last_name, email, address, city, customer_state, zipcode, store_id)
values(10, 'Aparna', 'Akula', 'aa@xx.com','470 Boksburg Street', 'Quicy', 'MO',97960, 2) */

select first_name, last_name
from customer
full join address 
on customer.address = address.address   
inner join city 
on address.city_id = city.city_id 
inner join country 
on city.country_id = country.country_id
where country = 'Nepal'


--5. Which staff member had the most transactions? 
select first_name, last_name, count(payment.staff_id)
from staff 
inner join payment 
on payment.staff_id = staff.staff_id 
group by first_name , last_name
order by count(payment.staff_id) desc

--6. How many movies of each rating are there? 
select rating, count(rating)
from film 
group by rating 
order by count(rating) asc;

--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
select first_name , last_name, amount
from customer 
inner join payment 
on customer.customer_id = payment.customer_id 
where amount in (
	select amount 
	from payment
	group by customer_id , amount
	having  amount > 6.99
);

--8. How many free rentals did our stores give away?
select count(payment_id)
from payment 
where amount < 0.01;







