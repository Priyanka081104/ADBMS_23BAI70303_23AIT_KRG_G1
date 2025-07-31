-- CREATE DATABASE AIT_1A -- Already exists, no need to run again
USE AIT_1A
GO

-- Only insert if author table has no data
IF NOT EXISTS (SELECT 1 FROM TBL_AUTHOR)
BEGIN
    INSERT INTO TBL_AUTHOR (AUTHOR_ID, AUTHOR_NAME, COUNTRY) VALUES
    (1, 'J.K. Rowling', 'United Kingdom'),
    (2, 'George R.R. Martin', 'United States'),
    (3, 'Haruki Murakami', 'Japan'),
    (4, 'Isabel Allende', 'Chile'),
    (5, 'Chinua Achebe', 'Nigeria'),
    (6, 'Gabriel Garcia Marquez', 'Colombia'),
    (7, 'Toni Morrison', 'United States'),
    (8, 'Leo Tolstoy', 'Russia'),
    (9, 'Jane Austen', 'United Kingdom'),
    (10, 'Mark Twain', 'United States');
END
GO

IF NOT EXISTS (SELECT 1 FROM TBL_BOOKS)
BEGIN
    INSERT INTO TBL_BOOKS (BOOK_ID, BOOK_TITLE, AUTHORID) VALUES
    (1, 'Harry Potter and the Sorcerer''s Stone', 1),
    (2, 'A Game of Thrones', 2),
    (3, 'Norwegian Wood', 3),
    (4, 'The House of the Spirits', 4),
    (5, 'Things Fall Apart', 5),
    (6, 'One Hundred Years of Solitude', 6),
    (7, 'Beloved', 7),
    (8, 'War and Peace', 8),
    (9, 'Pride and Prejudice', 9),
    (10, 'Adventures of Huckleberry Finn', 10);
END
GO

-- Show results (no harm re-running)
SELECT B.BOOK_TITLE AS [Book Title], A.AUTHOR_NAME AS [Author Name], A.COUNTRY AS [Country]
FROM TBL_BOOKS AS B
INNER JOIN TBL_AUTHOR AS A ON B.AUTHORID = A.AUTHOR_ID
GO

-- Medium Level

-- Only insert if department table has no data
IF NOT EXISTS (SELECT 1 FROM TBL_DEPARTMENT)
BEGIN
    INSERT INTO TBL_DEPARTMENT (DEPARTMENT_ID, DEPARTMENT_NAME) VALUES
    (1, 'Computer Science'),
    (2, 'Mathematics'),
    (3, 'Physics'),
    (4, 'Chemistry'),
    (5, 'English Literature');
END
GO

IF NOT EXISTS (SELECT 1 FROM TBL_COURSE)
BEGIN
    INSERT INTO TBL_COURSE (COURSE_ID, COURSE_NAME, DEPARTMENT_ID) VALUES
    (1, 'Data Structures', 1),
    (2, 'Operating Systems', 1),
    (3, 'Algorithms', 1),
    (4, 'Calculus', 2),
    (5, 'Linear Algebra', 2),
    (6, 'Quantum Mechanics', 3),
    (7, 'Electromagnetism', 3),
    (8, 'Organic Chemistry', 4),
    (9, 'Physical Chemistry', 4),
    (10, 'Shakespearean Literature', 5),
    (11, 'Modern Poetry', 5);
END
GO

-- Count query (safe)
SELECT COUNT(COURSE_NAME) AS Total, DEPARTMENT_NAME AS [Department Name]
FROM TBL_COURSE 
INNER JOIN TBL_DEPARTMENT ON TBL_COURSE.DEPARTMENT_ID = TBL_DEPARTMENT.DEPARTMENT_ID
GROUP BY TBL_DEPARTMENT.DEPARTMENT_NAME
GO

-- Subquery for departments with more than 2 courses
SELECT DEPARTMENT_NAME
FROM TBL_DEPARTMENT
WHERE DEPARTMENT_ID IN (
    SELECT DEPARTMENT_ID
    FROM TBL_COURSE
    GROUP BY DEPARTMENT_ID
    HAVING COUNT(*) > 2
)
GO

-- Create login and user if not exist
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'TEST_LOGIN_PRIYANKA')
BEGIN
    CREATE LOGIN TEST_LOGIN_PRIYANKA WITH PASSWORD = 'TESTLOGIN@123PRIYANKA';
END
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'TEST_LOGIN_PRIYANKA')
BEGIN
    CREATE USER TEST_LOGIN_PRIYANKA FOR LOGIN TEST_LOGIN_PRIYANKA;
END
GO

-- Grant SELECT if not already granted (this will not error even if already granted)
GRANT SELECT ON TBL_COURSE TO TEST_LOGIN_PRIYANKA;
GO
