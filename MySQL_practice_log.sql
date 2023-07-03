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

ALTER TABLE employees
ADD CONSTRAINT chk_hourly_pay CHECK (hourly_pay >= 10.00);

INSERT INTO employees
VALUES (6, 'Sheldon', 'Plankton', 10.00, '2023-01-07');

ALTER TABLE employees
DROP CHECK chk_hourly_pay;

CREATE TABLE products_test_dflt (
    product_id INT,
    product_name varchar(25),
    price DECIMAL(4, 2) DEFAULT 0
);

DROP TABLE products_test_dflt;

ALTER TABLE products 
ALTER price SET DEFAULT 0;

INSERT INTO products (product_id, product_name)
VALUES	(104, 'straw'),
		(105, 'napkin'),
		(106, 'fork'),
		(107, 'spoon');
SELECT * FROM products;

CREATE TABLE transactions_test(
	transaction_id INT,
	amount DECIMAL(5, 2),
   	transaction_date DATETIME DEFAULT NOW()
);
SELECT * FROM transactions_test;

INSERT INTO transactions_test (transaction_id, amount)
VALUES (1, 4.99);
SELECT * FROM transactions_test;

INSERT INTO transactions_test (transaction_id, amount)
VALUES (2, 2.89);
SELECT * FROM transactions_test;

INSERT INTO transactions_test (transaction_id, amount)
VALUES (3, 8.37);
SELECT * FROM transactions_test;

DROP TABLE transactions_test;

CREATE TABLE transactions (
	transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL (5,2)
);

INSERT INTO transactions (amount)
VALUES(4.99), 
		(2.89),
        (3.38),
        (4.99);

ALTER TABLE transactions
AUTO_INCREMENT = 1000;

DELETE FROM transactions;

INSERT INTO transactions (amount)
VALUES(4.99),
		(2.89), 
        (3.38), 
        (4.99);

SELECT * FROM transactions;

CREATE TABLE customers (
     customer_id INT PRIMARY KEY AUTO_INCREMENT,
     first_name VARCHAR(50),
     last_name VARCHAR(50)
);

INSERT INTO customers (first_name, last_name)
VALUES  ('Fred', 'Fish'),
		('Larry', 'Lobster'),
		('Bubble', 'Bass');
SELECT * FROM customers;

