-- 6
alter table sakila.staff drop column picture;

-- -------------------------------------------------

-- 7
-- to check if such an entry already exists
SELECT 
    *
FROM
    sakila.customer
WHERE
    first_name = 'TAMMY'
        AND last_name = 'SANDERS';

insert into sakila.staff(first_name, last_name, email, address_id, store_id, username)
values('TAMMY','SANDERS', 'TAMMY.SANDERS@sakilacustomer.org', 79, 2, 'tammy');

SELECT * FROM staff;
-- -------------------------------------------------

-- 8
-- get customer_id
SELECT 
    customer_id
FROM
    sakila.customer
WHERE
    first_name = 'CHARLOTTE'
        AND last_name = 'HUNTER';
-- expected customer_id = 130

SELECT * FROM customer;

-- get film_id
SELECT 
    film_id
FROM
    sakila.film
WHERE
    title = 'ACADEMY DINOSAUR';
-- expected film_id = 1

-- get inventory_id
SELECT 
    inventory_id
FROM
    sakila.inventory
WHERE
    film_id = 1;
-- expected inventory_id = 1

-- get staff_id
SELECT 
    *
FROM
    sakila.staff;
-- expected staff_id = 1

insert into sakila.rental(rental_date, inventory_id, customer_id, staff_id)
values (curdate(), 1, 130, 1);

SELECT * FROM rental;
