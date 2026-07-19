DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(30),
    dept_id INT,
    salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    manager_id INT,
    hire_date DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name, location) VALUES
(1, 'IT', 'Lahore'),
(2, 'Sales', 'Karachi'),
(3, 'HR', 'Islamabad'),
(4, 'Finance', 'Lahore'),
(5, 'Marketing', 'Karachi');

INSERT INTO employees (id, name, department, dept_id, salary, bonus, manager_id, hire_date) VALUES
(1,  'Ali',     'IT',        1, 95000, 5000, NULL, '2019-03-11'),
(2,  'Sara',    'IT',        1, 72000, 3000, 1,    '2020-06-15'),
(3,  'Usman',   'IT',        1, 68000, NULL, 1,    '2021-01-20'),
(4,  'Fatima',  'IT',        1, 61000, 2000, 1,    '2022-08-05'),
(5,  'Hamza',   'Sales',     2, 58000, 4000, NULL, '2018-11-01'),
(6,  'Ayesha',  'Sales',     2, 62000, NULL, 5,    '2019-09-14'),
(7,  'Bilal',   'Sales',     2, 54000, 1500, 5,    '2021-04-22'),
(8,  'Mariam',  'Sales',     2, 59000, 2500, 5,    '2022-02-10'),
(9,  'Zainab',  'HR',        3, 50000, NULL, NULL, '2017-07-19'),
(10, 'Hassan',  'HR',        3, 48000, 1000, 9,    '2020-12-01'),
(11, 'Sana',    'HR',        3, 52000, NULL, 9,    '2023-01-15'),
(12, 'Kamran',  'Finance',   4, 88000, 6000, NULL, '2016-05-30'),
(13, 'Nida',    'Finance',   4, 71000, 3000, 12,   '2019-10-08'),
(14, 'Omar',    'Finance',   4, 67000, NULL, 12,   '2021-06-17'),
(15, 'Iqra',    'Finance',   4, 73000, 2500, 12,   '2020-03-25'),
(16, 'Tariq',   'Marketing', 5, 56000, 1800, NULL, '2018-02-14'),
(17, 'Rabia',   'Marketing', 5, 60000, NULL, 16,   '2022-09-09'),
(18, 'Asad',    'Marketing', 5, 55000, 1200, 16,   '2023-05-03'),
(19, 'Mahnoor', 'IT',        1, 64000, 2200, 1,    '2023-07-12'),
(20, 'Danish',  'Sales',     2, 57000, NULL, 5,    '2021-11-28');

-- Quick check — run these to confirm the schema loaded correctly
SELECT * FROM departments;
SELECT * FROM employees;
-- Q1
SELECT department,
AVG(salary) AS Average_Salary
FROM employees
GROUP BY department;
-- Q2
SELECT department,
AVG(salary) AS Average_Salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;
-- Q3
SELECT department,
COUNT(*) AS Total_Employees
FROM employees
GROUP BY department;
-- Q4
SELECT
e.name,
d.department_name,
d.location
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.id;
-- Q5
SELECT
e.name,
d.department_name
FROM employees e
LEFT JOIN departments d
ON e.dept_id=d.id;
-- Q6
SELECT *
FROM employees
WHERE salary >
(
SELECT AVG(salary)
FROM employees
);
-- Q7
SELECT department_name
FROM departments d
WHERE EXISTS
(
SELECT *
FROM employees e
WHERE e.dept_id=d.id
);
-- Q8
SELECT
e.name AS Employee,
m.name AS Manager
FROM employees e
LEFT JOIN employees m
ON e.manager_id=m.id;
-- Q9
SELECT
name,
salary,
bonus,
salary + COALESCE(bonus,0) AS Total_Pay
FROM employees;
-- Q10
SELECT *
FROM employees
WHERE YEAR(hire_date)=2021;

-- Q1
SELECT
    name,
    department,
    salary,
    RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS Salary_Rank
FROM employees;

-- Q2
SELECT *
FROM
(
    SELECT
        name,
        department,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS rn
    FROM employees
) AS ranked
WHERE rn <= 2;

-- Q3
SELECT
    name,
    salary,
    LEAD(salary) OVER (
        ORDER BY salary DESC
    ) AS Next_Salary
FROM employees;
-- Q4
WITH HighSalary AS
(
    SELECT *
    FROM employees
    WHERE salary > 60000
)

SELECT
    department,
    COUNT(*) AS Employee_Count
FROM HighSalary
GROUP BY department;

-- Q5
SELECT name
FROM employees
WHERE department = 'IT'

UNION

SELECT name
FROM employees
WHERE department = 'Sales';

-- Q6
SELECT
    d.department_name,
    d.location,
    COUNT(e.id) AS Employee_Count,
    AVG(e.salary) AS Average_Salary
FROM departments d
JOIN employees e
ON d.id = e.dept_id
GROUP BY
    d.department_name,
    d.location
HAVING AVG(e.salary) > 55000;

-- Q7
SELECT
    e.name,
    e.department,
    e.salary
FROM employees e
WHERE e.salary >
(
    SELECT AVG(salary)
    FROM employees
    WHERE department = e.department
);

-- Q8
SELECT
    e.name
FROM employees e
WHERE EXISTS
(
    SELECT *
    FROM employees m
    WHERE m.manager_id = e.id
);