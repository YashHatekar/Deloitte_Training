--1
select * from jobs
where min_salary > 10000

--2
select first_name,hire_date
from employees
where TO_CHAR(hire_date,'yyyy') between 2002 and 2005
order by hire_date

--3
select first_name,hire_date
from employees
where job_id in (select job_id from jobs where job_title in ('Programmer','Sales Manager'))
order by first_name

--4
select employee_id,first_name,hire_date
from employees
where to_char(hire_date,'yy') > 07 and to_char(hire_date,'DD') > 01

--5
select * 
from employees
where employee_id in (150,160)

--6
select first_name,salary,commission_pct,hire_date
from employees
where salary < 10000

--7
select job_title,max_salary-min_salary "Difference" 
from jobs
where max_salary between 10000 and 20000

--8
select first_name,salary,round(salary,-3)
from employees

--9
select *
from jobs
order by job_title desc

--10
select first_name,last_name
from employees
where upper(first_name) like ('S%') or upper(last_name) like ('S%')

--11
select first_name,last_name
from employees
where to_char(hire_date,'MON') = 'MAY'

--12
select * 
from employees
where department_id=30 and salary between 5000 and 10000 and commission_pct is null

--13
select first_name,last_day(hire_date) "Date of First Salary"
from employees

--14
select e.first_name,(j.end_date-j.start_date) "Experience(days)"
from employees e, job_history j
where e.employee_id=j.employee_id

--15
select first_name
from employees
where to_char(hire_date,'yy')=01

--16
select initcap(first_name),initcap(last_name)
from employees

--17
select regexp_substr(job_title,'[A-z]*')
from jobs

--18
select first_name,last_name,length(first_name) "length"
from employees
where last_name like ('___b%')

--19
select upper(first_name),lower(email)
from employees
where first_name = email

--20
select first_name,employee_id
from employees
where (extract(year from hire_date)) = (extract(year from sysdate))

--21
select (to_date(sysdate,'DD-MON-YY')-to_date('01-JAN-11','DD-MON-YY')) "Difference"
from dual

--22
select extract(month from hire_date) "Month no",count(employee_id) "Count"
from employees
where extract(year from hire_date) = 19
group by extract(month from hire_date)
order by extract(month from hire_date)

--23
select manager_id,count(employee_id)"Count"
from employees
group by manager_id

--24
select employee_id,max(end_date)
from job_history
group by employee_id

--25
select count(employee_id)"Count"
from employees
where extract(day from hire_date) > 15

--26
select country_id,count(city)"Count"
from locations
group by country_id

--27
select round(avg(salary),2)
from employees
where commission_pct is not null
group by department_id

--28
select job_id,count(employee_id)"count",sum(salary),(max(salary)-min(salary))"Difference"
from employees
group by job_id

-- employee on same date
select (count(e1.employee_id))"Count"
from employees e1,employees e2
where e1.hire_date=e2.hire_date and e1.employee_id<>e2.employee_id

--29
select job_id
from employees
having avg(salary)>10000
group by job_id

--30
select extract(year from hire_date)"Years"
from employees
having count(employee_id) > 10
group by extract(year from hire_date)

--31
--select department_name
--from departments
--where department_id in (
--select department_id 
--from employees 
--having (count(employee_id)>5) and commission_pct>0
--group by department_id
--)
--group by department_name
with comm as (
    select department_id, count(commission_pct) "CCount"
    from employees
    group by department_id
    having count(commission_pct)>5
)
select d.department_name, c.department_id
from departments d , comm c
where d.department_id = c.department_id


--32
select employee_id
from job_history
having count((end_date)) >1
group by employee_id

--33
select job_id
from employees
where (sysdate-hire_date)>100
group by job_id
having count(employee_id)>3

--34
select department_id,extract(year from hire_date)"Year",count(employee_id)"Count"
from employees
group by department_id,extract(year from hire_date)
order by department_id

--35
select department_id
from employees
where manager_id is not null
group by department_id
having count(employee_id)>5

--36
update employees set salary=8000
where employee_id=115 and salary<6000

--37
INSERT INTO EMPLOYEES VALUES (007,'yash','hatekar','ygmail.com','1234567890',to_date('03-FEB-19','DD-MON-YY'),'IT_PROG',50000,1,null,90)

--38
update employees set job_id = 'IT_PROG'
where employee_id=110 and department_id=10 and job_id<>'IT%'

--39
insert into departments values(1,'SYS_Administration',120,(select location_id from locations where city='Tokyo'))

--40
select d.department_name,count(e.employee_id)"COUNT"
from departments d,employees e
where e.department_id = d.department_id
group by department_name

--41
select j.job_title,jh.employee_id,(jh.end_date-jh.start_date)"DAYS"
from job_history jh,jobs j
where j.job_id=jh.job_id and jh.department_id = 30

--42
select d.department_name"DEPT_NAME",e.first_name"NAME"
from departments d , employees e
where e.department_id = d.department_id and e.employee_id = d.manager_id


