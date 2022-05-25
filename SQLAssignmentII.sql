-- ASSIGNMENT II
show user;
show con_name;
--1. Create your own DB and schema
--   Format for DB: YourName_DB
--   Format for Schema: YourName

-- create database
CREATE DATABASE pratima_gautam_db
     DATAFILE 'pratima_gautam_db' SIZE 10M
     LOGFILE 
        GROUP 1 ('pratima_gautam_log1a', 'pratima_gautam_log1b') SIZE 500K,
        GROUP 2 ('pratima_gautam_log2a', 'pratima_gautam_log2b') SIZE 500K;
     
-- database schema 
CREATE USER pratima_gautam
  IDENTIFIED BY pass
  DEFAULT TABLESPACE tbs_sk_1
  TEMPORARY TABLESPACE tbs_sk_1
  QUOTA 20M on tbs_sk_1;    

CREATE TABLE DEPARTMENT(
    Dep_id NUMBER,
    Dep_name VARCHAR2(50),
    PRIMARY KEY(Dep_id)
);

INSERT INTO DEPARTMENT(Dep_id, Dep_name) VALUES (1, 'BI');
INSERT INTO DEPARTMENT(Dep_id, Dep_name) VALUES (2, 'HR');
INSERT INTO DEPARTMENT(Dep_id, Dep_name) VALUES (3, 'Admin');
INSERT INTO DEPARTMENT(Dep_id, Dep_name) VALUES (4, 'Infra');

SELECT * FROM DEPARTMENT;

CREATE TABLE EMPLOYEE(
Emp_id NUMBER,
Emp_fname VARCHAR(256),
Emp_lname VARCHAR(256),
Emp_address VARCHAR(256),
Dep_id NUMBER,
primary key (Emp_id),
FOREIGN KEY (Dep_id) references DEPARTMENT(Dep_id));

INSERT INTO EMPLOYEE(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) VALUES (1,'Ram','Sharma','Kupondole',2);
INSERT INTO EMPLOYEE(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) VALUES (2,'Hari','Maharjan','Thapathali',3);
INSERT INTO EMPLOYEE(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) VALUES (3,'Rajendra','Shrestha','Mangalbazar',1);
INSERT INTO EMPLOYEE(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) VALUES (4,'Binod','Ghimire','Bouddha',2);
INSERT INTO EMPLOYEE(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) VALUES (5,'Isha','Poudel','Nakhu',1);
INSERT INTO EMPLOYEE(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) VALUES (6,'Reema','Dahal','Sukedhara',1);
INSERT INTO EMPLOYEE(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) VALUES (7,'Puja','Ray','Baliphal',4);
INSERT INTO EMPLOYEE(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) VALUES (8,'Deepak','Basnet','Tripureshwor',3);
INSERT INTO EMPLOYEE(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) VALUES (9,'Girija','Sharma','Sundhara',1);
INSERT INTO EMPLOYEE(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) VALUES (10,'Ricky','Maharjan','Pulchowk',4);
INSERT INTO EMPLOYEE(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) VALUES (11,'Manik','Thakuri','Banepa',3);
INSERT INTO EMPLOYEE(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) VALUES (12,'Yeshwant','Budathoki','Kamalpokhari',3);
INSERT INTO EMPLOYEE(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) VALUES (13,'Hasina','Karmacharya','Gabahal',2);
INSERT INTO EMPLOYEE(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) VALUES (14,'Ganesh','Gyawali','Butwal',1);
INSERT INTO EMPLOYEE(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) VALUES (15,'Nirajan','Nepal','Chabahil',1);
INSERT INTO EMPLOYEE(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) VALUES (16,'Jenish','Shrestha','Manbhawan',1);
INSERT INTO EMPLOYEE(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) VALUES (17,'Sneha','Dahal','Kumaripati',1);

SELECT * FROM EMPLOYEE;
--  2. Find the total number of employees in each Department by 
--  creating and inserting data into two tables as given below:
--  Output:Dep_name Total_Employee

SELECT d.dep_name, COUNT(*) AS total_employee 
FROM employee e 
    INNER JOIN department d on e.dep_id = d.dep_id
GROUP BY d.dep_name;

-- With WHERE and GROUPBY
SELECT d.dep_name, count(e.emp_id) AS total_employee
FROM employee e, department d
WHERE e.dep_id = d.dep_id
GROUP BY d.dep_id, d.dep_name;

-- 3. Find out who earns the maximum salary and in which department do they belong:
CREATE TABLE Salary (
Salary_id NUMBER,
Emp_id NUMBER,
Salary NUMBER,
primary key (Salary_id),
FOREIGN KEY (Emp_id) references EMPLOYEE(Emp_id));

