-- Drop tables if they already exist
DROP TABLE IF EXISTS Stud_Marks;
DROP TABLE IF EXISTS Result;

-- Create Stud_Marks table
CREATE TABLE Stud_Marks (
    name VARCHAR(100),
    total_marks INT
);

-- Create Result table
CREATE TABLE Result (
    Roll INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Class VARCHAR(50)
);

-- Insert sample data into Stud_Marks
INSERT INTO Stud_Marks (name, total_marks) VALUES 
('Alice', 1500),
('Bob', 970),
('Charlie', 890),
('David', 820);

-- Create the function for categorizing marks
DELIMITER $$

CREATE FUNCTION get_Grade(marks INT) RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE category VARCHAR(50);

    -- Logic to categorize marks
    IF marks BETWEEN 990 AND 1500 THEN
        SET category = 'Distinction';
    ELSEIF marks BETWEEN 900 AND 989 THEN
        SET category = 'First Class';
    ELSEIF marks BETWEEN 825 AND 899 THEN
        SET category = 'Higher Second Class';
    ELSE
        SET category = 'No Category';
    END IF;

    RETURN category;
END$$

DELIMITER ;

-- Use the function to populate the Result table
INSERT INTO Result (Name, Class)
SELECT name, get_Grade(total_marks) FROM Stud_Marks;

-- Check the Result table
SELECT * FROM Result;