CREATE TABLE transactions_fk_test (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(5, 2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
SELECT * FROM transactions_fk_test;

ALTER TABLE transactions_fk_test
DROP FOREIGN KEY transactions_fk_test_ibfk_1;
DROP TABLE transactions_fk_test;

ALTER TABLE transactions
ADD customer_id INT;

ALTER TABLE transactions
ADD CONSTRAINT fk_customer_id
FOREIGN KEY(customer_id) REFERENCES customers(customer_id);

DELETE FROM transactions;
SELECT * FROM transactions;
ALTER TABLE transactions
AUTO_INCREMENT = 1000;

INSERT INTO transactions (amount, customer_id)
VALUES(4.99, 3),
		(2.89, 2),
        (3.38, 3),
        (4.99, 1);

SELECT * FROM transactions;

INSERT INTO transactions (amount, customer_id)
VALUES (1.00, NULL);
SELECT * FROM transactions;

INSERT INTO customers (first_name, last_name)
VALUES('Poppy', 'Puff');
SELECT * FROM customers;

SELECT* 
FROM transactions INNER JOIN customers
ON transactions.customer_id = customers.customer_id;

SELECT transaction_id, amount, first_name, last_name
FROM transactions INNER JOIN customers
ON transactions.customer_id = customers.customer_id;

SELECT *
FROM transactions LEFT JOIN customers
ON transactions.customer_id = customers.customer_id;

SELECT *
FROM transactions RIGHT JOIN customers
ON transactions.customer_id = customers.customer_id;

SELECT COUNT(amount) AS 'daily transactions'
FROM transactions;

SELECT MAX(amount) AS maximum
FROM transactions;

SELECT MIN(amount) AS minimum
FROM transactions;

SELECT AVG(amount) AS average
FROM transactions;

SELECT SUM(amount) AS sum
FROM transactions;

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;

ALTER TABLE employees
ADD COLUMN job VARCHAR(25) AFTER hourly_pay;

UPDATE employees
SET job = 'manager'
WHERE employee_id = 1;

UPDATE employees
SET job = 'cashier'
WHERE employee_id = 2;

UPDATE employees
SET job = 'cook'
WHERE employee_id = 3;

UPDATE employees
SET job = 'cook'
WHERE employee_id = 4;

UPDATE employees
SET job = 'ass.t manager'
WHERE employee_id = 5;

UPDATE employees
SET job = 'janitor'
WHERE employee_id = 6; 

SELECT * 
FROM employees
WHERE hire_date < '2023-01-05' AND job = 'cook';

SELECT * 
FROM employees
WHERE job = 'cook' OR job = 'cashier';

SELECT * 
FROM employees
WHERE NOT job = 'manager';

SELECT *
FROM employees
WHERE NOT job = 'manager' AND NOT job = 'asst. manager';

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

SELECT first_name, last_name
FROM customers
WHERE customer_id IN
(SELECT DISTINCT customer_id
FROM transactions
WHERE customer_id IS NOT NULL);

SELECT first_name, last_name
FROM customers
WHERE customer_id NOT IN
(SELECT DISTINCT customer_id
FROM transactions
WHERE customer_id IS NOT NULL);

ALTER TABLE transactions
ADD order_date DATE;

UPDATE transactions
SET order_date = '2023-01-01'
WHERE transaction_id = 1000;

UPDATE transactions
SET order_date = '2023-01-01'
WHERE transaction_id = 1001;

UPDATE transactions
SET order_date = '2023-01-02'
WHERE transaction_id = 1002;

UPDATE transactions
SET order_date = '2023-01-02'
WHERE transaction_id = 1003;

UPDATE transactions
SET order_date = '2023-01-03'
WHERE transaction_id = 1004;

INSERT INTO transactions
VALUES (1005, 2.49, NULL, '2023-01-03'),
		(1006, 5.48, NULL, '2023-01-03');

SELECT * FROM transactions;

SELECT SUM(amount), order_date
FROM transactions
GROUP BY order_date;

SELECT MAX(amount), order_date
FROM transactions
GROUP BY order_date;

SELECT COUNT(amount), order_date
FROM transactions
GROUP BY order_date;

SELECT SUM(amount), customer_id
FROM transactions
GROUP BY customer_id;

SELECT MAX(amount), customer_id
FROM transactions
GROUP BY customer_id;

SELECT MIN(amount), customer_id
FROM transactions
GROUP BY customer_id;

SELECT AVG(amount), customer_id
FROM transactions
GROUP BY customer_id;

SELECT COUNT(amount), customer_id
FROM transactions
GROUP BY customer_id;

SELECT COUNT(amount), customer_id
FROM transactions
GROUP BY customer_id
HAVING COUNT(amount) > 1 AND customer_id IS NOT NULL;

SELECT SUM(amount), order_date
FROM transactions
GROUP BY order_date WITH ROLLUP;

SELECT COUNT(transaction_id), order_date
FROM transactions
GROUP BY order_date WITH ROLLUP;

SELECT COUNT(transaction_id) AS '# of orders', customer_id
FROM transactions
GROUP BY customer_id WITH ROLLUP;

SELECT SUM(hourly_pay) AS 'horly pay', employee_id
FROM employees
GROUP BY employee_id WITH ROLLUP;

CREATE TABLE transactions_odsn_ex (
	transaction_id INT PRIMARY KEY,
    amount DECIMAL(5, 2),
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    ON DELETE SET NULL
);

DROP TABLE transactions_odsn_ex;

ALTER TABLE transactions DROP FOREIGN KEY fk_customer_id;
ALTER TABLE transactions
ADD constraint fk_customer_id
FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
ON DELETE SET NULL;

DELETE FROM customers 
WHERE customer_id = 4;
SELECT * FROM transactions;

INSERT INTO customers
VALUES(4, 'Poppy', 'Puff', 2, 'PPuff@gmail.com');

ALTER TABLE transactions DROP FOREIGN KEY fk_customer_id;

ALTER TABLE transactions
ADD CONSTRAINT fk_transactions_id
FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
ON DELETE CASCADE;

UPDATE transactions
SET customer_id = 4
WHERE transaction_id = 1005;

DELETE FROM customers
WHERE customer_id = 4;
SELECT * FROM transactions;

DELIMITER $$
CREATE PROCEDURE get_customers()
BEGIN
	SELECT * FROM customers;
END $$
DELIMITER ;

CALL get_customers;
DROP PROCEDURE get_customers;

DELIMITER $$
CREATE PROCEDURE find_customer(IN id INT)
BEGIN
	SELECT *
    FROM customers
    WHERE customer_id = id;
END $$
DELIMITER ;

CALL find_customer(1);
DROP PROCEDURE find_customer;

DELIMITER $$
CREATE PROCEDURE find_customer(IN f_name VARCHAR(50), IN l_name VARCHAR(50))
BEGIN
	SELECT * 
    FROM customers
    WHERE first_name = f_name AND last_name = l_name;
END $$
DELIMITER ; 

CALL find_customer('Larry', 'Lobster');

ALTER TABLE employees 
ADD COLUMN salary DECIMAL(10, 2) AFTER hourly_pay;
SELECT * FROM employees;

UPDATE employees
SET salary = hourly_pay * 2080;
SELECT * FROM employees;

CREATE TRIGGER before_hourly_pay_update
BEFORE UPDATE ON employees 
FOR EACH ROW
SET NEW.salary = (NEW.hourly_pay * 2080);

SHOW TRIGGERS;

UPDATE employees
SET hourly_pay = 50
WHERE employee_id = 1;
SELECT * FROM employees;

UPDATE employees 
SET hourly_pay = hourly_pay + 1;
SELECT * FROM employees;

DELETE FROM employees
WHERE employee_id = 6;

CREATE TRIGGER before_hourly_pay_insert
BEFORE INSERT ON employees 
FOR EACH ROW
SET NEW.salary = (NEW.hourly_pay * 2080);

INSERT INTO employees
VALUES(6, 'Sheldon', 'Plankton', 10, NULL, 'janitor', '2023-01-07', 5);

CREATE TABLE expenses(
	expense_id INT PRIMARY KEY, 
    expense_name VARCHAR(50), 
    expense_total DECIMAL(10, 2)
);

INSERT INTO expenses 
VALUES (1, 'salaries', 0),
		(2, 'supplies', 0),
		(3, 'taxes', 0);

UPDATE expenses
SET expense_total = (SELECT SUM(salary) FROM employees)
WHERE expense_name = 'salaries';
SELECT * FROM expenses;

CREATE TRIGGER after_salary_delete
AFTER DELETE ON employees 
FOR EACH ROW
UPDATE expenses
SET expense_total = expense_total - OLD.salary
WHERE expense_name = "salaries";


DELETE FROM employees 
WHERE employee_id = 6;
SELECT * FROM expenses;

CREATE TRIGGER after_salary_insert
AFTER INSERT ON employees 
FOR EACH ROW
UPDATE expenses
SET expense_total = expense_total + NEW.salary
WHERE expense_name = "salaries";

INSERT INTO employees
VALUES(6, 'Sheldon', 'Plankton', 10, NULL, 'janitor', '2023-01-07', 5);
SELECT * FROM expenses;

CREATE TRIGGER after_salary_update
AFTER UPDATE ON employees 
FOR EACH ROW
UPDATE expenses
SET expense_total = expense_total + (NEW.salary - OLD.salary)
WHERE expense_name = "salaries";

UPDATE employees 
SET hourly_pay = 100
WHERE employee_id = 1;
SELECT * FROM expenses;

SET sql_safe_updates = 1;
