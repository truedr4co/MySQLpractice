SET sql_safe_updates = 0;
CREATE DATABASE mydb3_test; 
USE mydb3_test;
ALTER DATABASE mydb3_test READ ONLY = 1;
ALTER DATABASE mydb3_test READ ONLY = 0;
ALTER DATABASE mydb3_test ENCRYPTION = 'Y';
ALTER DATABASE mydb3_test ENCRYPTION = 'N';
DROP DATABASE mydb3_test;

CREATE DATABASE mydb3;

USE mydb3;

CREATE TABLE employees (
    employee_id int PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50), 
    hourly_pay DECIMAL(5, 2),
    hire_date DATE
);

RENAME TABLE employees TO workers;
RENAME TABLE workers TO employees;

ALTER TABLE employees
ADD phone_number VARCHAR(15);
 
ALTER TABLE employees
RENAME COLUMN phone_number TO email;
 
ALTER TABLE employees
MODIFY COLUMN email VARCHAR(15);

ALTER TABLE employees 
MODIFY email VARCHAR(100) 
AFTER last_name;

ALTER TABLE employees 
MODIFY email VARCHAR(100) 
FIRST;

ALTER TABLE employees
DROP COLUMN email;

INSERT INTO employees
VALUES (1, 'Eugene', 'Krabs', 25.50, '2023-01-02');
SELECT * FROM employees;

INSERT INTO employees
VALUES  (2, 'Squidward', 'Tentacles', 15.00, '2023-01-03'), 
		(3, 'Spongebob', 'Squarepants', 12.50, '2023-01-04'), 
		(4, 'Patrick', 'Star', 12.50, '2023-01-05'), 
		(5, 'Sandy', 'Cheeks', 17.25, '2023-01-06');
SELECT * FROM employees;

INSERT INTO employees (employee_id, first_name, last_name)
VALUES  (6, 'Sheldon', 'Plankton');
SELECT * FROM employees;

SELECT * FROM employees;

SELECT first_name, last_name FROM employees;

SELECT last_name, first_name FROM employees;

SELECT *
FROM employees
WHERE employee_id = 1;

SELECT *
FROM employees
WHERE first_name = 'Spongebob';

SELECT *
FROM employees
WHERE hourly_pay >= 15;

SELECT hire_date, first_name
FROM employees
WHERE hire_date <= '2023-01-03';

SELECT *
FROM employees
WHERE employee_id != 1;

SELECT *
FROM employees
WHERE hire_date IS NULL;

SELECT *
FROM employees
WHERE hire_date IS NOT NULL;

UPDATE employees
SET hourly_pay = 10.25
WHERE employee_id = 6;

UPDATE employees
SET hourly_pay = 10.50,
	hire_date = '2023-01-07'
WHERE employee_id = 6;

CREATE TABLE employees_test_allchange (
    employee_id int PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50), 
    hourly_pay DECIMAL(5, 2),
    hire_date DATE
);

INSERT INTO employees_test_allchange
VALUES  (2, 'Squidward', 'Tentacles', 15.00, '2023-01-03'), 
		(3, 'Spongebob', 'Squarepants', 12.50, '2023-01-04'), 
		(4, 'Patrick', 'Star', 12.50, '2023-01-05'), 
		(5, 'Sandy', 'Cheeks', 17.25, '2023-01-06');

UPDATE employees_test_allchange
SET hourly_pay = 10.25;
SELECT * FROM employees_test_allchange;

DROP TABLE employees_test_allchange;


UPDATE employees
SET hire_date = NULL
WHERE employee_id = 6;
SELECT * FROM employees;

DELETE FROM employees
WHERE employee_id = 6;
SELECT * FROM employees;

SET AUTOCOMMIT = OFF;
COMMIT;
ROLLBACK;
SET AUTOCOMMIT = ON;

CREATE TABLE test(
	my_date DATE,
	my_time TIME,
	my_datetime DATETIME
);

INSERT INTO test
VALUES(CURRENT_DATE(), CURRENT_TIME(), NOW());
SELECT * FROM test;

DROP TABLE test;

CREATE TABLE products (
    product_id INT,
    product_name varchar(25) UNIQUE,
    price DECIMAL(4, 2)
);

CREATE TABLE products_not_uniq (
    product_id INT,
    product_name_2 varchar(25),
    price DECIMAL(4, 2)
);

ALTER TABLE products_not_uniq
ADD CONSTRAINT 
UNIQUE (product_name_2);
DROP TABLE products_not_uniq;

INSERT INTO products
VALUES (100, 'hamburger', 3.99),
		(101, 'fries', 1.89),
		(102, 'soda', 1.00),
		(103, 'ice cream', 1.49);

CREATE TABLE products_test (
    product_id INT,
    product_name varchar(25),
    price DECIMAL(4, 2) NOT NULL
);

DROP TABLE products_test;

ALTER TABLE products
MODIFY price DECIMAL(4, 2) NOT NULL;

INSERT INTO products
VALUES(104, 'cookie', 0);
SELECT * FROM products; 

CREATE TABLE employees_test_cnstrt(
	employee_id INT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	hourly_pay DECIMAL (5, 2),
	hire_date DATE, 
	CONSTRAINT chk_hourly_pay CHECK (hourly_pay >= 10.00)
);

DROP TABLE employees_test_cnstrt;