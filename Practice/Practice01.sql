--SQL Practice01 기본 SQL 문제

--문제 1. 
--전체직원의 다음 정보를 조회하세요. 정렬은 입사일(hire_date)의 올림차순(ASC)으로 가장 선임부터 출력이 되도록 하세요. 이름(first_name last_name),  월급(salary),  전화번호(phone_number), 입사일(hire_date) 순서이고 “이름”, “월급”, “전화번호”, “입사일” 로 컬럼이름을 대체해 보세요.
select  first_name || last_name 이름,
        salary 월급,
        phone_number 전화번호,
        hire_date 입사일
FROM employees
order by hire_date asc
;



--문제2.
--업무(jobs)별로 업무이름(job_title)과 최고월급(max_salary)을 월급의 내림차순(DESC)로 정렬하세요.
select  job_title as "업무이름",
        max_salary 최고월급
FROM jobs, employees
ORDER by salary desc
;


--문제3.
--담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.

select   first_name || last_name 이름,
        manager_id 매니저아이디, 
        commission_pct 커미션비율,
        salary 월급
from employees 
where salary > 3000 
and commission_pct is null
;


--문제4.
--최고월급(max_salary)이 10000 이상인 업무의 이름(job_title)과 최고월급(max_salary)을 최고월급의(max_salary) 내림차순(DESC)로 정렬하여 출력하세요.    
select   job_title 업무이름,
        max_salary 최고월급
from jobs
where max_salary >= 10000
order by max_salary desc
;


--문제5.
--월급이 14000 미만 10000 이상인 직원의 이름(first_name), 월급, 커미션퍼센트 를  월급순(내림차순) 출력하세오. 단 커미션퍼센트 가 null 이면 0 으로 나타내시오
SELECT  first_name 직원이름,
        salary 월급,
        commission_pct 커미션퍼센트
FROM employees
where salary < 14000
and salary > 10000
order by salary desc
;


--문제6.
--부서번호가 10, 90, 100 인 직원의 이름, 월급, 입사일, 부서번호를 나타내시오
--입사일은 1977-12 와 같이 표시하시오

SELECT  last_name || first_name 직원이름,
        salary 월급,
        to_char(hire_date, 'yYYy-mm') 입사일,
        department_id 부서번호
FROM employees
where department_id = 10
or department_id = 90
or department_id = 100
;

--문제7.
--이름(first_name)에 S 또는 s 가 들어가는 직원의 이름, 월급을 나타내시오
SELECT  last_name || first_name 직원이름,
        salary 월급
FROM employees
where first_name like '%S%'
or first_name like '%s%'
;


--문제8.
--전체 부서를 출력하려고 합니다. 순서는 부서이름이 긴 순서대로 출력해 보세오.
SELECT  *
FROM departments
--where department_name
order by length(department_name)
;

--문제9.
--정확하지 않지만, 지사가 있을 것으로 예상되는 나라들을 나라이름을 대문자로 출력하고
--올림차순(ASC)으로 정렬해 보세오.

select UPPER(country_name) 나라이름_대문자
from countries
--where 지사가 있을곳 예상 제외
order by country_name asc
;

--문제10.
--입사일이 03/12/31 일 이전 입사한 직원의 이름, 월급, 전화 번호, 입사일을 출력하세요
--전화번호는 545-343-3433 과 같은 형태로 출력하시오.

SELECT
last_name || first_name 직원이름,
salary 월급,

replace(Phone_number, '.', '-') 전화번호,
--전화번호 길이가 다른게 있어서 대응해보려다가 그냥 -으로 바꾸라고 해서 이렇게 처리
--Phone_number 전화번호,
-- to_char (Phone_number, '999-099-000999') 전화번호,
--SUBSTR(Phone_number, 1, 3) || '-' || SUBSTR(Phone_number, 4, 4) || '-' || SUBSTR(Phone_number, 8) 전화번호,

hire_date 입사일
FROM employees
WHERE hire_date > TO_DATE('031231', 'YYMMDD')
;




