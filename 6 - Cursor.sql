-- Drop tables if they already exist
DROP TABLE IF EXISTS N_RollCall, O_RollCall;

-- Create table N_RollCall
CREATE TABLE N_RollCall (
    Roll_ID INT,
    Student_Name VARCHAR(255),
    Attendance_Date DATE,
    PRIMARY KEY (Roll_ID, Attendance_Date)
);

-- Create table O_RollCall
CREATE TABLE O_RollCall (
    Roll_ID INT,
    Student_Name VARCHAR(255),
    Attendance_Date DATE,
    PRIMARY KEY (Roll_ID, Attendance_Date)
);

-- Insert data into N_RollCall
INSERT INTO N_RollCall (Roll_ID, Student_Name, Attendance_Date)
VALUES
    (1, 'Jainil', '2024-11-01'),
    (2, 'Bhavesh', '2024-11-01'),
    (3, 'Sahil', '2024-11-02'),
    (4, 'Vinay', '2024-11-02');

-- Insert data into O_RollCall
INSERT INTO O_RollCall (Roll_ID, Student_Name, Attendance_Date)
VALUES
    (2, 'Bhavesh', '2024-11-01'), -- Duplicate entry to test skipping
    (4, 'Vinay', '2024-11-02'), -- Duplicate entry to test skipping
    (5, 'Shyam', '2024-11-03'),
    (6, 'Akshay','2024-11-04');
    
DELIMITER $$

CREATE PROCEDURE MergeRollCallData()
BEGIN
    -- Declare variables for cursor
    DECLARE done INT DEFAULT 0;
    DECLARE roll_id INT;
    DECLARE student_name VARCHAR(255);
    DECLARE attendance_date DATE;

    -- Declare a cursor to iterate through N_RollCall
    DECLARE cur CURSOR FOR SELECT Roll_ID, Student_Name, Attendance_Date FROM N_RollCall;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor
    OPEN cur;

    -- Start looping through the cursor
    read_loop: LOOP
        FETCH cur INTO roll_id, student_name, attendance_date;

        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Check if record exists in O_RollCall
        IF NOT EXISTS (
            SELECT 1 FROM O_RollCall
            WHERE Roll_ID = roll_id
              AND Student_Name = student_name
              AND Attendance_Date = attendance_date
        ) THEN
            -- Insert record if it doesn't exist
            INSERT INTO O_RollCall (Roll_ID, Student_Name, Attendance_Date)
            VALUES (roll_id, student_name, attendance_date);
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE cur;
END$$

DELIMITER ;




    -- Check data in N_RollCall
SELECT * FROM N_RollCall;

-- Check data in O_RollCall
SELECT * FROM O_RollCall;

CALL MergeRollCallData();

-- Verify updated data in O_RollCall
SELECT * FROM O_RollCall;

