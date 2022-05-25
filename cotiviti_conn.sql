SELECT * FROM all_tables;

select * from hr.employees;

select * from hr.employees;
select * from hr.departments;
select * from hr.locations;

select * from hr.employees
where employee_id='100';

-- distinct
select distinct(location_id) from hr.departments;
select count(salary), count(distinct(salary)) from hr.employees;

select first_name, last_name, email from hr.employees
where department_id='90';

-- Order by
select * from hr.employees ORDER BY first_name DESC;

-- by default order by is ascending

select * from employees order by commission_pct desc;


-- IF NULLS only written then null is taken to first
-- NULLS LAST

-- default NULLS first
SELECT * from hr.employees ORDER BY COMMISSION_PCT desc;
SELECT * from hr.employees ORDER BY COMMISSION_PCT desc NULLS first; --same result because by default NULL is first
SELECT * from hr.employees ORDER BY COMMISSION_PCT desc NULLS last;

SELECT * FROM hr.employees ORDER BY 2,3 desc;

SELECT sysdate FROM DUAL;
select * from dual;

select rpad('computer',15,'*'), rpad('computer',15,'*#') from dual;

select * from hr.employees;
select * from hr.departments;
select * from all_tables;

select instr('information','o',4,1), instr('information','o',4,2) from dual;

 -- to find the position
select instr('information','o'), instr('information','o') from dual;

-- join is better in performance than the merge and subquery

-- datatypes
-- varchar2, char, date, number, integer

-- create table
--CREATE TABLE table_name(
--    col1 datatype,
--    col2 datatype,
--    ...
--);

-- drop table

-- create table with primary key
-- one primary key in a table, 

CREATE TABLE table_parent(
    section CHAR(1) NOT NULL,
    std_id NUMBER NOT NULL,
    std_firstname VARCHAR2(50),
    std_lastname VARCHAR2(50),
    CONSTRAINTS pk_std PRIMARY KEY (section, std_id)
);

DROP table table_parent;

CREATE TABLE TABLE_CHILD(
    std_id NUMBER NOT NULL, 
    section CHAR(1) NOT NULL,
    fullname VARCHAR2(100),
    CONSTRAINTS pk_child PRIMARY KEY (std_id, section),
    FOREIGN KEY (std_id, section)
    REFERENCES table_parent (section, std_id)
);

select * from table_parent;
select * from table_child;
-- UNIQUE key and primary key -> primary key has not null, but UNIQUE key accepts null value. 
-- A table has one primary key but multiple unique key.

-- Day 3
-- most used datatypes
-- varchar2, char, date, number, integer

-- CREATE TABLE SYNTAX
--create table table_name(
--    col1 datatype,
--    col2 datatype,
--    ....
--)

-- temporary tables in cotiviti zzz
CREATE TABLE table_student(
    std_id VARCHAR2(20),
    std_name VARCHAR2(50)
);

DESC table_student;

SELECT * FROM table_student;

-- DROP SYNTAX
-- DROP TABLE table_name;
DROP TABLE table_student;

TRUNCATE TABLE table_student;

-- FOREIGN KEY CONCEPT
-- PARENT KEY
CREATE TABLE table_parent(
    section CHAR(1) NOT NULL,
    std_id NUMBER NOT NULL,
    std_firstName VARCHAR2(50),
    std_lastName VARCHAR2(50),
    CONSTRAINTS pk_std_info PRIMARY KEY (section, std_id)
);

-- CHILD TABLE
CREATE TABLE table_child(
    std_id NUMBER NOT NULL,
    section CHAR(1) NOT NULL,
    fullname VARCHAR2(100),
    CONSTRAINTS pk_child PRIMARY KEY(std_id, section),
    FOREIGN KEY (std_id, section)
    REFERENCES table_parent(std_id, section)
);

-- CREATE TABLE WITH PRIMARY KEY; one primary key in a table
CREATE TABLE table_student(
    section CHAR(1) NOT NULL,
    std_id NUMBER NOT NULL,
    std_firstname VARCHAR2(50),
    std_lastname VARCHAR2(50),
    CONSTRAINTS pk_std_info PRIMARY KEY (section, std_id)
);

-- INSERT
INSERT INTO table_student VALUES ('A', 001, 'Ram', 'KC');
INSERT INTO table_student VALUES ('B', 001, 'Sita', 'Sharma');
INSERT INTO table_student VALUES ('A', 002, 'Hari', 'KC');

-- UNION and UNION ALL
INSERT INTO table_student(
    SELECT 'A','1234', 'lfdkjsaldfkaj', 'dfd' FROM DUAL UNION
    SELECT 'B','123', 'lfdkjsaldfkaj', 'dfd' FROM DUAL UNION
    SELECT 'C','243', 'lfdkjsaldfkaj', 'dfd' FROM DUAL UNION
    SELECT 'A','1234', 'lfdkjsaldfkaj', 'dfd' FROM DUAL UNION
    SELECT 'C','23', 'lfdkjsaldfkaj', 'dfd' FROM DUAL UNION
    SELECT 'D','2352', 'lfdkjsaldfkaj', 'dfd' FROM DUAL UNION
);


-- Merge Update
-- Left Join

