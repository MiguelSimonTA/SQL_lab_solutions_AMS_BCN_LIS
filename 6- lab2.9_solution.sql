-- 1. How many distinct (different) actors' last names are there?
select count(distinct last_name)
from actor;

-- 2. Add an additional column day_type with values 'weekend' and 'workday' 
-- depending on the rental day of the week.
select *, case when date_format(rental_date, '%W') in ('Saturday', 'Sunday')
          then 'weekend'
          else 'workday' end as day_type
from rental;

-- 3. Get all films with ARMAGEDDON in the title.
select title from sakila.film
where title like '%ARMAGEDDON%';

-- 4.Get 10 the longest films.
select title from sakila.film
order by length desc
limit 10;

-- 5. How many films include Behind the Scenes content?
select count(*) from sakila.film
where special_features like '%Behind the Scenes%';

-- 6. Which kind of movies (rating) have a mean duration of more than two hours?
select rating, round(avg(length),2) as avg_duration from sakila.film
group by rating
having avg_duration > 120
order by avg_duration desc;

-- 7. Rank films by length (filter out the rows that have nulls or 0s in length 
-- column). In your output, only select the columns title, length, and the rank.
select title, length, RANK() over (ORDER BY length) ranks
from sakila.film
where length is not null and length > 0;

