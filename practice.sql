show databases;

create database pratima_db;

show databases;

use pratima_db;

show tables;

create table users(name varchar(100));

show tables;

select * from users;

insert into users values ("Ambika Maharjan");
insert into users values ("Rohit Sharma");
insert into users values ("Sonika Gurung");
insert into users values ("Junee Thapa");

select * from users;

drop table users;
drop database pratima_db;

select user(); -- information of current user
select version(); -- exact version of MySQl
select databse(); -- which database you are already in

select schema_name from information_schema.schemata;

-- extracting table names from specific database
select table_name from information_schema.tables where table_schema="database_name";

