--ASSIGNMENT I
--Create 2 tables with the primary and foreign keys. 
--Department and Employee table where Employee table has the foreign key of department id. 

-- Create department table
CREATE TABLE department (
    dept_id NUMERIC(10) NOT NULL,
    dept_name VARCHAR2(50),
    fieldarea_1 VARCHAR2(50),
    fieldarea_2 VARCHAR2(50),
    fieldarea_3 VARCHAR2(50),
    CONSTRAINT pk_department PRIMARY KEY (dept_id)   
);
-- Check the table was created successfully
DESC department;

-- Create employee table
CREATE TABLE employee (
    emp_id NUMERIC(10) NOT NULL,
    dept_id NUMERIC(10) NOT NULL,
    first_name VARCHAR2(50),
    middle_name VARCHAR2(50),
    last_name VARCHAR2(50),
    address VARCHAR2(50),
    CONSTRAINT fk_employee
    FOREIGN KEY (dept_id)
    REFERENCES department(dept_id)
);
-- Check the table was created successfully
DESC employee;

-- Inserting data into the department table
INSERT INTO department VALUES(1, 'Sales Department', 'Sales', 'Marketing', 'Sales Reporting');
INSERT INTO department VALUES(2, 'Inventory Department', null, 'Warehousing', 'Unloading');
INSERT INTO department VALUES(3, 'Admin Department', null, 'Warehousing', 'Unloading');
INSERT INTO department VALUES(4, '', null, '', null);

SELECT * FROM department;

-- 2.	Uses of COALESCE, NVL, NVL2, ISNULL with SQL syntax with a real-time scenario.
SELECT dept_name, 
    COALESCE(fieldarea_1, fieldarea_2, fieldarea_3), 
    NVL(fieldarea_1, fieldarea_2),
    NVL2(NVL(fieldarea_1, null), fieldarea_2, fieldarea_3) 
    FROM department;

-- Inserting data into the employee table
INSERT INTO employee VALUES(1, 1, 'Rakesh', '', 'Singh', 'Kathmandu');
INSERT INTO employee VALUES(2, 1, 'Sailesh', '', 'Jha', 'Pokhara');
INSERT INTO employee VALUES(3, 2, 'Arbind', 'Kumar', 'Shah', 'Butwal');
INSERT INTO employee VALUES(4, 2, 'Balkumari', '', 'Shrestha', 'Kathmandu');
INSERT INTO employee VALUES(5, 3, 'Tika', 'Devi', 'Gautam', 'Syangja');
INSERT INTO employee VALUES(6, 3, 'Krishna', 'Bahadur', 'Karki', 'Syangja');
INSERT INTO employee VALUES(7, 4, 'Jenish', 'Kumar', 'Oli', 'Butwal');
INSERT INTO employee VALUES(8, 4, 'Roshani', '', 'Gautam', 'Illam');
INSERT INTO employee (emp_id, dept_id, first_name, middle_name, last_name, address) VALUES(9, 1, 'Sapana', '', 'Poudel', 'Jhapa');
INSERT INTO employee (emp_id, dept_id, first_name, middle_name, last_name, address) VALUES(10, 2, 'Shrijana', 'Kumari', 'Thapaliya', 'Jhapa');
INSERT INTO employee (emp_id, dept_id, first_name, middle_name, last_name, address) VALUES(11, 4, 'Ekta', '', 'Dhakal', 'Gorkha');

-- 3.	Add manager column in employee table and return the employee with no manager and with the manager.
ALTER TABLE employee 
ADD manager VARCHAR2(50);

UPDATE employee 
SET manager = 'Sambriddhi'
WHERE address = 'Syangja';

SELECT * FROM employee;

--4.	Query to return the name of the employee with their respective manager. 
--If there is no manager, just return the value 'no manager'. 
SELECT first_name, NVL(manager, 'No Manager') FROM employee;


--5.  Uses of the wildcard.
--a.  Return the name of the employee whose name starts from a and whose third character is b. 
--    For example, you have two first_name in the employee table say abc and Ambika, then it should return Ambika. 
--b.  Return the first_name which starts with B and ends with N. 
--c.  Return the first_name which have "am" anywhere in that column
SELECT first_name FROM employee WHERE LOWER(first_name) LIKE 'a_b%';
SELECT first_name FROM employee WHERE LOWER(first_name) LIKE 'b%n';
SELECT first_name FROM employee WHERE LOWER(first_name) LIKE '%am%';


