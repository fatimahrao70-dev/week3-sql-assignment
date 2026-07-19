CREATE DATABASE week3_assignment;
USE week3_assignment;
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    subject VARCHAR(30),
    marks INT,
    city VARCHAR(30),
    admission_date DATE,
    attendance_percentage INT
);
SHOW TABLES;
DESCRIBE students;
INSERT INTO students
VALUES
(1,'Ahmed','Math',78,'Lahore','2023-01-15',92),

(2,'Ayesha','Science',65,'Karachi','2023-01-18',88),

(3,'Bilal','Math',45,'Lahore','2023-02-01',70),

(4,'Sana','English',89,'Islamabad','2023-01-20',95),

(5,'Hassan','Science',NULL,'Karachi','2023-03-05',60),

(6,'Mariam','Math',92,'Lahore','2023-01-10',98),

(7,'Usman','English',55,'Multan','2023-02-14',75),

(8,'Zara','Science',70,'Islamabad','2023-01-25',85),

(9,'Ahsan','Math',NULL,'Karachi','2023-04-02',50),

(10,'Nida','English',60,'Lahore','2023-02-20',80);

SELECT * FROM students;
SELECT name, marks
FROM students
WHERE marks > 70;
SELECT DISTINCT subject
FROM students;
SELECT *
FROM students
WHERE name LIKE 'A%';
SELECT *
FROM students
WHERE marks IS NULL;
SELECT COUNT(*) AS Total_Students
FROM students;
SELECT AVG(marks) AS Average_Marks
FROM students;
SELECT
MAX(marks) AS Highest,
MIN(marks) AS Lowest
FROM students;
SELECT *
FROM students
ORDER BY marks DESC
LIMIT 5;