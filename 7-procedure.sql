use practical_preperation;
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

-- Create the stored procedure
DELIMITER $$

CREATE PROCEDURE proc_Grade()
BEGIN
    DECLARE student_name VARCHAR(100);
    DECLARE marks INT;
    DECLARE done INT DEFAULT 0;

    -- Cursor for iterating over Stud_Marks table
    DECLARE cur CURSOR FOR SELECT name, total_marks FROM Stud_Marks;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor
    OPEN cur;

    -- Loop through the cursor
    read_loop: LOOP
        FETCH cur INTO student_name, marks;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Categorize marks and insert into Result table
        IF marks BETWEEN 990 AND 1500 THEN
            INSERT INTO Result (Name, Class) VALUES (student_name, 'Distinction');
        ELSEIF marks BETWEEN 900 AND 989 THEN
            INSERT INTO Result (Name, Class) VALUES (student_name, 'First Class');
        ELSEIF marks BETWEEN 825 AND 899 THEN
            INSERT INTO Result (Name, Class) VALUES (student_name, 'Higher Second Class');
        ELSE
            INSERT INTO Result (Name, Class) VALUES (student_name, 'No Category');
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE cur;
END$$

DELIMITER ;

-- Call the stored procedure
CALL proc_Grade();

-- Check the Result table
SELECT * FROM Result;
