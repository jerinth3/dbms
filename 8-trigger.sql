-- Drop tables if they already exist
DROP TABLE IF EXISTS Library;
DROP TABLE IF EXISTS Library_Audit;

-- Create the Library table
CREATE TABLE Library (
    BookID INT PRIMARY KEY,
    BookName VARCHAR(100),
    AuthorName VARCHAR(100),
    PublishedYear INT
);

-- Create the Library_Audit table
CREATE TABLE Library_Audit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    BookName VARCHAR(100),
    AuthorName VARCHAR(100),
    PublishedYear INT,
    ActionType VARCHAR(20), -- Stores whether 'UPDATE' or 'DELETE'
    ActionTime DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data into Library
INSERT INTO Library (BookID, BookName, AuthorName, PublishedYear) VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 1925),
(2, '1984', 'George Orwell', 1949),
(3, 'To Kill a Mockingbird', 'Harper Lee', 1960);

-- Create a trigger to track updates
DELIMITER $$

CREATE TRIGGER after_Library_Update
AFTER UPDATE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (BookID, BookName, AuthorName, PublishedYear, ActionType)
    VALUES (OLD.BookID, OLD.BookName, OLD.AuthorName, OLD.PublishedYear, 'UPDATE');
END$$

DELIMITER ;

-- Create a trigger to track deletions
DELIMITER $$

CREATE TRIGGER after_Library_Delete
AFTER DELETE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (BookID, BookName, AuthorName, PublishedYear, ActionType)
    VALUES (OLD.BookID, OLD.BookName, OLD.AuthorName, OLD.PublishedYear, 'DELETE');
END$$

DELIMITER ;

-- Example Update Operation
UPDATE Library
SET BookName = 'Brave New World', AuthorName = 'Aldous Huxley'
WHERE BookID = 2;

-- Example Delete Operation
DELETE FROM Library WHERE BookID = 3;

-- Check the Library_Audit table
SELECT * FROM Library_Audit;
