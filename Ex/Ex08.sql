/* 2021 12 22 chapter04 서브쿼리 - 로넘 rownum 게시판 목록 */

--급여를 가장 많이 받는 직원 5명 이름 출력 해보고 싶다
SELECT  max(salary)
FROM employees
; -- 급여 많이 받는 사람들 주루룩 

select  first_name, salary
from employees
where salary < (SELECT  max(salary) FROM employees)
; -- 정렬 하려고하니였더니 순서가 뒤죽박죽


-- rownum은 가상 일련 번호 생성
SELECT  rownum,
        first_name,
        salary
FROM employees
where rownum >=1
and rownum <= 5
order by salary desc
;

--01. rownum이해
select rownum, first_name, salary
from employees ;

--02. 정렬
SELECT  first_name, salary
FROM employees
order by salary desc;


--from 절에 정렬된 테이블을 넣는다
SELECT  rownum, 
        first_name, 
        salary
FROM (SELECT  first_name, -- 이자리에 *을 넣어도 되는데 에러확률이 있으니 필요한것만 콕찝어쓰자
                salary
    FROM employees
    order by salary desc)
where rownum <= 5
; -- 5명까지 출력 잘됨


--2번부터 4번까지 출력해보고싶어 하지만 에러
--해결방법은 rownum 안에 rownum을 넣어서...


SELECT  ort.rno,  -- 3. where 2번부터 출력할 곳
        ort.first_name,
        ort.salary
FROM (select rownum rno,  -- 2. rownum 먹인 곳
        ot.first_name,
        ot.salary
        from ( select first_name,  -- 1. order 정렬 먹인 곳
                        salary
                from employees
                order by salary desc) ot  -- rownum을 위해 ot 테이블 이름을 붙힘
        ) ort

where rno >=3
and rno <=5
;
    
    
--예제문제 07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일

--3-7등 테이블
--급여 순위 테이블
--07년 입사한 직원테이블


-- 3-7등 출력 테이블 완성
SELECT  rownm, 
        ort.first_name,  
        ort.salary,
        ort.hire_date
FROM (
        -- 급여 순위 테이블
        SELECT  rownum rownm,
                ot.first_name,  
                ot.salary,
                ot.hire_date
        FROM (
                --07년 입사 직원 테이블 총19건
                SELECT  first_name,  
                        salary,
                        hire_date
                FROM employees
        where hire_date >= '070101'
        and hire_date < '08/01/01'
        order by salary desc ) ot
) ort

where rownm >= 3
and rownm <= 7
;



--조건 3개 테이블을 3개씩 따로 만들고 조립해서 만들어보자

SELECT  rownum rownm,
        first_name,  -- 급여 순위 테이블
        salary,
        hire_date
FROM (
--07년 입사 직원 테이블
SELECT  first_name,  
        salary,
        hire_date
FROM employees
where hire_date >= '070101'
)
order by salary desc
;



SELECT  first_name,  -- 3-7등 출력 테이블
        salary,
        hire_date
FROM employees
where rownm >= 3
and rownm <= 7
;
    
--07년 입사 직원 테이블
SELECT  first_name,  
        salary,
        hire_date
FROM employees
where hire_date >= '070101';


SELECT  first_name,  -- 급여 순위 테이블
        salary,
        hire_date
FROM employees
order by salary desc
;




--예제문제2
--07년에 입사한 직원 중 급여가 많은 직원 중 3-7등의 이름 급여 입사일 + 부서명?

--07년에 입사한 직원중 급여가 많은 직원중 
--3에서 7등의 이름 급여 입사일 + 부서명은? 
--->  (1)정렬을 하고  (2)rowmum 붙이고  (3)where절 사용

select  ort.rn,
        ort.first_name,
        ort.salary,
        ort.hire_date,
        ort.department_name
from (select rownum rn,
             ot.first_name,
             ot.salary,
             ot.hire_date,
             ot.department_name
      from (select  emp.first_name,
                    emp.salary,
                    emp.hire_date,
                    dep.department_name
            from employees emp, departments dep      ---(0) 부서명 때문에 조인
            where emp.department_id = dep.department_id
            and hire_date >= '07/01/01'
            and hire_date < '08/01/01' 
               order by salary desc     ) ot     ----(1)
    
      ) ort   ----(2)
where ort.rn >= 3   ----(3)
and ort.rn <= 7
;





-- 선생님 따라서 만든 코드
-- 뭔가 잘못 쓴듯..에러
SELECT  ort.rn,
        ort.first_name,
        ort.salary,
        ort.hire_date,
        ort.department_name
FROM (
        SELECT  rownum rn,
                ot.first_name,
                ot.salary,
                ot.hire_date
                ot.department_name
        FROM    (SELECT  emp.first_name,
                        emp.salary,
                        emp.hire_date,
                        dep.department_name
                FROM employees emp, departments dep
                where emp.department_id = dep.department_id
                and hire_date >= '070101'
                and hire_date < '080101'
                order by emp.salary desc ) ot -- 부서명을 붙히기 위해 join한다 -> where 절이 없어서 카디전 프로덕트가 되버림

) ort
where ort.rn >= 3
and ort.rn <= 5
;





--코드 완성했는데 사람이 1명만 나온다 -> 실패
-- 부서 이름을 넣으니 문제가 생긴다
-- 실패원인 첫번째 테이블 만들때 join 카디전 프로덕트 고려를 못했다.
SELECT  rownm, -- 급여 많이 받는 순서 3-7등 테이블
        first_name,
        salary,
        hire_date,
        dptname
FROM ( -- 급여 많이 받는 순서 테이블
        SELECT  ROWNUM rownm,
                first_name,
                salary,
                hire_date,
                dptname
        FROM ( --07년도에 입사한 직원 테이블
                SELECT  first_name,
                        salary,
                        hire_date,
                        de.department_name as dptname
                FROM employees, departments de
                where hire_date > '070101'
                
        )
        order by salary desc
)
where rownm >= 3
and rownm <= 7
;


-- 예제 문제 연습용 코드

--07년에 입사한 사람 이름 부서명
SELECT  first_name,
                        salary,
                        hire_date,
                        de.department_name as dptname
                FROM employees, departments de
                group by employee_id, department_id
                having hire_date > '070101';
                
                

SELECT  rownm, -- 급여 많이 받는 순서 3-7등 테이블
        first_name,
        salary,
        hire_date,
        dptname
FROM ( -- 급여 많이 받는 순서 테이블
        SELECT  ROWNUM rownm,
                first_name,
                salary,
                hire_date,
                dptname
        FROM ( --07년도에 입사한 직원 테이블
                SELECT  first_name,
                        salary,
                        hire_date,
                        de.department_name as dptname
                FROM employees, departments de
                GROUP BY employee_id
                having hire_date > '070101'
                
        )
        order by salary desc
)
where rownm >= 3
and rownm <= 7
;


--07년 입사 중 급여 많은 순서대로 직원 출력
SELECT  ROWNUM rownm,
        first_name,
        salary,
        hire_date,
        dptname
FROM (
        SELECT  first_name,
                salary,
                hire_date,
                de.department_name as dptname
        FROM employees, departments de
        order by salary desc
)
where hire_date > '070101'
;



--급여가 많은 직원 테이블 
SELECT  first_name,
        salary,
        hire_date,
        department_name
FROM employees, departments
order by salary desc
;


--07년에 입사한 직원 테이블
SELECT  first_name,
        salary,
        hire_date,
        department_name
FROM employees, departments
where hire_date > '070101'
;




