USE sakila;
SHOW tables;

-- 2
SELECT 
    *
FROM
    actor;
SELECT 
    *
FROM
    film;
SELECT 
    *
FROM
    customer;

-- 3
SELECT 
    title
FROM
    film;

-- 4
SELECT 
    name AS language
FROM
    language;

-- 5
SELECT DISTINCT
    name AS language
FROM
    language;

-- 5.1
SELECT 
    COUNT(*)
FROM
    store;

-- 5.2
SELECT 
    COUNT(*)
FROM
    staff;

-- 5.3
SELECT 
    first_name
FROM
    staff;
