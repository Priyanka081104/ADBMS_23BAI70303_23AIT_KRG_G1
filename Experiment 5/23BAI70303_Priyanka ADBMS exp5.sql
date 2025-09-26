---Medium Exp 5
CREATE TABLE transaction_data (
    id INT,
    value INT
);
Drop table if exists transaction_data 

-- For id = 1
INSERT INTO transaction_data (id, value)
SELECT 1, random() * 1000  -- simulate transaction amounts 0-1000
FROM generate_series(1, 1000000);

-- For id = 2
INSERT INTO transaction_data (id, value)
SELECT 2, random() * 1000
FROM generate_series(1, 1000000);

SELECT *FROM transaction_data
---------
CREATE TABLE Sales (
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    order_date DATE
);
INSERT INTO Sales VALUES
(1, 101, 2, 500.00, '2025-09-01'),
(2, 102, 1, 1200.00, '2025-09-02'),
(3, 101, 5, 500.00, '2025-09-03'),
(4, 103, 3, 300.00, '2025-09-04');
CREATE VIEW sales_summary AS
SELECT 
    SUM(quantity) AS total_quantity_sold,
    SUM(quantity * price) AS total_sales
FROM Sales;
SELECT * FROM sales_summary;

------
CREATE MATERIALIZED VIEW sales_summary_mv AS
SELECT 
    SUM(quantity) AS total_quantity_sold,
    SUM(quantity * price) AS total_sales
FROM Sales;
SELECT * FROM sales_summary_mv;
DROP VIEW IF EXISTS sales_summary;


-----Hard problem
CREATE TABLE Employees (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    department VARCHAR(50)
);
INSERT INTO Employees (emp_id, emp_name, salary, department)
VALUES
(1, 'Alice', 5000, 'HR'),
(2, 'Bob', 6000, 'IT'),
(3, 'Charlie', 5500, 'HR'),
(4, 'David', 7000, 'IT'),
(5, 'Eve', 6500, 'Finance');

CREATE VIEW dept_salary_summary AS
SELECT 
    department,
    AVG(salary) AS avg_salary,
    COUNT(emp_id) AS total_employees
FROM Employees
GROUP BY department;

REVOKE ALL ON Sales FROM Priyanka;
GRANT SELECT ON sales_summary TO Priyanka;
GRANT SELECT ON sales_summary_mv TO Priyanka;


