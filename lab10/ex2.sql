CREATE TABLE public.ledger
(
    id serial NOT NULL,
    from_id integer NOT NULL,
    to_id integer NOT NULL,
    fee integer,
    amount integer,
    transaction_date_time timestamp without time zone,
    PRIMARY KEY (id)
);

ALTER TABLE public.ledger
    OWNER to postgres;

SELECT * FROM ledger;
SELECT * FROM accounts;

BEGIN;
UPDATE accounts SET credit = credit - 500
    WHERE id = 1;
UPDATE accounts SET credit = credit + 500
    WHERE id = 3;
INSERT INTO ledger (id, from_id, to_id, fee, amount, transaction_date_time) VALUES (1, 1, 3, 0, 500, '{2016-06-22 19:10:25-07}');
SAVEPOINT transaction_1;

UPDATE accounts SET credit = credit - 730
    WHERE id = 2;
UPDATE accounts SET credit = credit + 30
    WHERE id = 4;
UPDATE accounts SET credit = credit + 700
    WHERE id = 1;
INSERT INTO ledger (id, from_id, to_id, fee, amount, transaction_date_time) VALUES (2, 2, 1, 30, 700, '{2017-06-22 17:10:25-07}');
SAVEPOINT transaction_2;

UPDATE accounts SET credit = credit - 130
    WHERE id = 2;
UPDATE accounts SET credit = credit + 30
    WHERE id = 4;
UPDATE accounts SET credit = credit + 100
    WHERE id = 3;
INSERT INTO ledger (id, from_id, to_id, fee, amount, transaction_date_time) VALUES (3, 2, 3, 30, 100, '{2017-06-21 17:20:25-07}');
SAVEPOINT transaction_3;

SELECT * FROM accounts;
SELECT * FROM ledger;

ROLLBACK TO transaction_3;
SELECT * FROM accounts;
SELECT * FROM ledger;

ROLLBACK TO transaction_2;
SELECT * FROM accounts;
SELECT * FROM ledger;

ROLLBACK TO transaction_1;
SELECT * FROM accounts;
SELECT * FROM ledger;

COMMIT;