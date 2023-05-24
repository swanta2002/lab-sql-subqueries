USE sakila;

-- Dropping Columns 

SELECT *
FROM staff;

ALTER TABLE staff
DROP COLUMN picture;

SELECT *
FROM staff;

-- Updating the staff table with a new employee SANDERS
INSERT INTO staff (first_name, last_name, staff_id, email, address_id, store_id, active, username, password, last_update)
VALUES ('TOMMY', 'SANDERS', 3, 'TAMMY.SANDERS@sakilacustomer.org', 79, 2, 1, 'TOMMY', NULL, NOW())
ON DUPLICATE KEY UPDATE
staff_id = 3,
email = 'TAMMY.SANDERS@sakilacustomer.org',
address_id = 79,
store_id = 2,
active = 1,
username = 'TOMMY',
password = NULL,
last_update = Now();

-- updating the rental table
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

select film_id from sakila.film
where title = 'Academy Dinosaur';

SELECT *, inventory_id
FROM inventory i
JOIN film f
ON i.film_id = f.film_id
WHERE title = 'Academy Dinosaur';

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id, last_update)
VALUES (NOW(), 3, 130, 3, NOW())
ON DUPLICATE KEY UPDATE
rental_date = NOW(),
inventory_id = 3, 
customer_id = 130,
staff_id = 3,
last_update = Now();
