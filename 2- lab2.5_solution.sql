USE sakila;

-- 1. Select all the actors with the first name ‘Scarlett’.
SELECT 
    *
FROM
    sakila.actor
WHERE
    first_name = 'SCARLETT';


-- 2. How many films (movies) are available for rent and how many films have been rented?
SELECT 
    COUNT(*)
FROM
    sakila.film;
SELECT 
    COUNT(*)
FROM
    sakila.rental;

-- 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT 
    MAX(length) AS max_duration, MIN(length) AS min_duration
FROM
    sakila.film;

-- 4. What's the average movie duration expressed in format (hours, minutes)?
SELECT 
    FLOOR(AVG(length) / 60) AS hours,
    ROUND(AVG(length) % 60) AS minutes
FROM
    sakila.film;

-- 5. How many distinct (different) actors' last names are there?
SELECT 
    COUNT(DISTINCT last_name)
FROM
    actor;

-- 6. Since how many days has the company been operating (check DATEDIFF() function)?
SELECT 
    DATEDIFF(MAX(rental_date), MIN(rental_date)) AS active_days
FROM
    rental;

-- 7. Show rental info with additional columns month and weekday. Get 20 results.
SELECT 
    *,
    DATE_FORMAT(rental_date, '%M') AS month,
    DATE_FORMAT(rental_date, '%W') AS weekday
FROM
    rental
LIMIT 20;

-- 8. Add an additional column day_type with values 'weekend' and 'workday' depending 
-- on the rental day of the week.
SELECT 
    *,
    CASE
        WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday' , 'Sunday') THEN 'weekend'
        ELSE 'workday'
    END AS day_type
FROM
    rental;

-- 9. Get release years.
SELECT DISTINCT
    release_year
FROM
    sakila.film;

-- 10. Get all films with ARMAGEDDON in the title.
SELECT 
    title
FROM
    sakila.film
WHERE
    title LIKE '%ARMAGEDDON%';

-- 11. Get all films which title ends with APOLLO.
-- 11 (option 1)
SELECT 
    title
FROM
    sakila.film
WHERE
    title LIKE '%APOLLO';

-- 11 (option 2)
SELECT 
    title
FROM
    sakila.film
WHERE
    title REGEXP 'APOLLO$';

-- 12. Get 10 the longest films.
SELECT 
    title
FROM
    sakila.film
ORDER BY length DESC
LIMIT 10;

-- 13. How many films include Behind the Scenes content?
SELECT 
    COUNT(*)
FROM
    sakila.film
WHERE
    special_features LIKE '%Behind the Scenes%';