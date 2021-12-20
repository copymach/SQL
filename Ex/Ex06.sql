/* 2021 12 20 02장 join 
equi join
 */

--equi join 교집합
SELECT  em.first_name, 
        em.salary, 
        de.department_id, 
        de.department_name
 FROM employees em, departments de
where em.department_id = de.department_id
;  --null은 제외됨을 꼭 알고 있어야한다 null이 빠진걸 모르고 실수 할 수 있다!!

SELECT  count(*)
FROM employees em, departments de
where em.department_id = de.department_id
;


SELECT
* FROM employees em, departments de, jobs jo
where em.department_id = de.department_id
and em.job_id = jo.job_id
;


SELECT em.first_name,
        de.department_name,
        jo.job_title
FROM employees em, departments de, jobs jo
where em.department_id = de.department_id
and em.job_id = jo.job_id
; --null은 빠져있다


/*
■ OUTER Join
•Join 조건을 만족하지 않는 컬럼이 없는 경우 Null을 포함하여 결과를 생성
•모든 행이 결과 테이블에 참여
•NULL이 올 수 있는 쪽 조건에 (+)를 붙인다.
■ 종류
•Left Outer Join: 왼쪽의 모든 튜플은 결과 테이블에 나타남
•Right Outer Join: 오른쪽의 모든 튜플은 결과 테이블에 나타남
•Full Outer Join: 양쪽 모두 결과 테이블에 참여
*/


-- Left join , Left outer join
SELECT  em.first_name,
em.salary, em.department_id, de.department_id, de.department_name
    FROM employees em LEFT OUTER JOIN departments de
       ON em.department_id = de.department_id 
; --107개가 출력 마지막 row에서 킴벌리 null 발견 가능


SELECT
* FROM employees em, departments de
where em.department_id = de.department_id(+)
; --위 내용과 같은 내용 다른 작성법


SELECT
* FROM employees
where department_id IS NULL
; --join 하기전에 미리 null 값을 찾아보자 kimberely


SELECT
* FROM employees em, departments de
where em.department_id = de.department_id(+)
and em.employee_id = 178 
; -- null값 있는 킴벌리 하나 나옴


--right outer join
SELECT  em.first_name, 
        em.salary, 
        em.department_id, 
        de.department_id, 
        de.department_name
FROM employees em right outer join departments de
on em.department_id = de.department_id
; --106명까지 부서명 매칭되는 사람은 잘 출력. 이후 사람에 대한 정보는 없는 null 16가 출력 
--부서명이 없는 킴벌리 left에서 나오고 right 에서 안나온다 


SELECT  em.first_name, 
        em.salary, 
        em.department_id, 
        de.department_id, 
        de.department_name
FROM employees em, departments de
where em.department_id(+) = de.department_id
; --위와 같은 출력 오라클식 표현



-- right outer join -> left join

SELECT  em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_name
FROM departments de left outer join employees em
ON de.department_id = em.department_id
;

--full outer join 테이블 양쪽 null 포함 몽땅 표시 (합집합)
SELECT  em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_name
FROM employees em full outer join departments de
on em.department_id = de.department_id
;


SELECT  em.first_name,
        em.salary,
        em.department_id,
        de.department_id,
        de.department_name
FROM employees em, departments de
where em.department_id(+) = de.department_id(+) -- 사용불가 이런 문법은 없다
; -- 풀아우터조인 +를 붙히는 식의 오라클 표현은 불가




--직원의 매니저 정보 출력
SELECT
    * FROM employees em
    ;


--self join
SELECT  em.employee_id, 
        em.first_name, 
        em.salary, 
        em.phone_number, 
        em.manager_id, 
        ma.employee_id, 
        ma.first_name, 
        ma.email
        
FROM employees em, employees ma 
where em.manager_id = ma.employee_id
;




--잘못된 조인
select  em.employee_id,
        em.first_name,
        em.salary,
        lo.location_id,
        lo.city
from employees em, locations lo
where em.salary = lo.location_id
; --우연히 숫자가 같은 연관 없는 데이터가 출력  

