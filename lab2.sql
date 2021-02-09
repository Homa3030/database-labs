--Task 1
SELECT * FROM CITY WHERE (city_id>=12 AND city_id<=17) ORDER BY country_id ASC;

SELECT * FROM ADDRESS WHERE city_id IN (SELECT city_id FROM CITY WHERE city LIKE 'A%');

SELECT first_name, last_name, city FROM CUSTOMER 
	INNER JOIN
	ADDRESS ON customer.address_id = address.address_id
	INNER JOIN
	CITY ON address.city_id = city.city_id;
	
SELECT * FROM CUSTOMER WHERE customer_id IN (SELECT customer_id FROM PAYMENT WHERE amount > 11);

SELECT a.*
	FROM CUSTOMER a
	JOIN (SELECT first_name FROM CUSTOMER GROUP BY first_name HAVING count(*) > 1 ) b
	ON a.first_name = b.first_name
	ORDER BY a.first_name;
	
--Task 2
CREATE VIEW Jamies AS (SELECT * FROM CUSTOMER WHERE first_name LIKE 'Jamie');

CREATE VIEW Active_customers AS (SELECT * FROM CUSTOMER WHERE active = 1);

SELECT first_name, last_name FROM Active_customers;

CREATE OR REPLACE FUNCTION public.set_amount_zero()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
$$
BEGIN
	NEW.amount = 0;
	
	RETURN NEW;
END
$$

CREATE TRIGGER customer_set_amount
	BEFORE Insert
	ON customer
	FOR EACH ROW
	EXECUTE PROCEDURE public.set_amount_zero();
