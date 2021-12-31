/*Practice05.SQL_실습문제_혼합 SQL 문제입니다. */

/* 문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 
월급이 3000초과인 직원의 이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건) */

SELECT  first_name, 
        manager_id, 
        commission_pct, 
        salary
FROM employees
where commission_pct is null
and manager_id is not null
and salary > 3000
; 

/* 문제2. 
각 부서별로 최고의 급여를 받는 사원의 
직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 
전화번호(phone_number), 부서번호(department_id) 를 조회하세요 
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건) */


select  employee_id, 
        first_name, 
        salary, 
        to_char(hire_date, 'yyyy-mm-dd day'), 
        replace(phone_number, '.', '-'), 
        department_id
from employees
--다중행 IN 동시에 여러가지 값 비교가능, 형태가 같아야 하는 조건.
where (department_id, salary) in (select department_id, max(salary) 
                                    from employees
                                    group by department_id)
order by salary desc;



select department_id, max(salary) 
from employees
group by department_id; --부서별로 최고임금


--실패 서브쿼리로 최대 임금자를 가져와보려고 했다 서브쿼리에서 in any 를 사용
SELECT  first_name
FROM employees
where salary = (
                SELECT  max(salary)
                FROM employees
                GROUP BY department_id   
                ) ;


/* 문제3
매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여,
매니저별최소급여, 매니저별최대급여 입니다.
(9건) */

select  ma.manager_id, 
        first_name, 
        avg_Sal, 
        min_Sal, 
        max_Sal
from    employees em, 
    (select manager_id, round(avg(salary),1) avg_Sal, min(salary) min_Sal, max(salary) max_Sal
      from employees
      where hire_date >= '2005/01/01'
      group by manager_id
      having avg(salary)>=5000 ) ma
      --where 절에는 그룹함수 못씀 having사용. 여기에 그룹함수, Group by에 참여한 컬럼만 사용
where ma.manager_id = em.employee_id
order by avg_sal desc
;


SELECT  avg(salary) avs, max(salary) mxs, MIN(salary) mns
FROM employees
group by manager_id
; --매니저 별 임금


--실패 having절 쓰는걸 잊어버렸다
SELECT  avs, mns, mxs
FROM (
        SELECT  avg(salary) avs, min(salary) mns, max(salary) mxs, 
        FROM employees
        where hire_date >= '2005/01/01'
        and salary >= 5000 )
;

    
/* 문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 
매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)  */

select em.employee_id, em.first_name, department_name, ma.first_name
from employees em, departments de, employees ma
where em.department_id = de.department_id(+) --아우터조인 null이 오는쪽에 +를 붙힌다 킴벌리 표시
and em.manager_id = ma.employee_id
; -- join 부분에서 설명한 문제
      

-- 실패한 코드 
SELECT  salary
FROM employee
group by employee_id
having department_id = employee_id
;



/* 문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요  */

--rownum 사용

SELECT  rm, employee_id, first_name, department_name, salary, hire_date
FROM    (
        SELECT rownum rm, employee_id, first_name, department_name, salary, hire_date
        FROM (            
                SELECT  employee_id, first_name, department_name, salary, hire_date
                FROM employees, DEPARTMENTS
                where hire_date >= '2005/01/01'
                order by hire_date
                )
        )
where rm >= 11
and rm <= 20
;


/* 문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 
근무하는 부서 이름(department_name)은?  */

SELECT  rn, first_name, last_name, salary, department_name, hire_date
FROM    (
        SELECT rownum rn, first_name, last_name, salary, department_name, hire_date
        FROM    (
                SELECT first_name, last_name, salary, department_name, hire_date
                FROM employees em, departments de
                where em.department_id = de.department_id
                order by hire_date desc
                )
        )
where rn <= 2
; -- 서브쿼리로 늦은 입사자를 뽑아내고 rownum을 이용해서 2명만 출력했다
 
 
/* 문제7.
평균연봉(salary)이 가장 높은 부서 직원들의 
직원번호(employee_id), 이름(firt_name), 성(last_name)과  
업무(job_title), 연봉(salary)을 조회하시오.  */


select employee_id, 
       first_name, 
       last_name,
       salary, 
       avg_salary, 
       job_title
from (  -- rownum으로 평균연봉 가장 높은 90번 부서만 뽑아냄
        select department_id, salary avg_salary
        from (  --평균연봉 가장 높은 부서
                select department_id, avg(salary) salary
                from employees 
                group by department_id
                order by salary desc
                ) 
        where rownum=1
      ) max_sal, 
      employees em, jobs jo
where em.department_id = max_sal.department_id --조건절에서 90번 부서 한정
and em.job_id = jo.job_id
;


--실패 90번부서를 뽑아낸 이후 처리를 못했다
SELECT  first_name
FROM employees
where (department_id, avg(salary)) in (
                                    SELECT  avg(salary), department_id
                                    FROM  employees
                                    group by department_id
                                    order by avg(salary) desc --90번 부서가 가장 높다
                                    )
; 


/* 문제8.
평균 급여(salary)가 가장 높은 부서는?  */ 
 
SELECT  rownum, de.department_id, de.department_name, max_avg_sal.avgsal
FROM (
        SELECT  avg(salary) avgsal, department_id
        FROM  employees
        group by department_id
        order by avg(salary) desc
        ) max_avg_sal , DEPARTMENTS de
where rownum = 1
;



/* 문제9.
평균 급여(salary)가 가장 높은 지역은?  */ 

SELECT region_name
FROM regions 
where region_id = (
                    select region_id from (
                                            SELECT rownum , region_id
                                            FROM (
                                                    SELECT  regi.region_id, avg(salary)
                                                    FROM  employees em, DEPARTMENTS de, locations lo, countries coun, regions regi
                                                    where em.department_id = de.department_id
                                                    and de.location_id = lo.location_id
                                                    and lo.country_id = coun.country_id
                                                    and coun.region_id = regi.region_id
                                                    group by regi.region_id
                                                    order by avg(salary) desc
                                                    )
                                            where rownum = 1        
                                            ) 
                    ) 
;



/* 문제10.
평균 급여(salary)가 가장 높은 업무는?  */ 

--셀프 조인 사용
select job_title
from    (
        select rownum, job_id, avsal
        from(
            select jo.job_id, avg(salary) avsal
            from jobs jo, employees em
            where jo.job_id = em.job_id
            group by jo.job_id
            order by avg(salary) desc
            )
        ) avsaljo, jobs jo
where avsaljo.job_id = jo.job_id
and rownum = 1
;



--실패한 코드 셀프조인 사용할 생각을 못함
SELECT  rownum rn, avsal
FROM    (
        SELECT avg(salary) avsal
        FROM employees em, jobs jo
        group by jo.job_id
        order by avg(salary) desc
        )
;



                