CREATE TABLE TEMP_EMP AS
SELECT * FROM HR.EMPLOYEES;
SELECT * FROM HR.DEPARTMENTS;

desc TEMP_EMP;

SELECT * FROM TEMP_EMP;

ALTER TABLE TEMP_EMP
ADD DEPARTMENT_NAME VARCHAR2(40);

-- MERGE STATEMENT 
MERGE INTO TEMP_EMP TARGET
USING
(
SELECT
    department_id, 
    department_name
FROM
(
SELECT distinct 
    department_id, 
    department_name,
    row_number() over(partition by department_id order by department_id) as rn
FROM hr.departments
) WHERE rn = 1
) SOURCE
ON 
    (TARGET.DEPARTMENT_ID = SOURCE.DEPARTMENT_ID)
WHEN MATCHED THEN UPDATE
SET
    TARGET.DEPARTMENT_NAME = SOURCE.DEPARTMENT_NAME
;

SELECT * FROM temp_emp;

-- Level of Aggregation (LOA) - elig -> member_id, demographic information (first_name, last_name, gender, DOB)

-- create table

--CREATE TABLE zzz_test as
--SELECT distinct 
--    department_id, 
--    department_name,
--    row_number() over(partition by department_id order by department_id) as rn
--FROM hr.departments
--
--DROP table zzz_test;


-- questions provided by Dipak Shah 
create table student(
    sid int not null,
    fname varchar2(255),
    lname varchar2(255),
    address varchar2(255),
    age number,
    gender char,
    dob date
);

drop table student;

insert all 
    into student(sid,fname,lname,address,age,gender,dob) values(100,'sabin','moktan','pokhara','24','m',to_date('12-12-1999', 'dd-mm-yyyy'))
    into student(sid,fname,lname,address,age,gender,dob) values(101,'ram','shrestha','kathmandu','23','m',to_date('12-12-2002', 'dd-mm-yyyy'))
    into student(sid,fname,lname,address,age,gender,dob) values(102,'bikash','tiruwa','kailali','25','m',to_date('12-12-2003', 'dd-mm-yyyy'))
    into student(sid,fname,lname,address,age,gender,dob) values(103,'hari','karki','nepalgunj','28','m',to_date('12-12-2004', 'dd-mm-yyyy'))
    into student(sid,fname,lname,address,age,gender,dob) values(104,'geeta','basnet','pokhara','21','f',to_date('12-12-2020', 'dd-mm-yyyy'))
    into student(sid,fname,lname,address,age,gender,dob) values(105,'sabin','moktan','pokhara','24','m',to_date('12-12-1999', 'dd-mm-yyyy'))
    into student(sid,fname,lname,address,age,gender,dob) values(106,'bikash','tiruwa','kailali','25','m',to_date('12-12-2003', 'dd-mm-yyyy'))
    into student(sid,fname,lname,address,age,gender,dob) values(107,'hari','karki','nepalgunj','28','m',to_date('12-12-2004', 'dd-mm-yyyy'))
    into student(sid,fname,lname,address,age,gender,dob) values(108,'sita','shrestha','janakpur','28','f',to_date('12-12-2003', 'dd-mm-yyyy'))
select 1 from dual;
--select * from dual;

select * from student;
delete from student;

--q1. find duplicate rows from student table using row_number or any other way if possible?
select sid, count(sid) AS "COUNT" from student GROUP BY sid having count(sid)>1;

--HAVING is important here because unlike WHERE, HAVING filters on aggregate functions.

SELECT a.* 
FROM student a
JOIN ( 
    SELECT fname, lname, address, age, gender, dob, COUNT(*) 
    FROM student
    GROUP BY fname, lname, address, age, gender, dob
    HAVING COUNT(*) > 1
) b
ON
    a.fname = b.fname AND
    a.lname = b.lname AND
    a.address = b.address AND
    a.age = b.age AND
    a.dob = b.dob
ORDER BY a.fname
 
 
SELECT fname, lname, address, age, gender, dob, COUNT(*)
FROM student
GROUP BY fname, lname, address, age, gender, dob
-- in order to work with the row deletion, we need to work on the row numbers with count more than 1
HAVING count(*) > 1

 
--q2. delete duplicate rows from student?

-- Using GROUP BY clause and MAX()
DELETE FROM student WHERE sid NOT IN(
SELECT MAX(sid) FROM student GROUP BY fname,lname, address, age, gender, dob);

SELECT * FROM student;

-- USING CTE and ROW_NUMBER()

WITH DUPLICATE_CTE AS (
    SELECT sid, fname, lname, address, age, gender, dob,
    ROW_NUMBER() OVER (PARTITION BY fname, lname, address, age, gender, dob ORDER BY sid)  AS DupCount
    FROM student
    )
    select sid from DUPLICATE_CTE
DELETE from DUPLICATE_CTE WHERE DupCount>1;

-- another way
DELETE FROM student where sid in (
WITH cte as (
    SELECT sid,fname, lname, address, age, gender, dob,
    ROW_NUMBER() OVER (PARTITION BY fname, lname, address, age, gender, dob ORDER BY sid)  AS DupCount
    FROM student
)
select * from cte
WHERE DupCount > 1
);

--q3. find who can earn max salary in each department?






