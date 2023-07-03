
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