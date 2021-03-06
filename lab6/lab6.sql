/*ex 1*/
SELECT film.title, customer.first_name, customer.last_name FROM customer CROSS JOIN film
WHERE film.title IN (SELECT film.title FROM film WHERE EXISTS (SELECT * FROM film_category WHERE film.film_id = film_category.film_id 
											  AND EXISTS (SELECT * FROM category WHERE film_category.category_id = category.category_id 
														  AND (category.name = 'Horror' OR category.name = 'Sci-Fi'))) AND 
					 (film.rating = 'R' OR film.rating = 'PG-13'))
EXCEPT (SELECT film.title, customer.first_name, customer.last_name FROM customer JOIN film ON (
	EXISTS (SELECT rental.customer_id, rental.inventory_id FROM rental WHERE customer.customer_id = rental.customer_id AND 
			EXISTS (SELECT inventory.inventory_id, inventory.film_id FROM inventory WHERE rental.inventory_id = inventory.inventory_id AND
					inventory.film_id = film.film_id))));

SELECT city.city, store.store_id, SUM(amount) number_of_sales FROM store JOIN city ON (
	EXISTS (SELECT * FROM address WHERE city.city_id = address.city_id AND store.address_id = address.address_id))
	JOIN payment ON (payment.payment_date > To_date('04-14-2007','MM-DD-YYYY') AND EXISTS (SELECT * FROM staff 
																						   WHERE store.store_id = staff.store_id 
																						   AND staff.staff_id = payment.staff_id))
	GROUP BY city.city, store.store_id ORDER BY number_of_sales DESC;

/*ex 2*/
/*as I know IDs have already hash indices*/

EXPLAIN ANALYZE SELECT film.title, customer.first_name, customer.last_name FROM customer CROSS JOIN film
WHERE film.title IN (SELECT film.title FROM film WHERE EXISTS (SELECT * FROM film_category WHERE film.film_id = film_category.film_id 
											  AND EXISTS (SELECT * FROM category WHERE film_category.category_id = category.category_id 
														  AND (category.name = 'Horror' OR category.name = 'Sci-Fi'))) AND 
					 (film.rating = 'R' OR film.rating = 'PG-13'))
EXCEPT (SELECT film.title, customer.first_name, customer.last_name FROM customer JOIN film ON (
	EXISTS (SELECT rental.customer_id, rental.inventory_id FROM rental WHERE customer.customer_id = rental.customer_id AND 
			EXISTS (SELECT inventory.inventory_id, inventory.film_id FROM inventory WHERE rental.inventory_id = inventory.inventory_id AND
					inventory.film_id = film.film_id))));

CREATE INDEX index_category_name
    ON public.category USING hash
    (name);


EXPLAIN ANALYZE SELECT city.city, store.store_id, SUM(amount) number_of_sales FROM store JOIN city ON (
	EXISTS (SELECT * FROM address WHERE city.city_id = address.city_id AND store.address_id = address.address_id))
	JOIN payment ON (payment.payment_date > To_date('04-14-2007','MM-DD-YYYY') AND EXISTS (SELECT * FROM staff 
																						   WHERE store.store_id = staff.store_id 
																						   AND staff.staff_id = payment.staff_id))
	GROUP BY city.city, store.store_id ORDER BY number_of_sales DESC;


CREATE INDEX index_payment_date
    ON public.payment USING btree
    (payment_date ASC NULLS LAST)
    INCLUDE(payment_date);