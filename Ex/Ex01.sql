--select 문 select 절, from 절;

--직원테이블 전체 조회
select * 
from employees;

--부서테이블 전체 조회
select * 
from departments;


select employee_id, 
        first_name, 
        last_name
from employees;


select first_name, 
        phone_number,
        hire_date,
        salary,
From employees;


select first_name,
        last_name,
        salary,
        phone_number,
        email
        hire_date,
from employees;        

select first_name, phone_number, hire_date, salary
from employees;

--출력할 컬럼 명에 별명 적용하기
select  employee_id as empNo,
        first_name as "f-name", --특수문자는 따옴표
        salary as "연 봉" --공백도 따옴표 붙혀쓰면 따옴표없어도됨
from employees;

SELECT  first_name as 성명,
        phone_number as 전화번호,
        hire_date as 입사일,
        salary
        FROM employees;
        
SELECT  employee_id as 사원아이디,
        first_name,
        last_name,
        salary 급여, --as를 빼도 옆의 한글 적용잘된다 
        phone_number "전 화 번 호",
        email "E-mail",
        hire_date
        FROM employees;

--컬럼 두개를 합치기
SELECT  first_name || last_name
FROM employees;

--컬럼 두개 합치고 사이에 공백넣기
SELECT  first_name || ' ' ||last_name as 성명
FROM employees;


SELECT  first_name || ' ' ||last_name || ' 입사 일은 ' ||hire_date as 성명입사일
FROM employees;


--산술 연산자 사용해보기
SELECT  first_name 이름,
        salary as 월급,
        salary *12 연봉,
        (salary+300)*12 보너스300추가 --사칙연산 월300씩 더주고 12개월
FROM employees;


--예)
SELECT job_id*12 --아이디는 숫자라서 산술 적용안됨
FROM EMPLOYEES;

SELECT  first_name||'-'||last_name 이름,
        salary "급 여",
        salary*12 as 연봉,
        (salary*12)+5000 보너스5000추가,
        phone_number 전번
FROM EMPLOYEES;



--where절
--비교 연산자
--부서번호가 10인 사원의 이름을 구하시오
SELECT  first_name,
        last_name,
        salary,
        department_id
--    * 전부다 보여주기
FROM employees
where department_id = 10;

--연봉이 15000 이상의 사원들의 이름과 월급
SELECT  *
FROM employees 
where salary >= 15000;

--07 01 01 입사 사람들 이름과 입사일 출력
SELECT  first_name, hire_date
FROM employees
where hire_date >= '07-01-01';

--이름이 lex인 직원의 연봉 출력
SELECT  salary, 
        first_name
FROM employees
where first_name = 'Lex';


--연동 14000 이상 17000이하 사원의 이름과 연봉
SELECT  first_name,
        salary
FROM employees
where salary >= 14000
and salary <= 17000;


--연봉 14000이하 17000 이상인 사원의 이름과 연봉
SELECT  first_name,
        salary
    FROM employees
    where salary <= 14000
    or salary >= 17000;

--입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일
SELECT  first_name,
        hire_date
    FROM employees
    where hire_date >= '04/01/01' and hire_date <= '05/12/31' 
    
    where hire_date between '04/01/01' and '05/12/31' 
    --hire_date between 04/01/01 and 05/12/31 
    --hire_date <= 04/01/01     and hire_date >= 05/12/31
    ;


--between 연산자로 특정 구간 값 출력
SELECT
    * FROM employees
    where salary <= 14000
    or salary >= 17000;
    
SELECT
    * FROM employees
    where salary BETWEEN 14d000 AND 17000;
    
--in연산자로 여러 조건 검사
SELECT
    * FROM employees
    where first_name = 'Neena' 
    or first_name = 'Lex'
    or first_name = 'John'
    ;

--in으로 위 내용과 똑같이 표현
SELECT
    * FROM employees
    where first_name in ('Neena', 'John', 'Lex')
    ;

--연봉이 2100 3100 4100 5100 사원의 이름과 연봉 표기
SELECT
    * FROM employees
    where salary in (2100, 3100, 4100, 5100)
    ;


--Like 연산자로 비슷한것 찾기
SELECT
    * FROM employees
    where first_name like 'L%';


--이름에 am을 초함한 사원의 이름과 연봉
SELECT
    * FROM employees
where first_name like '%am%';


--이름이 4번째 글짜가 a 인 사원의 이름 출력
SELECT
    * FROM employees
where first_name like '__a';

--두번쨰글짜가 a 이면서 뒤에 아무글짜가 오는 이름
SELECT
    * FROM employees
where first_name like '_a%';


--이름의 네번째 글짜가 a인 사원의 이름
select *
from employees
where first_name like '___a';

--이름이 4글자인 사원의 끝에서 두번쨰 글자가 a인 사원의 이름
select *
from employees
where first_name like '__a_';


--null 알수없는 오류
SELECT  first_name,
        salary,
        commission_pct,        
        salary*commission_pct        
FROM employees
where salary between 13000 and 15000;

    
--is null / in not null
SELECT
    * FROM employees
    where commission_pct is null; --커미션을 가진 사람 == 영업사원


--커미션 비율 있는 사원의 이름 과 연봉 커미션 비율 출력
SELECT  first_name,
        salary,
        commission_pct
FROM employees
where commission_pct is not null; 

--담당매니저가 없고 커미션 비율이 없는 직원의 이름 출력 (and 동시만족)
SELECT  first_name
    FROM employees
where commission_pct is null
and manager_id is null
;


--order by 절
--급여순으로 정렬

SELECT
    * FROM employees
order by salary desc, first_name asc
--asc 오름차순 작->크 1234  desc 내림차순 크->작 4321
;


SELECT  first_name,
        salary
FROM employees
where salary >= 9000
order by salary asc
;


--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
SELECT  department_id,
        salary,
        first_name
FROM employees
order by department_id asc
;

--급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
SELECT first_name, salary
FROM employees
where salary >= 10000
order by salary desc
;

--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요
SELECT
        department_id,
        salary,
        first_name
FROM employees    
order by department_id asc, salary desc 
;
