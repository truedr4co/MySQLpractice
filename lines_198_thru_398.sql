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