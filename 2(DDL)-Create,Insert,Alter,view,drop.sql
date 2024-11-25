/* Create table Customers with schema (cust_id, cust_name, product, quantity, total_price) */

CREATE DATABASE IF NOT exists Practical_Preperation;
USE Practical_Preperation;

CREATE TABLE IF NOT EXISTS customers (
    cust_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_name VARCHAR(200),
    product VARCHAR(200),
    quantity INT,
    total_price DECIMAL
);
    
/* Use sequence/ auto-increment for incrementing customer ID and Insert 5 customer records to the table 
Customers  */    

INSERT INTO customers (cust_id, cust_name, product, quantity, total_price)
VALUES
(1,"P", "A", 2, 40.02),
(2,"S", "B", 5, 25),
(3,"Sh", "C", 4, 58.12);

SELECT * FROM customers;

/*Alter the table Customers by adding one column „price_per_qnty*/

ALTER TABLE customers ADD price_per_qnty DECIMAL (10,2);
SELECT * FROM customers;

/*Create view „Cust_View‟ on Customers displaying customer ID, customer name */

CREATE VIEW cust_view AS
SELECT cust_id, cust_name
FROM customers;

SELECT * FROM cust_view;

/* Update the view „Cust_View‟ to display customer ID, product, total price */

ALTER VIEW cust_view AS
select
	cust_name,
	cust_id,
	product,
    total_price
FROM 
	customers;

SELECT * FROM cust_view;   

/* Drop the view „Cust_View */
DROP VIEW cust_view;
 
/*Create index „Cust_index‟ on customer name */
CREATE INDEX Cust_Index ON customers(cust_name) ; 
SHOW INDEX FROM customers;

/* Drop index „Cust_index  */
DROP INDEX cust_index on customers;

DROP TABLE customers;
    

