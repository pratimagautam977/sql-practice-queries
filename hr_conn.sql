-- hr 
select * from hr.employees;
select * from hr.departments;

select
    a.full_name,
    a.hire_date,
    a.salary,
    a.department_name,
    a.manager_name
from(
select 
    emp1.first_name || ' ' || emp1.last_name as full_name,
    emp.salary,
    emp.hire_date,
    emp.department_id,
    dep.department_name,
    emp.manager_id,
    emp.first_name || ' ' || emp.last_name as manager_name,
    row_number() over(partition by emp.department_id, emp.manager_id ORDER BY emp.hire_date desc) as rn
from hr.employees emp
left join hr.departments dep 
on
    emp.department_id = dep.department_id
left join
    hr.employees emp1
on
    emp.manager_id = emp1.manager_id
) a
where rn=1;