--43
select d.department_name"DEPT_NAME",e.first_name"NAME",l.city"CITY"
from departments d , employees e, locations l
where e.department_id=d.department_id and e.employee_id=d.manager_id and d.location_id = l.location_id

--44
select c.country_name"NAME" , l.city"CITY",d.department_name"DEPT_NAME"
from countries c,departments d,locations l
where d.location_id=l.location_id and l.country_id=c.country_id

--45
select j.job_title"TITLE",d.department_name"NAME",e.last_name"LAST_NAME",jh.start_date"START_DATE"
from jobs j,departments d,employees e,job_history jh
where e.job_id = j.job_id and e.department_id = d.department_id and e.employee_id = jh.employee_id and to_char(hire_date,'yy')>=00 and to_char(hire_date,'yy')<=05

--46
select j.job_title"TITLE",avg(e.salary)"AVG_SALARY"
from jobs j,employees e
where e.job_id=j.job_id
group by job_title

--47
select j.job_title"TITLE",e.first_name"NAME",j.max_salary - e.salary "DIFFERENCE"
from jobs j ,employees e
where e.job_id = j.job_id

--48
select e.last_name"LAST NAME",j.job_title"TITLE"
from employees e,jobs j
where e.job_id = j.job_id and e.department_id = 30 and e.commission_pct is not null

--49
select j.job_id"JOB_ID",j.job_title"TITLE"
from jobs j , employees e
where e.job_id=j.job_id and e.salary>15000

--50
select d.department_name"DEPT_NAME",e.first_name"NAME",e.salary"SALARY"
from departments d, employees e
where e.department_id = d.department_id and d.manager_id = e.employee_id and extract(year from sysdate) - extract(year from hire_date) > 5

--51
select e1.first_name"NAME"
from employees e1 , employees e2 , departments d
where e2.employee_id = d.manager_id and e1.hire_date - e2.hire_date < 0

--52
select e.first_name"NAME",j.job_title"TITLE"
from jobs j , employees e,job_history jh
where e.job_id = j.job_id and e.job_id = jh.job_id and jh.end_date - jh.start_date <= 180

--53
select e.first_name"NAME",c.country_name"COUNTRY"
from employees e,departments d,countries c ,locations l
where e.department_id = d.department_id and d.location_id = l.location_id and l.country_id = c.country_id

--54
select d.department_name"DEPT_NAME",round(avg(e.salary),2)"AVG_SALARY",count(e.employee_id)"COUNT"
from employees e ,departments d
where e.department_id = d.department_id and e.commission_pct is not null
group by department_name

--55
select extract(month from jh.start_date)"JOINING MONTH"
from job_history jh,departments d,locations l
where jh.department_id = d.department_id and d.location_id = l.location_id and lower(l.city) = lower('Sydney')

--56
select d.department_id,d.department_name,d.manager_id,d.location_id
from departments d ,jobs j ,job_history jh
where d.department_id = jh.department_id and jh.job_id = j.job_id and j.max_salary > 10000

--57
select d.department_id,d.department_name
from departments d,employees e
where e.employee_id = d.manager_id and lower(e.first_name) = lower('Smith')

--58
select j.job_title
from jobs j ,employees e
where j.job_id = e.job_id and extract(year from e.hire_date) = extract(year from sysdate)

--59
select e.employee_id,e.first_name
from employees e,job_history jh
where not(e.job_id = jh.job_id and end_date is not null)

--60
select j.job_title,round(avg(e.salary),2)"AVG_SALARY"
from jobs j,job_history jh,employees e
where e.job_id = jh.job_id and jh.job_id=j.job_id and end_date is not null
group by job_title

--61
select c.country_name,l.city,count(d.department_id)"COUNT"
from countries c,locations l,departments d,employees e
where d.department_id = e.department_id and l.location_id = d.location_id and c.country_id = l.country_id
having count(e.employee_id)>5
group by country_name,city

--62
select e.employee_id,e.first_name,e.last_name,e.email
from employees e ,departments d
where e.employee_id = d.manager_id
group by employee_id
having count(e.employee_id) > 5

--63
select e.first_name,j.job_title,jh.start_date,jh.end_date
from jobs j,job_history jh ,employees e
where e.commission_pct is null

--64
select d.department_name
from departments d,employees e
where extract(year from e.hire_date) between 17 and 19

--65
select d.department_id,d.department_name
from departments d,employees e,job_history jh ,jobs j
where d.department_id=e.department_id and jh.employee_id = e.employee_id and j.job_id = e.job_id and j.max_salary >10000

--66
select e.employee_id ,e.job_id,j.job_title,e.salary
from employees e ,jobs j,job_history jh
where jh.job_id = e.job_id and j.job_id  = jh.job_id and jh.job_id = 'IT_PROG'

--67
select employee_id,first_name,email,salary,department_id
from employees
where (department_id,salary )in(
select department_id,max(salary)
from employees 
group by department_id
)

--68
select l.city
from employees e,departments d,locations l
where e.department_id = d.department_id and l.location_id = d.location_id and e.employee_id = 105