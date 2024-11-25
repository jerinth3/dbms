USE practical_preperation;

/*  Create table Customers with schema (ID, name, age, address, salary)  */

CREATE TABLE customers (
	ID INT PRIMARY KEY,
    name VARCHAR (50),
    age INT,
    address VARCHAR (100),
    salary DECIMAL
);

/*  Create table Orders with Schema(O_ID, o_date, customer_id, amount) */

CREATE TABLE orders (
	O_ID INT PRIMARY KEY,
    O_date DATE,
    customer_id INT,
    amount DECIMAL
);

/* Insert 5 records to each table keeping few customer ids common to both the tables  */

INSERT INTO customers (ID, name, age, address, salary)
values
(1, "P", 19, "Kamal Kanha", 50000),
(2, "S", 19, "Katraj", 46820),
(3, "H", 19, "Vishrant Wadi", 20000),
(4, "Sh", 19, "Chakan", 15000) ;

INSERT INTO orders (O_ID, O_date, customer_id, amount)
VALUES
(1, '2024-08-15', 1, 150.00),
(2, '2024-09-16', 3, 350.00),
(3, '2024-11-17', 1, 500.00);

/* . Perform the inner join on customers and orders table to enlist the id, name, amount and o_date */
SELECT 
	customers.ID, 
	customers.name,
    orders.amount,
    orders.O_date
FROM 
		customers
INNER JOIN 
			orders ON customers.ID = orders.customer_id;
            
/* Perform the left outer join on customers and orders table to enlist the id, name, amount and o_date */
            
SELECT 
	customers.ID, 
	customers.name,
    orders.amount,
    orders.O_date
FROM 
		customers
LEFT OUTER JOIN 
			orders ON customers.ID = orders.customer_id;      

/*  Perform the right outer join on customers and orders table to enlist the id, name, amount and o_date */
SELECT 
	customers.ID, 
	customers.name,
    orders.amount,
    orders.O_date
FROM 
		customers
RIGHT OUTER JOIN 
			orders ON customers.ID = orders.customer_id;

/* Perform the full outer join on customers and orders table to enlist the id, name, amount and o_date by 
using „union all‟ set operation */

SELECT 
	customers.ID, 
	customers.name,
    orders.amount,
    orders.O_date
FROM 
		customers
LEFT OUTER JOIN 
			orders ON customers.ID = orders.customer_id  

UNION ALL 

SELECT 
	customers.ID, 
	customers.name,
    orders.amount,
    orders.O_date
FROM 
		customers
RIGHT OUTER JOIN 
			orders ON customers.ID = orders.customer_id
WHERE customers.ID IS NULL;            

/* Perform the self join on customers table to enlist the pair of customers belonging to same address */

SELECT C1.ID AS Customer1_ID, C1.Name AS Customer1_Name,
		C2.ID AS Customer2_ID, C2.Name AS Customer2_Name,
        C1.Address
FROM customers C1
JOIN customers C2 on C1.address = C2.address AND C1.ID <> C2.ID;        

/*  Perform the Cross/ Cartesian join on customers and orders table to enlist the id, name, amount and o_date */
SELECT customers.ID, customers.name, orders.amount,orders.O_date
FROM customers
CROSS JOIN orders;

/*  Design the sub query with select statement for displaying all the details of the customers having salary 
greater than 20000 */


