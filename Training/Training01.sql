
--07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
SELECT
    first_name, hire_date FROM employees
    where hire_date >= '070101'
    ;
    
--    이름이 Lex인 직원의 연봉을 출력

SELECT
    * FROM employees
    where first_name = 'Lex';
    
--    입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을
SELECT 
    * FROM employees
    where hire_date >= '040101'
    and hire_date <= '051231'
    order by hire_date desc
    ;
    
    
    
    SELECT first_name, salary
         FROM employees
         where salary in (2100, 3100, 4100)
        ;
        
        select first_name, last_name, salary
from employees
where first_name like '__a_';

select first_name, salary, commission_pct
from employees
where commission_pct is null
or employee_id is null;

select first_name,
lpad(first_name,10,'*'),
rpad(first_name,10,'*')
from employees;


select first_name, substr(first_name,1,3), substr(first_name,-3,2)
from employees
where department_id = 100;

select months_between(sysdate, hire_date)
from employees
where department_id = 110;

select sysdate
from employees;
select count(*), count(commission_pct)
from employees;

select count(*), max(salary), min(salary)
from employees;

--연봉(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 급여합계를 출력하세요

SELECT department_id, count(*), sum(salary)
     FROM employees
    GROUP BY department_id
    having sum(salary) >=20000
    ;

SELECT employee_id,
salary,
CASE WHEN job_id = 'AC_ACCOUNT' THEN salary + salary * 0.1
WHEN job_id = 'SA_REP' THEN salary + salary * 0.2
WHEN job_id = 'ST_CLERK' THEN salary + salary * 0.3
ELSE salary
END realSalary
FROM employees;


SELECT employee_id,
salary,
DECODE( job_id, 'AC_ACCOUNT', salary + salary * 0.1,
'SA_REP', salary + salary * 0.2,
'ST_CLERK', salary + salary * 0.3,
salary ) realSalary
FROM employees;

SELECT * from employees;

select round(123.346, 2) "r2",
round(123.456, 0) "r0",
round(123.456, -1) "r-1"
from dual;

SELECT  first_name,
        department_id
        case when department_id >= 10 and department_id <= 50 then 'A-Team'
             when department_id >= 60 and department_id <= 100 then 'B-Team'
             when department_id >= 110 and department_id <= 150 then 'C-Team'        
            else '팀없음'
        end as "team"
FROM employees
;

