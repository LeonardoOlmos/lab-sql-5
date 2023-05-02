-- Leonardo Olmos Saucedo / SQL Lab 5

USE sakila;

-- 1. Drop column picture from staff.
ALTER TABLE staff
DROP COLUMN picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT * FROM staff;
INSERT INTO staff(first_name, last_name, address_id, email, store_id, active, username, last_update) 
VALUES ('Tammy', 'Sanders', 79, 'Tammy.Sanders@sakilastaff.com', 2, 1, 'Tammy', now());

/* 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. 
 Hint: Check the columns in the table rental and see what information you would need to add there. 
 You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:
*/
INSERT INTO rental(rental_date, inventory_id, customer_id, staff_id)
VALUES (now(), 1, 130, 1);

-- 4. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:

-- * Check if there are any non-active users
SELECT c.customer_id, c.email
FROM customer c
WHERE c.active = 0;

-- * Create a table backup table as suggested
CREATE TABLE deleted_users(
	customer_id INT PRIMARY KEY,
    email VARCHAR(150) NOT NULL,
    delete_date TIMESTAMP DEFAULT now()
);

-- * Insert the non active users in the table backup table
INSERT INTO deleted_users (customer_id, email)
SELECT c.customer_id, c.email
FROM customer c
WHERE c.active = 0;

SELECT *
FROM deleted_users;

-- * Delete the non active users from the table customer
DELETE FROM customer
WHERE active = 0;

-- In order to do this excercise was neccesary to delete foreign keys and created again but with on delete cascade option