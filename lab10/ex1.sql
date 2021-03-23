CREATE TABLE public.accounts
(
    id integer NOT NULL,
    name "char"[],
    credit integer,
    PRIMARY KEY (id)
);

ALTER TABLE public.accounts
    OWNER to postgres;

INSERT INTO accounts (id, name, credit) VALUES (1, '{Regina}', 1000);
INSERT INTO accounts (id, name, credit) VALUES (2, '{Vlad}', 1000);
INSERT INTO accounts (id, name, credit) VALUES (3, '{Mur}', 1000);

BEGIN;
UPDATE accounts SET credit = credit - 500
    WHERE id = 1;
UPDATE accounts SET credit = credit + 500
    WHERE id = 3;
SAVEPOINT transaction_1;

UPDATE accounts SET credit = credit - 700
    WHERE id = 2;
UPDATE accounts SET credit = credit + 700
    WHERE id = 1;
SAVEPOINT transaction_2;

UPDATE accounts SET credit = credit - 100
    WHERE id = 2;
UPDATE accounts SET credit = credit + 100
    WHERE id = 3;
SAVEPOINT transaction_3;

SELECT * FROM accounts;

ROLLBACK TO transaction_3;
SELECT * FROM accounts;

ROLLBACK TO transaction_2;
SELECT * FROM accounts;

ROLLBACK TO transaction_1;
SELECT * FROM accounts;

COMMIT;

ALTER TABLE public.accounts
    ADD COLUMN bank_name character varying[];

UPDATE accounts SET bank_name = '{SpearBank}'
    WHERE id = 1;
UPDATE accounts SET bank_name = '{Tinkoff}'
    WHERE id = 2;
UPDATE accounts SET bank_name = '{SpearBank}'
    WHERE id = 3;

INSERT INTO accounts (id, name, credit, bank_name) VALUES (4, '{Fees}', 0, null);

BEGIN;
UPDATE accounts SET credit = credit - 500
    WHERE id = 1;
UPDATE accounts SET credit = credit + 500
    WHERE id = 3;
SAVEPOINT transaction_1;

UPDATE accounts SET credit = credit - 730
    WHERE id = 2;
UPDATE accounts SET credit = credit + 30
    WHERE id = 4;
UPDATE accounts SET credit = credit + 700
    WHERE id = 1;
SAVEPOINT transaction_2;

UPDATE accounts SET credit = credit - 130
    WHERE id = 2;
UPDATE accounts SET credit = credit + 30
    WHERE id = 4;
UPDATE accounts SET credit = credit + 100
    WHERE id = 3;
SAVEPOINT transaction_3;

SELECT * FROM accounts;

ROLLBACK TO transaction_3;
SELECT * FROM accounts;

ROLLBACK TO transaction_2;
SELECT * FROM accounts;

ROLLBACK TO transaction_1;
SELECT * FROM accounts;

COMMIT;