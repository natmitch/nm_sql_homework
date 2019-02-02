use sakila;

#1a
#select first_name, last_name
#from actor;

#1b
#select concat(first_name, " ", last_name) as "Actor Name"
#from actor;

#2a
#select actor_id
#from actor
#where first_name like '%joe%';

#2b
#select *
#from actor
#where last_name like '%gen%';

#2c
#select *
#from actor
#where last_name like '%li%'
#order by last_name, first_name;

#2d
#select country_id, country
#from country
#where country in ('Afghanistan', 'Bangladesh', 'China');

#3a
#alter table actor
#	add Description blob(100);

#3b
#alter table actor
#	drop column description;

#4a
#select last_name, count(last_name)
#from actor
#group by last_name

#4b
#select last_name, count(last_name)
#from actor
#group by last_name
#having count(last_name)>1;

#4c
#update actor
#set first_name = 'HARPO'
#where first_name = 'groucho' and last_name = 'williams';

#4d
#update actor
#set first_name = 'GROUCHO'
#where first_name = 'harpo' and last_name = 'williams';

#5a
#show create table address;

#6a
#select staff.first_name, staff.last_name, address.address
#from staff
#join address on address.address_id=staff.address_id;

#6b
#select staff.first_name, staff.last_name, sum(payment.amount)
#from staff
#join payment on payment.staff_id=staff.staff_id
#where month(payment.payment_date)=08 and year(payment.payment_date)=2005
#group by staff.staff_id;

#6c
#select film.title, count(film_actor.actor_id)
#from film
#inner join film_actor on film_actor.film_id=film.film_id
#group by film.title;

#6d
#select film.title, count(film.title)
#from film
#inner join inventory on inventory.film_ID=film.film_id
#where film.title='Hunchback Impossible';

#6e
#select customer.first_name, customer.last_name, sum(payment.amount) as 'Total Amount Paid'
#from customer
#join payment on payment.customer_id=customer.customer_id
#group by customer.last_name
#order by customer.last_name;

#7a
#select title
#from film
#where language_id in (select language.language_id
#from language
#inner join film on film.language_id=language.language_id
#where language.name='English') and (substring(title, 1, 1)="Q" or substring(title,1,1)="K");

#7b
#select first_name, last_name
#from actor
#where actor_id in (select actor_id
#from film_actor where film_id = (select film_id
#from film
#where film.title='alone trip'));

#7c
#select first_name, last_name, email
#from customer
#where address_id in (select address_id
#from address
#where address_id in (select address_id
#from city 
#where city_id in (select city_id
#from city
#where country_id in (select country_id
#from country
#where country.country='canada'))));

#7d
#select title
#from film
#where film_id in (select film_id
#from film_category
#where category_id in (select category_id
#from category
#where category.name='family'));

#7e
#select title, count(rental.rental_date)
#from film
#join inventory on film.film_id=inventory.film_id
#join rental on inventory.inventory_id=rental.inventory_id
#group by film.title
#order by count(rental.rental_date) asc;
#select sum(amount) from payment

#7f-wrong

#select sum(amount) as 'Business Dollars', store.store_id
#from payment
#join customer on (payment.customer_id=customer.customer_id)
#join store on (store.store_id=customer.customer_id)
#group by store.store_id;

#7f-correct
#payment.amount>rental.rental_id>inventory.inventory_id>store.store_id

#select s.store_id, sum(amount) as 'business dollars'
#from payment p
#inner join rental r
#on (p.rental_id=r.rental_id)
#inner join inventory i
#on (i.inventory_id=r.inventory_id)
#inner join store s
#on (s.store_id=i.store_id)
#group by 1

#7g
#select store_id, city, country
#from store
#join address on store.address_id=address.address_id
#join city on address.city_id=city.city_id
#join country on city.country_id=country.country_id;

#7h. List the top five genres in gross revenue in descending order. 
#(Hint: you may need to use the following tables: category, film_category, 
#inventory, payment, and rental.)

#payment.rental_id=rental.rental_id
#inventory.inventory_id=rental.inventory_id
#inventory.film_id=film_category.film_id
#film_category.category_id=category.category_id

#SELECT `name` FROM `sakila`.`category`;


#select sum(payment.amount) as 'Gross Revenue', c.name as 'Genre'
#from payment
#join rental r on (payment.rental_id=r.rental_id)
#join inventory i on (r.rental_id=i.inventory_id)
#join film_category fc on (i.film_id=fc.film_id)
#join category c on (fc.category_id=c.category_id)
#group by 2
#order by 1 desc;

#8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. 
#Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.

#CREATE VIEW `Top_5_Gross_Revenue` AS
#select sum(payment.amount) as 'Gross Revenue', c.name as 'Genre'
#from payment
#join rental r on (payment.rental_id=r.rental_id)
#join inventory i on (r.rental_id=i.inventory_id)
#join film_category fc on (i.film_id=fc.film_id)
#join category c on (fc.category_id=c.category_id)
#group by 2
#order by 1 desc
#limit 5;

#8b 
#select * from sakila.top_5_gross_revenue;

#8c
drop view sakila.top_5_gross_revenue;