INSERT INTO SALARY(Salary_id, Emp_id, Salary) VALUES (1,16,40000);
INSERT INTO SALARY(Salary_id, Emp_id, Salary) VALUES (2,15,26000);
INSERT INTO SALARY(Salary_id, Emp_id, Salary) VALUES (3,14,36000);
INSERT INTO SALARY(Salary_id, Emp_id, Salary) VALUES (4,13,59000);
INSERT INTO SALARY(Salary_id, Emp_id, Salary) VALUES (5,12,94000);
INSERT INTO SALARY(Salary_id, Emp_id, Salary) VALUES (6,11,77000);
INSERT INTO SALARY(Salary_id, Emp_id, Salary) VALUES (7,10,65000);
INSERT INTO SALARY(Salary_id, Emp_id, Salary) VALUES (8,9,90000);
INSERT INTO SALARY(Salary_id, Emp_id, Salary) VALUES (9,8,87600);
INSERT INTO SALARY(Salary_id, Emp_id, Salary) VALUES (10,7,66500);
INSERT INTO SALARY(Salary_id, Emp_id, Salary) VALUES (11,6,89760);
INSERT INTO SALARY(Salary_id, Emp_id, Salary) VALUES (12,5,23456);
INSERT INTO SALARY(Salary_id, Emp_id, Salary) VALUES (13,4,55400);
INSERT INTO SALARY(Salary_id, Emp_id, Salary) VALUES (14,3,78650);
INSERT INTO SALARY(Salary_id, Emp_id, Salary) VALUES (15,2,54379);
INSERT INTO SALARY(Salary_id, Emp_id, Salary) VALUES (16,1,93765);
INSERT INTO SALARY(Salary_id, Emp_id, Salary) VALUES (17,17,28765);

-- Find out who earns the maximum salary and in which department do they belong:
-- Output: Emp_name, Max_salary, Dep_name

SELECT * FROM department;
SELECT * FROM employee;
SELECT * FROM salary;

-- maximum salary per department
SELECT dep_name, MAX(salary) FROM (
SELECT
    e.emp_fname,
    s.salary,
    d.dep_name
FROM employee e
JOIN salary s
    ON s.emp_id = e.emp_id
JOIN department d
    ON d.dep_id = e.dep_id
    ORDER BY s.salary desc
) GROUP BY dep_name;

select * from employee;

-- Find out who earns the maximum salary and in which department do they belong:
-- Output: Emp_name, Max_salary, Dep_name

-- Solution Way 1
SELECT e.emp_fname, MAX(salary), d.dep_name
FROM employee e
INNER JOIN salary s
    ON e.emp_id = s.emp_id
INNER JOIN department d
    ON e.dep_id = d.dep_id
GROUP BY e.emp_fname, d.dep_name
HAVING MAX(s.salary) = (SELECT MAX(salary) FROM Salary);

-- Solution Way 2
with sel as (
    select *
    from employee ep
    join salary sa
    on sa.emp_id = ep.emp_id
    join department dep
    on dep.dep_id = ep.dep_id
    order by sa.salary desc
)
select emp_fname, salary as max_salary, Dep_name
from sel
where rownum<2;

--select * from salary order by salary;

--4.	Add a new column Tax_Percentage,Tax_Amount, Net_salary where calculation of Tax_Amount:
--Salary < 35000 = 5% of Salary
--Salary < 55000 = 10% of Salary
--Salary < 75000= 15% of Salary
--Salary < 95000=20% of Salary
--
--Use appropriate datatype.

ALTER TABLE salary 
ADD (
    tax_percentage NUMBER,
    tax_amount NUMBER,
    net_salary NUMBER
);

SELECT * FROM SALARY;

UPDATE salary SET 
        tax_percentage = CASE WHEN salary < 35000 THEN 5
                              WHEN salary < 55000 THEN 10
                              WHEN salary < 75000 THEN 15
                              WHEN salary < 95000 THEN 20
                         END,
        tax_amount = CASE WHEN salary < 35000 THEN 0.05* salary
                          WHEN salary < 55000 THEN 0.10* salary
                          WHEN salary < 75000 THEN 0.15* salary
                          WHEN salary < 95000 THEN 0.20* salary
                     END,
        net_salary = CASE WHEN salary < 35000 THEN (salary - 0.05*salary)
                          WHEN salary < 55000 THEN (salary - 0.10*salary)
                          WHEN salary < 75000 THEN (salary - 0.15*salary)
                          WHEN salary < 95000 THEN (salary - 0.20*salary)
                    END;
select * from salary;
DESC salary;

--5.	Using CTE find out the second highest salary in each department (Use Net_Salary)
with sel1 as (
    select *
    from employee emp
    join salary sal
    on sal.emp_id = emp.emp_id
    join department dep
    on dep.dep_id = emp.dep_id
),
sel2 as (
    select dep_name, net_salary,
    dense_rank() over (partition by dep_name order by salary desc) as salary_order
    from sel1 
)
select dep_name, net_salary from sel2 where salary_order = 2;

