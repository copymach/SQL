--그룹함수

SELECT
    * FROM employees;

-- 이하 코드는 불가능. department_id 는 하나의 row 에 표현할 수 없다 1개row에 다표현 불가
select  first_name, 
        avg(salary)
from employees
;

--그룹함수 avg()
SELECT avg(salary)
FROM employees
;
    

--그룹함수 count()    
SELECT count(*), --모든 row의 값을 세라 null 포함 107개
        count (commission_pct), -- null은 제외시킨다 35개
        count (department_id) --부서id 없는 null 1개 제외 106개
FROM employees
;


SELECT count(*) --16000넘는 사람 몇명일까? 3명 / 데이터를 다 보려면 그냥 * 사용
FROM employees
where salary > 16000
;


--부서 번호 100번인 사람의 갯수 
SELECT count(*)
FROM employees
where department_id = 100
;


--그룹함수 sum()
--에러가 난다. 숫자가 아닌 그저 전체 직원의 데이터의 합을 구할 수 없기 때문
SELECT sum(*)
FROM employees
;


SELECT sum(department_id) --부서번호라도 숫자라고 그냥 의미없이 합쳐준다. 개발자가 똑똑해야..
FROM employees
;


SELECT sum(salary), count(*), avg(salary) --회사 급여 평균 , 모두 몇명, 급여의 평균
FROM employees
;


--그룹함수 avg()
SELECT count(*),
        sum(salary)
FROM employees
;


--avg를 쓸 경우 null 때문에 답이 정확하지 않을 수 있으니 주의!!!!!! 
SELECT  count(*),
        sum(salary),
        avg( nvl (salary,0) )
FROM employees
;


--그룹함수 - max() / min()
SELECT count(*), --같은 대상을 지목할 경우 최대 최소값 찾을 수 있다.
        max(salary),
        min(salary)
FROM EMPLOYEES
;





--이제 부터 어려움
--group by 절


SELECT avg(salary), department_id
FROM employees
group by department_id --부서별로 묶어준다 12개의 부서 연봉 평균을 보여줌
--where department_id = 20
;
    

