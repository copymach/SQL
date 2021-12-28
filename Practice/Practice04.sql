/* Practice04 서브쿼리(SUBQUERY) SQL 문제입니다. */


/*문제1.
평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
(56건) */
 

SELECT count(salary)
FROM employees
where salary < (
                SELECT avg(salary)
                FROM employees
                ); 

/*문제2. 
평균급여 이상, 최대급여 이하의 월급을 받는 사원의 
직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 
급여의 오름차순으로 정렬하여 출력하세요 
(51건) */

select employee_id, first_name, salary
from employees
where salary >All (
                    select avg(salary)
                    from employees)
and salary <= (
                SELECT max(salary)
                FROM employees)
order by salary asc
; -- , avg(salary), max(salary)



/*문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주(state_province), 나라아이디(country_id) 를 출력하세요
(1건) */


 
SELECT em.first_name, de.location_id, lo.street_address, lo.postal_code, lo.city, lo.state_province
FROM employees em, departments de, locations lo
where de.department_id = em.department_id
and de.location_id = lo.location_id
and first_name = 'Steven'
and last_name = 'King'
; -- 정상동작하게 수정 성공

 
 
--스티븐 킹만 나와야 하는데 왜 3명 같이 딸려 나오는 걸까?
SELECT de.department_id, em.first_name, de.location_id, lo.street_address, lo.postal_code, lo.city, lo.state_province
FROM employees em, departments de, locations lo
where em.department_id = (
                        SELECT  department_id
                        FROM employees
                        where first_name in 'Steven'
                        and last_name in 'King' )
and de.department_id = em.department_id
and de.location_id = lo.location_id
; 
-- where 조건절 수정으로 해결. 같은 department의 steven 을 몽땅 불러왔다.





/*문제4.
job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 
급여의 내림차순으로 출력하세요  -ANY연산자 사용 [ >any =or ]
(74건) */

select  employee_id, 
        first_name, 
        salary,
        job_id
from    employees
where   salary <any (select  salary
                     from    employees
                     where   job_id= 'ST_MAN')
order by salary desc
;   



select department_id, employee_id, first_name, salary, jojo.job_id
from employees emem, jobs jojo
where (jojo.job_id, emem.salary) in (select jo.job_id, max(em.salary)
                                    from jobs jo, employees em
                                    group by jo.job_id
                                    having jo.job_id = ('ST_MAN'))
;  --좀더 생각해보자...


select department_id, employee_id, first_name, salary, jo.job_id
from employees em, jobs jo
where salary <ANY (SELECT  job_id
                    FROM jobs
                    where job_id = ('ST_MAN'))
;

SELECT  em.salary 
                    FROM employees em, jobs
                    where job_id = ('ST_MAN')
                    ;

select first_name, salary
from employees
where salary <ANY (select salary
from employees
where department_id = 110);



SELECT
    * FROM employees
    where salary >ALL (
                    SELECT  job_id
                    FROM jobs
                    where job_id = ('ST_MAN')   ) 
; -- 처음 생각해본 st man 불러오기 코드                   
    

/*문제5. 
각 부서별로 최고의 급여를 받는 사원의 
직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요 
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건) */


--각 부서별 최고급여 사원

SELECT  first_name,
        salary,
        department_id,
        employee_id
FROM employees
where (department_id, salary) in (
                                    SELECT department_id, max(salary)
                                    from employees
                                    group by department_id)
; --조건절 비교



SELECT  emp.first_name, emp.salary, emp.department_id, emp.employee_id
FROM employees emp, (
                    select department_id, max(salary) salary
                    from employees
                    group by department_id) sal
where emp.department_id = sal.department_id
and emp.salary = sal.salary
; --테이블 조인



/*문제6.
각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 
(19건) */


select  jo.job_title, 
        em.salary
from    jobs jo, (select  job_id, sum(salary) salary
                 from    employees
                 group by job_id) em
where   em.job_id= jo.job_id
order by em.salary desc
;


SELECT
    * FROM employees, departments
where salary >all (
                    SELECT sum(salary) 
                    FROM employees
                    group by job_id)
; --업무별로 연봉의 합 


/*문제7.
자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 
직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요 
(38건) */


select  em.employee_id, 
        em.first_name, 
        em.salary, 
        em.department_id
from    employees em, (select  department_id, avg(salary) salary
                       from    employees              
                       group by department_id) avgs
where   em.department_id = avgs.department_id
and     em.salary > avgs.salary
;



SELECT
    * FROM employees
    where salary >all (
                        SELECT  avg(salary)
                        FROM employees
                        group by department_id)
; --부서별 평균급여


/*문제8.
직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 
입사일 순서로 출력하세요 rownum 사용
*/ 


SELECT  rn, first_name, employee_id, salary, hire_date
FROM  ( 
        SELECT  rownum rn, first_name, employee_id, salary, hire_date
        FROM (        
                SELECT first_name, employee_id, salary, hire_date
                FROM employees
                order by hire_date asc)
        )
where   rn between 11 and 15
;   

--where rn >=11 and rn<=15



SELECT  rownum, first_name, employee_id, salary, hire_date
FROM (
        SELECT first_name, employee_id, salary, hire_date
        FROM employees
        order by hire_date asc)
; --입사일 순서대로 rownum출력