--6.	Add column salary and find the full_name of the employee 
--i.e first_name + middle_name + last_name from the employee table, salary, and "greater than or smaller" info under compare column 
--whose salary is greater than the average salary of the employee. It should return like (let's say our average salary is 10000)

--Full_name Salary Compare
--Ram Shrestha 20000 Greater
--Ram Hari 10000 Equals
--Ram Maya 8000 Lesser.

ALTER TABLE employee
ADD salary NUMBER;

DESC employee;

UPDATE employee SET salary = 10000 WHERE address='Kathmandu';
UPDATE employee SET salary = 50000 WHERE address='Pokhara';
UPDATE employee SET salary = 65000 WHERE address='Illam';
UPDATE employee SET salary = 90000 WHERE address='Butwal';
UPDATE employee SET salary = 45000 WHERE address='Gorkha';
UPDATE employee SET salary = 98000 WHERE address='Syangja';
UPDATE employee SET salary = 85000 WHERE address='Jhapa';
UPDATE employee SET salary = 80000 WHERE ADDRESS='Jhapa' AND dept_id=2;

WITH selection1 AS (
    SELECT AVG(salary) AS avg_salary FROM employee a
)
SELECT a.first_name||' '||a.middle_name||' '||a.last_name AS full_name, a.salary, 
CASE 
    WHEN a.salary > b.avg_salary THEN 'Greater'
    WHEN a.salary = b.avg_salary THEN 'Equal'
ELSE 'Lower'
END AS COMPARE
FROM employee a, selection1 b;

--7.	Find the full_name of the employee 
--i.e first_name + middle_name + last_name from the employee table, salary, 
--and "greater than or smaller" info under compare column whose salary is 
--greater than the average salary of the employee of the Admin department. 
--It should return like (let's say our average salary of Admin department is 5000) 
--Full_name Salary Compare
--Ram Shrestha 20000 Greater
--Ram Hari 10000 Equals
--Ram Maya 8000 Lesser.

WITH selection1 AS (
    SELECT AVG(salary) as avg_salary from employee e
    JOIN department d
    ON d.dept_id = e.dept_id
    WHERE d.dept_name = 'Admin Department'
)
SELECT e.first_name||' '||e.middle_name||' '||e.last_name as employee_name,
e.salary,
CASE 
    WHEN e.salary > s.avg_salary then 'Greater'
    WHEN e.salary = s.avg_salary then 'Equals'
    ELSE 'Lower'
END AS compare
FROM employee e, selection1 s;
    
-- 8. Task on typecasting. Create a table File_Info with column id, filename, 
--    and process_date. Process date column must contain the date and time part. 
--    Now, Convert the time from process_date into various format
--    a. YYYY-mm-dd 2022-01-05
--    b. YYYY/mm/dd. 2022/01/05
--    c. mm-dd-YYYY 01-05-2022

CREATE table file_Info(
    id NUMERIC(10) NOT NULL,
    filename VARCHAR2(50),
    process_date DATE
)

DESC file_info;

INSERT INTO file_info VALUES (1, 'abc.txt', TO_DATE('2022/05/01 11:45:15', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO file_info VALUES (1, 'def.txt', TO_DATE('2021/05/02 23:54:15', 'yyyy/mm/dd hh24:mi:ss'));
INSERT INTO file_info VALUES (1, 'ghi.txt', sysdate);

SELECT filename, process_date, TO_CHAR(process_date, 'YYYY-MM-DD HH24:MI:SS'),
TO_CHAR (process_date, 'YYYY/MM/DD HH24:MI:SS'), TO_CHAR(process_date, 'MM-DD-YYYY HH24:MI:SS') from file_info;


-- 9. Find the count of employees who are not assigned to any departments (using the set operator)
SELECT COUNT(*) from employee e
JOIN department d
ON d.dept_id = e.dept_id
where d.dept_name is NULL;