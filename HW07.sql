	#1A
    SELECT first_name, last_name
	FROM actor;
    #1B
	SELECT upper(concat(first_name,' ',last_name)) as 'Actor Name'
	FROM actor;
    #2A
	SELECT actor_id, first_name, last_name
	FROM actor
	WHERE first_name like 'Joe';
    #2B
    SELECT first_name, last_name
	FROM actor
	WHERE last_name like '%GEN%';
    #2C
    SELECT first_name, last_name
	FROM actor
	WHERE last_name like '%LI%'
	ORDER BY last_name, first_name;
    #2D
    SELECT country_id, country
	FROM country
	WHERE country in ('Afghanistan', 'Bangladesh', 'China');
   
   #3A
	ALTER TABLE actor
	ADD COLUMN descripttion BLOB after first_name;
    SELECT * FROM actor;
  
    #3B
    ALTER TABLE actor
	DROP COLUMN middle_name;
    SELECT *  FROM actor;
    
    #4A
    SELECT last_name AS 'Last Name', COUNT(last_name) AS 'Last Name Count'
	FROM actor
	GROUP BY last_name;
    
    #4B
    SELECT last_name AS 'Last Name', COUNT(last_name) AS 'Last Name Count'
	FROM actor
	GROUP BY last_name
	HAVING COUNT(last_name) > 1;
    
    #4C
    SELECT first_name, last_name FROM actor
	WHERE first_name = 'GROUCHO' AND last_name = 'WWILLIAMS';

	UPDATE actor
	SET first_name = 'HARPO'
	WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

	SELECT * FROM actor
	WHERE last_name = 'WILLIAMS';
    
    #4D
    SELECT first_name FROM actor
	WHERE first_name = 'HARPO';

	UPDATE actor
	SET first_name = 'GROUCHO'
	WHERE first_name = 'HARPO';

	UPDATE actor
	SET first_name = CASE
		WHEN first_name = 'HARPO' THEN 'GROUCHO'
    	WHEN first_name = 'GROUCHO' THEN 'HARPO'
    	ELSE first_name
	END;
	SELECT * FROM actor;
    
    #5A
    CREATE TABLE address_new (
		address_id INTEGER(11) NOT NULL,
    		address VARCHAR(30) NOT NULL,
    		adress2 VARCHAR(30) NOT NULL,
    		district VARCHAR(30) NOT NULL,
    		city_id INTEGER(11) NOT NULL,
    		postal_code INTEGER(11) NOT NULL,
    		phone INTEGER(10) NOT NULL,
    		location VARCHAR(30) NOT NULL,
    		last_update DATETIME
	);
    #6A
    	 SELECT s.first_name AS 'First Name', s.last_name AS 'Last Name', a.address AS 'Address'FROM staff AS s
		 JOIN address AS a 
		 ON a.address_id = s.address_id;
	#6B