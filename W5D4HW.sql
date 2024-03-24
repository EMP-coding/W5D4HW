

--Week 5 - Thursday Questions

--1. Create a Stored Procedure that will insert a new film into the film table with the following arguments: title, description, release_year, language_id rental_duration, rental_rate, length, replace_cost, rating

CREATE OR REPLACE PROCEDURE add_film (title VARCHAR, description TEXT, release_year INT, language_id INT, rental_duration INT, rental_rate NUMERIC(4,2), length INT, replacement_cost NUMERIC(4,2), rating VARCHAR)
LANGUAGE plpgsql 
AS $$ 
BEGIN 
    INSERT INTO film (title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating)
    VALUES (title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating::mpaa_rating);
END;
$$;

-- Testing procedure 
CALL add_film('Land of Bad', 'A US Army special forces unit is ambushed during a mission to retrieve an intelligence asset and their only remaining hope lies with a remote Air Force drone operator assisting them through a brutal 48-hour battle for survival.', 2024, 1, 3, 2.99, 114, 19.99, 'R')

-- Verifying that film 'Land of Bad' has been added
SELECT title, film_id FROM film 
ORDER BY film_id DESC 



--2. Create a Stored Function that will take in a category_id and return the number of films in that category

-- Checking data prior to get idea of what needs to be done 
SELECT * FROM category c 

SELECT * FROM film

SELECT * FROM film_category fc  

SELECT count(*)
FROM film_category fc 
WHERE category_id = 6


CREATE FUNCTION get_cata_count(catid int)
RETURNS int
LANGUAGE plpgsql
AS $$
DECLARE 
    film_count int;
BEGIN 
    SELECT count(*)
    INTO film_count
    
    FROM film_category 
    WHERE category_id = catid;
    
    RETURN film_count;
END;
$$;

--Verifying function works
SELECT get_cata_count(16)