-- Create the tables
CREATE TABLE N_RollCall (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    RollDate DATE,
    Completed TINYINT
);

CREATE TABLE O_RollCall (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    RollDate DATE,
    Completed TINYINT
);

-- Insert data into N_RollCall
INSERT INTO N_RollCall (ID, Name, RollDate, Completed) VALUES
(1, 'Alice', '2024-11-20', 1),
(2, 'Bob', '2024-11-21', 0),
(3, 'Charlie', '2024-11-22', 1),
(4, 'Diana', '2024-11-23', 1),
(5, 'Eve', '2024-11-24', 0); -- New entry

-- Insert data into O_RollCall
INSERT INTO O_RollCall (ID, Name, RollDate, Completed) VALUES
(1, 'Alice', '2024-11-20', 1), -- Overlapping
(2, 'Bob', '2024-11-21', 0),   -- Overlapping
(6, 'Frank', '2024-11-19', 1), -- Unique to O_RollCall
(7, 'Grace', '2024-11-18', 0); -- Unique to O_RollCall


DELIMITER $$

CREATE PROCEDURE MergeRollCallData()
BEGIN
    -- Declare variables for cursor
    DECLARE v_ID INT;
    DECLARE v_Name VARCHAR(100);
    DECLARE v_Date DATE;
    DECLARE v_Completed TINYINT;

    -- Declare a flag to detect the end of the cursor
    DECLARE done INT DEFAULT 0;

    -- Declare a cursor to iterate over N_RollCall
    DECLARE cur CURSOR FOR 
        SELECT ID, Name, RollDate, Completed 
        FROM N_RollCall;

    -- Declare the CONTINUE HANDLER to set done = 1 when the cursor is exhausted
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor
    OPEN cur;

    -- Start the loop to process records
    read_loop: LOOP
        FETCH cur INTO v_ID, v_Name, v_Date, v_Completed;

        -- Check if the cursor is exhausted
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Perform an INSERT IGNORE (or a condition to skip existing data)
        INSERT INTO O_RollCall (ID, Name, RollDate, Completed)
        SELECT v_ID, v_Name, v_Date, v_Completed
        WHERE NOT EXISTS (
            SELECT 1 
            FROM O_RollCall 
            WHERE ID = v_ID
        );
    END LOOP;

    -- Close the cursor
    CLOSE cur;
END$$

DELIMITER ;


CALL MergeRollCallData();

SELECT * FROM O_RollCall;
