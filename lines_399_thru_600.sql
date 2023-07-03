
SELECT * 
FROM employees
WHERE hire_date BETWEEN '2023-01-04' AND '2023-01-07';

SELECT *
FROM employees
WHERE job IN ('cook', 'cashier', 'janitor');

SELECT * FROM employees
WHERE first_name LIKE 's%';

SELECT * FROM employees
WHERE first_name LIKE "s%";

SELECT * FROM employees
WHERE last_name LIKE '%r';

SELECT * FROM employees
WHERE hire_date LIKE '2023%';

SELECT * FROM employees
WHERE job LIKE '_ook';

SELECT * FROM employees
WHERE hire_date LIKE '____-__-02';

SELECT * FROM employees
WHERE job LIKE '_a%';

SELECT * FROM employees
ORDER BY last_name ASC;

SELECT * FROM transactions
ORDER BY amount DESC, customer_id DESC;

SELECT * FROM customers
LIMIT 1;

SELECT * FROM customers
LIMIT 3;

SELECT * FROM customers 
ORDER BY last_name DESC LIMIT 1;

SELECT * FROM customers
LIMIT 2, 1;

CREATE TABLE income_un_ex (
	income_name VARCHAR(25),
    amount DECIMAL(25, 2)
);

INSERT INTO income_un_ex
VALUES ('orders', 1000000.00),
		('merchandise', 50000.00),
        ('services', 125000.00);

CREATE TABLE expenses_un_ex (
	expense_name VARCHAR(25),
    amount DECIMAL(25, 2)
);

INSERT INTO expenses_un_ex
VALUES ('wages', -250000.00),
		('tax', -50000.00),
        ('repairs', -150000.00);

SELECT * FROM income_un_ex
UNION
SELECT * FROM expenses_un_ex;

DROP TABLE income_un_ex;
DROP TABLE expenses_un_ex;

SELECT first_name, last_name FROM employees
UNION
SELECT first_name, last_name FROM customers;

SELECT first_name, last_name FROM employees
UNION ALL
SELECT first_name, last_name FROM customers;

ALTER TABLE customers
ADD referral_id INT;
SELECT * FROM customers;

UPDATE customers
SET referral_id = 1
WHERE customer_id = 2;

UPDATE customers
SET referral_id = 2
WHERE customer_id = 3 OR customer_id = 4;

SELECT * 
FROM customers AS a
INNER JOIN customers as b
ON a.referral_id = b.customer_id;

SELECT a.customer_id, a.first_name, a.last_name,
	CONCAT(b.first_name,' ', b.last_name) AS 'referred_by'
FROM customers AS a
INNER JOIN customers AS b
ON a.referral_id = b.customer_id;

SELECT a.customer_id, a.first_name, a.last_name,
	CONCAT(b.first_name,' ', b.last_name) AS 'referred_by'
FROM customers AS a
LEFT JOIN customers AS b
ON a.referral_id = b.customer_id;

ALTER TABLE employees
ADD supervisor_id INT;
SELECT * FROM employees;

UPDATE employees
SET supervisor_id = 5
WHERE employee_id =2 OR employee_id=3 OR employee_id = 4 OR employee_id = 6;

UPDATE employees
SET supervisor_id = 1
WHERE employee_id = 5;
SELECT * FROM employees;

SELECT a.first_name, a.last_name, 
	CONCAT(b.first_name, ' ', b.last_name) AS 'reports to'
FROM employees AS a
LEFT JOIN employees AS b
ON a.supervisor_id = b.employee_id;

CREATE VIEW employee_attendance AS
SELECT first_name, last_name
FROM employees;

SELECT * FROM employee_attendance
ORDER BY last_name ASC;
DROP VIEW employee_attendance;

ALTER TABLE customers
ADD COLUMN email VARCHAR(50);

UPDATE customers
SET email = 'FFish@gmail.com'
WHERE customer_id = 1;

UPDATE customers
SET email = 'LLobster@gmail.com'
WHERE customer_id = 2;

UPDATE customers
SET email = 'BBass@gmail.com'
WHERE customer_id = 3;

UPDATE customers
SET email = 'PPuff@gmail.com'
WHERE customer_id = 4;
SELECT * FROM customers;

CREATE VIEW customer_emails AS
SELECT email
FROM customers;

SELECt * 
FROM customer_emails;

INSERT INTO customers
VALUES(5, 'Pearl', 'Krabs', NULL, 'PKrabs@gmail.com');
SELECT * FROM customers;

SELECT * 
FROM customer_emails;

SHOW INDEXES FROM customers;
CREATE INDEX last_name_idx
ON customers(last_name);

SHOW INDEXES FROM customers;

SELECT * FROM customers
WHERE last_name = 'Puff';

CREATE INDEX last_name_first_name_idx
ON customers(last_name, first_name);

SHOW INDEXES FROM customers;

ALTER TABLE customers
DROP INDEX last_name_idx;
SHOW INDEXES FROM customers;

SELECT * FROM customers
WHERE last_name = 'Puff' AND first_name = 'Poppy';


SELECT first_name, last_name, hourly_pay, 
	(SELECT AVG(hourly_pay) FROM employees) AS avg_pay
FROM employees;

SELECT first_name, last_name, hourly_pay
FROM employees
WHERE hourly_pay > (SELECT AVG(hourly_pay) FROM employees);