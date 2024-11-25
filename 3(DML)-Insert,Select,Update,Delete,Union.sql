/*  Create table Student with schema (roll_no, name, division, branch, city, marks)  */

USE practical_preperation;
CREATE TABLE Student (
	roll_no INT PRIMARY KEY, 
    name VARCHAR (50),
    division character,
    branch varchar (50),
    city varchar (50),
    marks int
); 
/* Insert 10 records to the table students */
INSERT INTO Student (roll_no, name, division, branch, city, marks)
VALUES
(1, "P", "B", "CSE-AI", "Abad", 87 ),
(2, "H", "B", "CSE-AI", "Pune", 57),
(3, "N" , "C", "Comp", "Abad", 78),
(4, "S", "A", "IOT" , "Nashik", 90);

SELECT * FROM student;
/*List all the student names with their corresponding city */

SELECT name, city FROM student;

/* List all the distinct names of the students */
SELECT distinct name from student;

/*List all the students whose marks are greater than 75*/
SELECT * FROM student where marks > 75 ;

/*  List all the students whose name starts with the alphabet S */
SELECT * FROM student WHERE name LIKE 'S%';

/* . List all the students whose marks are in the range of 50 to 60 */
SELECT * FROM student WHERE marks BETWEEN 50 AND 60;

/* List all the students whose branch is „computer‟ and city is „Pune‟ */
SELECT * FROM student WHERE branch = "CSE-AI" AND city = "Pune";

/*  Update the branch of a student to „IT‟ whose roll number is 3  */
UPDATE student SET branch = "IT" where roll_no = 3;
SELECT * FROM student;

/* Delete the student records whose division is „B */
DELETE FROM student WHERE division = 'B';

/*  Create another table TE_Students with Schema( roll_no, name)  */
CREATE TABLE TE_Students (
	roll_no INT PRIMARY KEY,
    name varchar (50)
);	

/*  List all the roll numbers unionly in the relations Student and TE_Students */
SELECT roll_no FROM student
UNION 
SELECT roll_no FROM TE_Students;

/* Display name of all the students belonging to relation Student in Upper case */
SELECT UPPER(name) from student;

/* Display the binary and hex equivalent of marks for all the students belonging to Student relation */
SELECT name, marks, BIN(marks) AS BINARY_MARKS, HEX(marks) AS HEX_MARKS FROM student;