-- using net salary to find the second highest salary
with sel1 as (
    select *
    from employee emp
    join salary sal
    on sal.emp_id = emp.emp_id
    join department dep
    on dep.dep_id = emp.dep_id
),
sel2 as (
    select dep_name, salary,
    dense_rank() over (partition by dep_name order by salary desc) as salary_order
    from sel1 
)
select dep_name, salary from sel2 where salary_order = 2;

--6.	Create an Merge update statement to update the Target table "Employee" 
--using the following Source Table "SourceEmployee"
CREATE TABLE SourceEmployee(
Emp_id NUMBER,
Emp_fname VARCHAR(256),
Emp_lname VARCHAR(256),
Emp_address VARCHAR(256),
Dep_id NUMBER,
primary key (Emp_id),
FOREIGN KEY (Dep_id) references DEPARTMENT(Dep_id) );

INSERT INTO SourceEmployee (Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) 
    VALUES (6,'Reema','Dahal','Basundhara',1);
INSERT INTO SourceEmployee(Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) 
    VALUES (17,'Sneha','Poudel','Kumaripati',1);
INSERT INTO SourceEmployee (Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) 
    VALUES(10,'Ricky','Maharjan','Pulchowk',4);
INSERT INTO SourceEmployee (Emp_id, Emp_fname, Emp_lname, Emp_address, Dep_id) 
    VALUES(18,'Leena','Pradhan','Pulchowk',3);

SELECT * FROM employee;
SELECT * FROM SourceEmployee;

MERGE INTO employee TARGET
USING (SELECT emp_id, emp_fname, emp_lname, emp_address, dep_id FROM SourceEmployee) SOURCE
ON (SOURCE.emp_id = TARGET.emp_id)
-- For Inserts
WHEN NOT MATCHED THEN
    INSERT (TARGET.emp_id, TARGET.emp_fname, TARGET.emp_lname, TARGET.emp_address, TARGET.dep_id) 
    VALUES (SOURCE.emp_id, SOURCE.emp_fname, SOURCE.emp_lname, SOURCE.emp_address, SOURCE.dep_id)
-- For Updates
WHEN MATCHED THEN 
    UPDATE SET
        Target.emp_fname   = Source.emp_fname,
        Target.emp_lname   = Source.emp_lname,
        Target.emp_address = Source.emp_address,
        Target.dep_id      = Source.dep_id
    WHERE SOURCE.emp_id = TARGET.emp_id;

SELECT * FROM employee;

--7.	Find out the names of employees that are not going to the company event
CREATE TABLE Company_Event(
Event_id NUMBER,
Emp_id NUMBER,
Emp_name VARCHAR(256),
Emp_address VARCHAR(256),
Dep_id NUMBER,
primary key (Event_id),
FOREIGN KEY (Emp_id) references EMPLOYEE(Emp_id),
FOREIGN KEY (Dep_id) references DEPARTMENT(Dep_id));

INSERT INTO Company_Event (Event_id,Emp_id,Emp_name,Emp_address,Dep_id) 
    VALUES (1,10,'Ricky Maharjan','Pulchowk',4);
INSERT INTO Company_Event (Event_id,Emp_id,Emp_name,Emp_address,Dep_id) 
    VALUES (2,6,'Reema Dahal','Basundhara',1);
INSERT INTO Company_Event (Event_id,Emp_id,Emp_name,Emp_address,Dep_id) 
    VALUES (3,1,'Ram Sharma','Kupondole',2);
INSERT INTO Company_Event (Event_id,Emp_id,Emp_name,Emp_address,Dep_id) 
    VALUES (4,8,'Deepak Basnet','Tripureshwor',3);
INSERT INTO Company_Event (Event_id,Emp_id,Emp_name,Emp_address,Dep_id) 
    VALUES (5,16,'Jenish Shrestha','Manbhawan',1);
INSERT INTO Company_Event (Event_id,Emp_id,Emp_name,Emp_address,Dep_id) 
    VALUES (6,5,'Isha Poudel','Nakhu',1);
INSERT INTO Company_Event (Event_id,Emp_id,Emp_name,Emp_address,Dep_id) 
    VALUES (7,3,'Rajendra Shrestha','Mangalbazar',1);
INSERT INTO Company_Event (Event_id,Emp_id,Emp_name,Emp_address,Dep_id) 
    VALUES (8,7,'Puja Ray','Baliphal',4);

SELECT * FROM company_event;

SELECT emp_fname || ' ' || emp_lname FROM employee WHERE emp_id 
NOT IN
    (SELECT emp_id FROM company_event);

DROP TABLE DEPARTMENT;
DROP TABLE EMPLOYEE;
DROP TABLE SALARY;
DROP TABLE SOURCEEMPLOYEE;
DROP TABLE COMPANY_EVENT;