--Practice02.SQL_실습문제_집계
--집계(통계) SQL 문제입니다.

/*문제1.
매니저가 있는 직원은 몇 명입니까? 아래의 결과가 나오도록 쿼리문을 작성하세요*/
--
SELECT count(*)
FROM employees
where manager_id = employee_id
; --o명으로 나오는데 뭐가 잘못된걸까


/*문제2. 
직원중에 최고임금(salary)과  최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 함께 출력해 보세요. 
두 임금의 차이는 얼마?  “최고임금 – 최저임금”이란 타이틀로 함께 출력*/
SELECT  min_salary 최저임금,
        max_salary 최고임금,
        max_salary-min_salary 임금차이
FROM jobs
;


/*문제3.
마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력해주세요.
예) 2014년 07월 10일*/
SELECT  first_name, 
to_char(hire_date, 'YY"년 "mm"월 "dd"일"')
FROM employees
order by hire_date asc
; --1명만 출력하는 방법은 모르겠다




/*문제4.
부서별로 평균임금, 최고임금, 최저임금을 부서아이디(department_id)와 함께 출력합니다.
정렬순서는 부서번호(department_id) 내림차순입니다.*/
select  department_id, 
        avg(salary) 부서별평균임금,
        avg(jo.max_salary) 최고임금,
        avg(jo.min_salary) 최저임금
from employees, jobs jo
group by department_id
order by department_id desc
;


/* 문제5.
업무(job_id)별로 평균임금, 최고임금, 최저임금을 업무아이디(job_id)와 함께 출력하고 
정렬순서는 최저임금 내림차순, 평균임금(소수점 반올림), 오름차순 순입니다.
(정렬순서는 최소임금 2500 구간일때 확인해볼 것) */
SELECT  jo.job_id 업무아이디,
        avg(jo.max_salary) 평균임금,
        avg(em.salary) 평균임금
--        max_salary 최고임금,
--        avg(jo.min_salary) 최저임금
FROM jobs jo, employees em
group by job_id
--order by min_salary desc, salary asc
; --다음에 풀어보자 


/* 문제6.
가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
예) 2001-01-13 토요일 */
SELECT  first_name 이름,
        to_char(hire_date, 'YY-mm-dd day') 입사일
FROM employees
where hire_date < sysdate
order by hire_date asc

--group by hire_date
--having hire_date > sysdate
--order by hire_date desc
; --입사일시작 지금 날짜까지 계산해서 가장 긴 사람 뭔가 이상하다 having을 써야할것같음

 
/*문제7.
평균임금과 최저임금의 차이가 2000 미만인 부서(department_id), 평균임금, 최저임금 
그리고 (평균임금 – 최저임금)를 (평균임금 – 최저임금)의 내림차순으로 정렬해서 출력하세요.*/
SELECT  department_id, employee_id
FROM departments, employees
GROUP by department_id, employee_id
;


/*문제8.
업무(JOBS)별로 최고임금과 최저임금의 차이를 출력해보세요.
차이를 확인할 수 있도록 내림차순으로 정렬하세요? */




/*문제9
2005년 이후 입사자중 관리자별로 평균급여 최소급여 최대급여를 알아보려고 한다.
출력은 관리자별로 평균급여가 5000이상 중에 평균급여 최소급여 최대급여를 출력합니다.
평균급여의 내림차순으로 정렬하고 평균급여는 소수점 첫째짜리에서 반올림 하여 출력합니다.*/




/*문제10
아래회사는 보너스 지급을 위해 직원을 입사일 기준으로 나눌려고 합니다. 
입사일이 02/12/31일 이전이면 '창립맴버, 03년은 '03년입사’, 04년은 ‘04년입사’ 
이후입사자는 ‘상장이후입사’ optDate 컬럼의 데이터로 출력하세요.
정렬은 입사일로 오름차순으로 정렬합니다.*/


