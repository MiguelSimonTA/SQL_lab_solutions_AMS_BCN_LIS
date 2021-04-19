USE sakila;


-- 1. How many films are there for each of the categories in the category table. 
-- Use appropriate join to write this query.
SELECT * FROM category;
SELECT * FROM film_category;

SELECT 
    name AS category_name, COUNT(*) AS num_films
FROM
    sakila.category
        INNER JOIN
    sakila.film_category USING (category_id)
GROUP BY name
ORDER BY num_films DESC;

-- 2. Display the total amount rung up by each staff member in August of 2005.
SELECT * FROM payment;
SELECT MONTH(payment_date) FROM payment;
SELECT * FROM staff;

SELECT 
    s.staff_id,
    CONCAT(s.first_name, ' ', s.last_name) AS employee,
    SUM(p.amount) AS `total amount`
FROM
    sakila.staff AS s
        INNER JOIN
    sakila.payment AS p ON s.staff_id = p.staff_id
WHERE
    MONTH(p.payment_date) = 8
        AND YEAR(p.payment_date) = 2005
GROUP BY s.staff_id;

-- 3. Which actor has appeared in the most films?
SELECT * FROM actor;
SELECT * FROM film_actor;

SELECT 
    actor.actor_id,
    actor.first_name,
    actor.last_name,
    COUNT(actor_id) AS film_count
FROM
    sakila.actor
        JOIN
    sakila.film_actor USING (actor_id)
GROUP BY actor_id
ORDER BY film_count DESC
LIMIT 1;


-- 4. Most active customer (the customer that has rented the most number of films)
SELECT * FROM customer;
SELECT * FROM rental;

SELECT 
    customer.*, COUNT(rental_id) AS rental_count
FROM
    sakila.customer
        JOIN
    sakila.rental USING (customer_id)
GROUP BY customer_id
ORDER BY rental_count DESC
LIMIT 1;

-- 5. Display the first and last names, as well as the address, of each staff member.
SELECT * FROM staff;
SELECT * FROM address;

SELECT 
    staff.first_name, staff.last_name, address.address
FROM
    sakila.address
        INNER JOIN
    sakila.staff ON staff.address_id = address.address_id;

-- 6. List each film and the number of actors who are listed for that film.
SELECT * FROM film;
SELECT * FROM film_actor;

SELECT 
    title AS `film title`, COUNT(actor_id) AS `number of actors`
FROM
    sakila.film
        INNER JOIN
    sakila.film_actor ON film.film_id = film_actor.film_id
GROUP BY film.film_id;


-- 7. Using the tables payment and customer and the JOIN command, list the total paid 
-- by each customer. List the customers alphabetically by last name.
SELECT * FROM payment;
SELECT * FROM customer;

SELECT 
    first_name, last_name, SUM(amount) AS 'total amount paid'
FROM
    sakila.customer
        INNER JOIN
    sakila.payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY last_name;


-- 8. List number of films per category.
SELECT * FROM category;
SELECT * FROM film_category;

SELECT 
    name AS category_name, COUNT(*) AS num_films
FROM
    sakila.category
        INNER JOIN
    sakila.film_category USING (category_id)
GROUP BY name
ORDER BY num_films DESC;


