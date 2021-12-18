--join 문 2021 12 17 

SELECT  *
FROM employees, departments 
;


SELECT  *
FROM employees, departments 
where employees.department_id = departments.department_id
;


SELECT  em.employee_id, --from 부분에서 지정한 em 이름을 활용
        first_name,
        salary,
        department_name,
        em.department_id,
        de.department_id
FROM employees em, departments de --employees as em 네이밍에 as를 쓰면 안됨
where em.department_id = de.department_id
;

select first_name, em.department_id,
department_name, de.department_id
from employees em, departments de
where em.department_id = de.department_id;


--모든 직원이름, 부서이름, 업무명 을 출력.
SELECT em.first_name,
        de.department_name,
        jo.job_title
FROM employees em, departments de, jobs jo
where em.department_id = de.department_id
and em.job_id = jo.job_id  
; --올바른 코드 106개

SELECT em.first_name,
        de.department_name,
        jobs.job_title
FROM employees em, departments de, jobs
where em.department_id = de.department_id
and jobs.job_id = em.job_id  
; --잘못작성한 코드 -> 막줄 or을 and로 바꿈.








