-- Create Database and Use it
CREATE DATABASE IF NOT EXISTS assignment;
USE assignment;

-- Create Borrower Table with Rollin as VARCHAR(3)
CREATE TABLE IF NOT EXISTS Borrower(
    Rollin VARCHAR(3),         -- Change Rollin to VARCHAR(3)
    DateofIssue DATE,
    NameOfBook VARCHAR(50),
    Status CHAR(1) CHECK(Status IN ('R', 'I'))
);

-- Create Fine Table
CREATE TABLE IF NOT EXISTS Fine(
    Rollin VARCHAR(3),         -- Match the data type of Rollin to VARCHAR(3)
    DateReturn DATE, 
    Amount DECIMAL(10,2)
);

-- Insert Data into Borrower Table
INSERT INTO Borrower (Rollin, DateofIssue, NameOfBook, Status) 
VALUES 
    ('52', '2024-10-25', 'Scooby Doo', 'I'), 
    ('51', '2024-10-28', 'Harry Potter', 'I'),
    ('56', '2024-10-28', 'Data Structures & Algo', 'I');

-- Define Procedure to Return Book and Calculate Fine
DELIMITER $$

CREATE PROCEDURE ReturnBOOK(
    IN p_roll_no VARCHAR(3),    -- Parameter type now matches VARCHAR(3)
    IN p_name_of_book VARCHAR(50)
)
BEGIN
    DECLARE v_date_of_issue DATE;
    DECLARE v_status CHAR(1);
    DECLARE v_fine_amt DECIMAL(10,2) DEFAULT 0;
    DECLARE v_days INT;

    -- Fetch DateofIssue and Status for the given Rollin and NameOfBook
    SELECT DateofIssue, Status 
    INTO v_date_of_issue, v_status
    FROM Borrower
    WHERE Rollin = p_roll_no AND NameOfBook = p_name_of_book;

    -- If the record does not exist
    IF v_date_of_issue IS NULL THEN
        SELECT 'The user does not exist.' AS message;
    ELSE
        -- Calculate days since the book was issued
        SET v_days = DATEDIFF(CURDATE(), v_date_of_issue);
        
        -- Check if the book has already been returned
        IF v_status = 'R' THEN
            SELECT 'The book has already been returned' AS message;
        ELSE
            -- Calculate the fine amount
            IF v_days BETWEEN 15 AND 30 THEN
                SET v_fine_amt = (v_days - 14) * 5;
            ELSEIF v_days > 30 THEN 
                SET v_fine_amt = (30 - 14) * 5 + (v_days - 30) * 50;
            END IF;

            -- If fine amount is greater than 0, insert into Fine table
            IF v_fine_amt > 0 THEN
                INSERT INTO Fine (Rollin, DateReturn, Amount) 
                VALUES (p_roll_no, CURDATE(), v_fine_amt);
                SELECT CONCAT('Fine amount of Rs. ', v_fine_amt, ' is imposed') AS message;
            ELSE
                SELECT 'No fine applicable' AS message;
            END IF;

            -- Update the status of the book to 'Returned' (R)
            UPDATE Borrower
            SET Status = 'R'
            WHERE Rollin = p_roll_no AND NameOfBook = p_name_of_book;

            -- Confirm the book return
            SELECT 'The book has been returned successfully' AS message;
        END IF;
    END IF;
END $$

DELIMITER ;

-- Call the Procedure for Testing
CALL ReturnBOOK('52', 'Scooby Doo');

-- Select all records from Fine table
SELECT * FROM Fine;
