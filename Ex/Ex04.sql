--group by 절

SELECT avg(salary)
FROM employees
GROUP by department_id
;

-- 그냥 부서id 의 평균을 내면 id자체값의 평균을 내는데 그룹바이를 쓰면 그 안의 데이터를 평균을 쓸 수있다
SELECT department_id, avg(salary)
from EMPLOYEES
group by department_id
order by department_id asc
;


--그룹별로 몇개 있는지 알려준다, 그룹별 급여를 알려준다
SELECT department_id, count(*), avg(salary)
FROM employees
group by DEPARTMENT_id
;


SELECT  department_id, job_id, count(*), avg(salary)
FROM employees
GROUP BY department_id, job_id --그룹바이 콤마로 이어 쓸 수 있다
order by department_id asc, job_id desc, count(*) desc, AVG(salary) desc --정렬 기본값 asc
;


--연봉(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 급여합계를 출력
SELECT  department_id, COUNT(*), sum(salary)
FROM employees
--where sum(salary) >= 20000 --where절에는 그룹함수를 쓸 수 없음
group by department_id
;


--Having절 그룹함수 에서 where 절 쓸 수 있음
SELECT  department_id, COUNT(*), sum(salary)
FROM employees
group by department_id
--그룹바이에서 where절 대신 having 사용
HAVING sum(salary) >= 20000 --급여 합계가 20000 인 사람들의 합
--콤마가 아니라 and or로 조건을 추가한다
and department_id = 100 -- 100번 조직 중에서..
;


SELECT  department_id, COUNT(*), sum(salary)
FROM employees
group by department_id
HAVING sum(salary) >= 20000
or department_id = 40 
; --and사용시 8개 행, or사용시 제대로된 쿼리이지만 결괏값이 없다


--CASE ~ END 문
SELECT employee_id,
        first_name,
        salary,
        job_id,
        --대소문자 입력주의 잘못쓰면 적용안됨
        case when job_id='AC_ACCOUNT' then salary + salary*0.1 
            when job_id='SA_REP' then salary + salary*0.2
            when job_id='ST_CLERK' then salary + salary*0.3 --ST_clerk 인식안됨
            else salary
        end "실질수령액"
FROM employees
;


--DECODE 문 (CASE ~ END 비교)
SELECT  employee_id,
        first_name,
        salary,
        job_id,
        decode (
                job_id, 'AC_ACCOUNT', salary+salary*0.1,
                        'SA_REP', salary+salary*0.2,
                        'ST_CLERK', salary+salary*0.3,
        salary) as "RealSalary"
        
FROM employees
;


/*직원의 이름, 부서, 팀을 출력하세요
팀은 코드로 결정하며 부서코드가 10~50 이면 ‘A-TEAM’
60~100이면 ‘B-TEAM’ 110~150이면 ‘C-TEAM’ 나머지는 ‘팀없음’ 으로 출력*/

SELECT  first_name,
        department_id
        case when department_id >= 10 and department_id <= 50 then 'A-Team'
             when department_id >= 60 and department_id <= 100 then 'B-Team'
             when department_id >= 110 and department_id <= 150 then 'C-Team'        
            else '팀없음'
        end as "team"
FROM employees
;

select  first_name,
        department_id,
        case when department_id >= 10 and department_id <= 50 then 'A-TEAM'
             when department_id >= 60 and department_id <= 100 then 'B-TEAM'
             when department_id >= 110 and department_id <= 150 then 'C-TEAM'
             else '팀없음'
        end as team
from employees;




