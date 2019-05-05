
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
         SELECT concat(s.first_name,' ',s.last_name) AS 'Staff Member', sum(p.amount) AS 'Total Amount'
	     FROM payment AS p
	     JOIN staff AS s
	     ON p.staff_id = s.staff_id
	     WHERE payment_date LIKE '2005-08%'
	     GROUP BY p.staff_id;
	#6C
          SELECT f.title AS 'Film', COUNT(fa.actor_id) AS 'Number of Actors'
	      FROM film AS f
	      JOIN film_actor AS fa
	      ON f.film_id = fa.film_id
		  GROUP BY f.title;
	#6D
          SELECT f.title AS Film, COUNT(i.inventory_id) AS 'Inventory Count'
	      FROM film AS f
	      JOIN inventory AS i
	      ON f.film_id = i.film_id
	      WHERE f.title = 'Hunchback Impossible'
		  GROUP BY f.film_id;
	#6E          
          SELECT c.first_name, c.last_name, SUM(p.amount) AS 'TOTAL'
		  FROM customer c LEFT JOIN payment p ON c.customer_id = p.customer_id
		  GROUP BY c.first_name, c.last_name
		  ORDER BY c.last_name;
          
	#7A
    
          SELECT f.title FROM film as f
		  WHERE f.language_id = (SELECT language_id FROM language WHERE name = 'English')
		  AND f.title LIKE 'K%' OR 'Q%' ;
	#7B
		  SELECT CONCAT(first_name,' ',last_name) AS 'Actors in Alone Trip'FROM actor
	      WHERE actor_id IN 
	      (SELECT actor_id FROM film_actor WHERE film_id = (SELECT film_id FROM film WHERE title = 'Alone Trip'));
	#7C
		  SELECT concat(c.first_name,' ',c.last_name) AS 'Name', c.email AS 'E-mail'
		  FROM customer AS c
		  JOIN address AS a on c.address_id = a.address_id
	      JOIN city AS cy on a.city_id = cy.city_id
	      JOIN country AS ct on ct.country_id = cy.country_id
	      WHERE ct.country = 'Canada';
	#7D
          SELECT f.title AS 'Movie Title' FROM film AS f
		  JOIN film_category AS fc on fc.film_id = f.film_id
		  JOIN category AS c on c.category_id = fc.category_id
		  WHERE c.name = 'Family';
	#7E
		  SELECT f.title AS 'Movie', count(r.rental_date) AS 'Times Rented' FROM film AS f
		  JOIN inventory AS i on i.film_id = f.film_id
		  JOIN rental AS r on r.inventory_id = i.inventory_id
	      GROUP BY f.title
	      ORDER BY count(r.rental_date) desc;
	#7F
    	  SELECT store AS 'Store', total_sales AS 'Total Sales' FROM sales_by_store;
		  SELECT concat(c.city,', ',cy.country) AS `Store`, s.store_id AS 'Store ID', sum(p.amount) AS `Total Sales` 
		  FROM payment AS p
		  JOIN rental AS r on r.rental_id = p.rental_id
		  JOIN inventory as i on i.inventory_id = r.inventory_id
		  JOIN store AS s on s.store_id = i.store_id
		  JOIN address AS a on a.address_id = s.address_id
	      JOIN city AS c on c.city_id = a.city_id
		  JOIN country AS cy on cy.country_id = c.country_id
		  GROUP BY s.store_id;
	#7G
          SELECT s.store_id AS 'Store ID', c.city AS 'City', cy.country AS 'Country' FROM store AS s
	      JOIN address AS a on a.address_id = s.address_id
		  JOIN city AS c on c.city_id = a.city_id
		  JOIN country AS cy on cy.country_id = c.country_id
		  ORDER BY s.store_id;
	#7H
		 SELECT c.name AS "Top Five", SUM(p.amount) AS "Gross" FROM category c
	     JOIN film_category fc ON (c.category_id=fc.category_id)
		 JOIN inventory i ON (fc.film_id=i.film_id)
		 JOIN rental r ON (i.inventory_id=r.inventory_id)
		 JOIN payment p ON (r.rental_id=p.rental_id)
		 GROUP BY c.name ORDER BY Gross  LIMIT 5;
         
	#8A
         CREATE VIEW top_5_genre_revenue AS 
		 SELECT c.name AS 'Film', sum(p.amount) AS 'Gross Revenue'
		 FROM category AS c
		 JOIN film_category AS fc on fc.category_id = c.category_id
		 JOIN inventory AS i on i.film_id = fc.film_id
		 JOIN rental AS r on r.inventory_id = i.inventory_id
		 JOIN payment AS p on p.rental_id = r.rental_id
		 GROUP BY c.name
		 ORDER BY sum(p.amount) desc
         LIMIT 5;
	#8B
		SELECT * FROM top_5_genre_revenue;

    #8C
		 DROP VIEW top_5_genre_revenue;
