CREATE OR REPLACE FUNCTION retrievecustomers(customer_id_start integer, customer_id_end integer) RETURNS TABLE (customer_id integer, store_id smallint, first_name character varying(45), last_name character varying(45), email character varying(50), address_id smallint, activebool boolean, create_date date, last_update timestamp without time zone, active integer) AS $$ 
	BEGIN
		IF customer_id_start >= 0 AND customer_id_start < 600 THEN
			RETURN QUERY (SELECT * FROM customer WHERE (customer.customer_id >= customer_id_start) AND (customer.customer_id <= customer_id_end)
					ORDER BY customer.address_id);		
		ELSE
			RAISE EXCEPTION 'Error. Index out of range!';
		END IF;
	END;
$$ LANGUAGE plpgsql;
	
SELECT * FROM retrievecustomers(0, 5);