USE sakila;
-- How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT COUNT(title) AS available_copies
FROM inventory i
JOIN film f
ON i.film_id = f.film_id
WHERE title = 'Hunchback Impossible';

-- List all films whose length is longer than the average of all the films.
SELECT title
FROM film
WHERE length > ( SELECT AVG(length)
                 FROM film
	             );

-- Use subqueries to display all actors who appear in the film Alone Trip.
SELECT f.title, a.first_name, a.last_name
FROM film_actor fa
JOIN film f 
ON fa.film_id = f.film_id
JOIN actor a 
ON fa.actor_id = a.actor_id
WHERE title = 'Alone Trip';

SELECT *
FROM (SELECT f.title, a.first_name, a.last_name
      FROM film_actor fa
      JOIN film f 
      ON fa.film_id = f.film_id
      JOIN actor a 
      ON fa.actor_id = a.actor_id) AS f_act
WHERE title = 'Alone Trip';

# Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify 
# all movies categorized as family 
SELECT *
FROM category;

SELECT *
FROM (SELECT f.title AS film_title, c.name AS category_name
      FROM film_category fc
      JOIN film f 
      ON fc.film_id = f.film_id
      JOIN category c 
      ON fc.category_id = c.category_id) AS f_cat
WHERE category_name = 'family';

# Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, 
# you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the 
# relevant information.
SELECT *
FROM (SELECT cu.first_name, cu.last_name, cu.email, co.country
      FROM customer cu
	  Join address a 
	  ON cu.address_id = a.address_id
	  jOIN city ci 
	  ON a.city_id = ci.city_id
	  JOIN country co 
	  ON ci.country_id = co.country_id) AS customer_info
where country = 'Canada';

-- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in
-- the most number of films. First you will have to find the most prolific actor and then use that actor_id to find
-- the different films that he/she starred.
SELECT  a.first_name, a.last_name, a.actor_id, COUNT(*) AS film_count 
      FROM film_actor fa
      JOIN actor a 
      ON fa.actor_id = a.actor_id
      GROUP BY a.first_name, a.last_name, a.actor_id
      ORDER BY film_count DESC
      LIMIT 1;
      
SELECT f.title prol_actor
FROM film f
JOIN (SELECT  a.first_name, a.last_name, a.actor_id, COUNT(*) AS film_count 
      FROM film_actor fa
      JOIN actor a 
      ON fa.actor_id = a.actor_id
      GROUP BY a.first_name, a.last_name, a.actor_id
      ORDER BY film_count DESC
      LIMIT 1)  prol_actor
ON f.film_id = prol_actor.film_id;

SELECT f.title 
FROM film_actor fc
JOIN film f
ON fc.film_id = f.film_id
WHERE actor_id = (SELECT  a.first_name, a.last_name, a.actor_id, COUNT(*) AS film_count 
                  FROM film_actor fa
                  JOIN actor a 
				  ON fa.actor_id = a.actor_id
				  GROUP BY a.first_name, a.last_name, a.actor_id
                  ORDER BY film_count DESC
                  LIMIT 1);
                  
-- Films rented by most profitable customer. You can use the customer table and payment table to find the most
--  profitable customer ie the customer that has made the largest sum of payments

SELECT  c.first_name, c.last_name, p.amount, COUNT(*) AS most_prof 
FROM payment p
JOIN customer c 
ON p.customer_id = c.customer_id
GROUP BY c.first_name, c.last_name, p.amount
ORDER BY most_prof DESC
LIMIT 1;
 
 -- Customers who spent more than the average payments
SELECT AVG(amount)
FROM payment;

SELECT c.first_name, c.last_name, p.amount
FROM payment p
JOIN customer c 
ON p.customer_id = c.customer_id
#GROUP BY c.first_name, c.last_name, p.amount
WHERE amount > ( SELECT AVG(amount)
                 FROM payment
	             );
                 