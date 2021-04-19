-- 1. Write a query to display for each store its store ID, city, and country.
-- OPTION 1
SELECT * FROM store;
SELECT * FROM address;
SELECT * FROM city;
SELECT * FROM country;

SELECT 
    store_id, city, country
FROM
    sakila.store
        JOIN
    sakila.address USING (address_id)
        JOIN
    sakila.city USING (city_id)
        JOIN
    sakila.country USING (country_id);
    
-- OPTION 2
SELECT 
    store_id, city, country
FROM
    sakila.store
        JOIN
    (sakila.address
    JOIN (sakila.city
    JOIN sakila.country USING (country_id)) USING (city_id)) USING (address_id);
    


-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT * FROM store;
SELECT * FROM customer;
SELECT * FROM payment;
SELECT * FROM rental;

SELECT 
    store.store_id, ROUND(SUM(amount), 2) AS Amount
FROM
    sakila.store
        JOIN
    sakila.customer USING (store_id)
        JOIN
    sakila.payment USING (customer_id)
        JOIN
    sakila.rental USING (rental_id)
GROUP BY store.store_id;
	
-- OPTION 2
SELECT 
    store.store_id, ROUND(SUM(amount), 2)
FROM
    sakila.store
        JOIN
    (sakila.customer
    JOIN (sakila.payment
    JOIN sakila.rental USING (rental_id)) ON customer.customer_id = payment.customer_id) USING (store_id)
GROUP BY store.store_id;

-- 3. Which film categories are longest?
SELECT * FROM film;
SELECT * FROM film_category;
SELECT * FROM category;


SELECT 
    category.name, AVG(length)
FROM
    sakila.film
        JOIN
    sakila.film_category USING (film_id)
        JOIN
    sakila.category USING (category_id)
GROUP BY category.name
ORDER BY AVG(length) DESC;

-- 4. Display the most frequently rented movies in descending order.
SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM rental;

SELECT 
    title, COUNT(*) AS `rental frequency`
FROM
    sakila.film
        JOIN
    sakila.inventory USING (film_id)
        JOIN
    sakila.rental USING (inventory_id)
GROUP BY title
ORDER BY `rental frequency` DESC;

-- OPTION 2
SELECT 
    title, COUNT(*) AS `rental frequency`
FROM
    sakila.film
        JOIN
    (sakila.inventory
    JOIN sakila.rental USING (inventory_id)) USING (film_id)
GROUP BY title
ORDER BY `rental frequency` DESC;

-- 5. List the top five genres in gross revenue in descending order.
SELECT * FROM payment;
SELECT * FROM rental;
SELECT * FROM inventory;
SELECT * FROM film_category;
SELECT * FROM category;

SELECT 
    name, category_id, SUM(amount) AS `gross revenue`
FROM
    sakila.payment
        JOIN
    sakila.rental USING (rental_id)
        JOIN
    sakila.inventory USING (inventory_id)
        JOIN
    sakila.film_category USING (film_id)
        JOIN
    sakila.category USING (category_id)
GROUP BY category_id
ORDER BY `gross revenue` DESC
LIMIT 5;

-- OPTION 2
SELECT 
    name, category_id, SUM(amount) AS `gross revenue`
FROM
    sakila.payment
        JOIN
    (sakila.rental
    JOIN (sakila.inventory
    JOIN (sakila.film_category
    JOIN sakila.category USING (category_id)) USING (film_id)) USING (inventory_id)) USING (rental_id)
GROUP BY category_id
ORDER BY `gross revenue` DESC
LIMIT 5;

-- 6. Is "Academy Dinosaur" available for rent from Store 1?
SELECT * FROM inventory;
SELECT * FROM store;
SELECT * FROM film;

SELECT 
    film.film_id,
    film.title,
    store.store_id,
    inventory.inventory_id
FROM
    sakila.inventory
        JOIN
    sakila.store USING (store_id)
        JOIN
    sakila.film USING (film_id)
WHERE
    film.title = 'Academy Dinosaur'
        AND store.store_id = 1;

-- 7. Get all pairs of actors that worked together.
SELECT * FROM actor;
SELECT * FROM film_actor;

SELECT 
    fa1.film_id,
    CONCAT(a1.first_name, ' ', a1.last_name),
    CONCAT(a2.first_name, ' ', a2.last_name)
FROM
    sakila.actor a1
        INNER JOIN
    film_actor fa1 USING(actor_id)
        INNER JOIN
    film_actor fa2 ON (fa1.film_id = fa2.film_id)
        AND (fa1.actor_id != fa2.actor_id)
        INNER JOIN
    actor a2 ON a2.actor_id = fa2.actor_id;

-- 8. Get all pairs of customers that have rented the same film more than 3 times.
SELECT * FROM customer;
SELECT * FROM rental;
SELECT * FROM inventory;
SELECT * FROM film;

SELECT 
    c1.customer_id, c2.customer_id, COUNT(*) AS num_films
FROM
    sakila.customer c1
        INNER JOIN
    rental r1 ON r1.customer_id = c1.customer_id
        INNER JOIN
    inventory i1 ON r1.inventory_id = i1.inventory_id
        INNER JOIN
    film f1 ON i1.film_id = f1.film_id
        INNER JOIN
    inventory i2 ON i2.film_id = f1.film_id
        INNER JOIN
    rental r2 ON r2.inventory_id = i2.inventory_id
        INNER JOIN
    customer c2 ON r2.customer_id = c2.customer_id
WHERE
    c1.customer_id <> c2.customer_id
GROUP BY c1.customer_id , c2.customer_id
HAVING COUNT(*) > 3
ORDER BY num_films DESC;

