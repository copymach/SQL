/* 2021 12 20 sub Query 서브 쿼리 (쿼리 속 쿼리) */


--Den보다 급여 많이 받는 직원 이름과 급여

--1) 전체 퀴리문 구조
select first_name, salary
from employees
where salary > '딘의 급여' 
;


--2) 딘의 급여
select salary
from employees
where first_name = 'Den'
;

--3) 퀴리문 작성 (들여쓰기 잘할 것 )
SELECT  first_name, salary 
FROM employees
where salary > (SELECT salary --식에서 사용할때 first_name을 넣으면 에러
                FROM employees
                where first_name = 'Den')
;


--급여 가장 적게 받는 사람의 이름
SELECT  min(salary)
FROM employees
; --최저 급여 구하기

SELECT first_name, salary
FROM employees
where salary = (SELECT  min(salary)
                FROM employees)
; -- 최저급여와 같은 급여인 사람 찾기 



--평균급여보다 적게 받는 사람의 이름과 급여 출력
SELECT avg(salary)
FROM employees
; --평균급여 만들고 

SELECT  first_name, salary
FROM employees
where salary < (SELECT avg(salary)
                FROM employees)
; --평균급여보다 못받는 사람 찾기

-- 같지않다 자바 != 오라클 <>

