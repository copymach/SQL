--단일행 함수

--문자함수 initcap (컬럼명)
SELECT email as 이메일, 
        initcap(email) "Email2", --email의 문자열을 변경
        email,
        department_id
from employees
where department_id = 100
;


--칼럼 데이터를 소문자로 변환 출력
SELECT  first_name,
        lower(first_name) l_name,
        upper(first_name) as "u_name",
        first_name
FROM employees
where department_id = 100
;

--서브 스트링 substr(컬럼명, 시작위치, 글자수) 문자열에서 일부 글자만 떼어내는 방법 
SELECT first_name,
        substr(first_name,1,3), --자바와 달리 0이 아닌 1부터 시작
        substr (first_name,-3,2) as 뒤부터3번째글자부터2문자, -- -3이 시작위치
        first_name
    FROM employees
    where department_id = 100
    ;


--문자함수 -LPAD(컬럼명, 자리수, '채울문자') / RPAD(컬럼명,자리수, '채울문자')
SELECT first_name,
        lpad(first_name, 10, '*'),
        rpad(first_name, 10, '*')
FROM employees
;


--문자함수 -replace (컬럼명, 문자1, 문자2)
SELECT first_name,
        replace (first_name, 'a', '*'), --a글자를 *로 바꿔준다 
        --이벤트 당첨자 발표 글짜 몇개를 별표로 바꿔서 표시
        replace (first_name, substr(first_name,2,3), '***')
    FROM employees
    where department_id = 100
    ;




-- select sysdate 지금시간 입력 , 게시판에 지금 시간을 자동 입력할때 사용
SELECT 123 as num
    FROM employees
    ;

--dual 아무것도 없는 테이블 문장 완성을 위해 사용
SELECT SYSDATE
FROM dual;

--숫자함수 -round(숫자, 출력을 원하는 자릿수) 반올림
select round (123.346, 2) "r2", --소수점 둘째자리 까지 표시해줘 .35로 반올림 처리
        round(123.856, 0) "r0", --124로 올림 처리 출력
        round(123.456, -1) "r-1" -- 123 -> 120 됨 -1 에 3이 영향받아 반올림 처리됨
from dual;

--숫자함수 -trunc(숫자, 출력을 원하는 자릿수) 버림
SELECT trunc (123.346, 2) "r2",
        trunc (123.456, 0) "r0", --소수점 이하 버림처리
        trunc (129.456, -1) "r-1" --정수위치에서 한자리 위 숫자부터 버림처리
FROM dual
;

--날짜함수 sysdate()
select sysdate
from dual;

select sysdate,
        hire_date,
        MONTHS_BETWEEN(SYSDATE,hire_date) 근무월수,-- 몇개월 일했음
        --        trunc(,0), 0 이하 자리 삭제
        trunc (MONTHS_BETWEEN(SYSDATE,hire_date),0) 근무월수_소수점처리 
from EMPLOYEES
where department_id =100
;


--변환 함수 to char (숫자, '출력모양') 숫자를 문자형으로 변환
--월급 연봉 앞에 달러 문자를 붙힘 ->숫자월급값 문자변환해서 숫자앞$표기
SELECT  first_name,
        salary,
        salary*12,
        to_char(salary*12 , '$999999'), --9는 의미없는 자릿수 8들어가면 에러
        to_char(salary*12 , '0000000000999999'), --0으로 빈자리의 자릿수를 채우라
        to_char(salary*12 , '$999999.99'), --소숫점2자리수 까지 표시
        to_char(salary*12 , '99,999,999') --한국돈표시와 비슷
FROM employees
where department_id = 100
;


-- to char 문자열 날짜를 문자열로 변환
--1900/01/01 00:00:00
SELECT  sysdate,
        to_char(sysdate, 'yYYy-mm-dd'),
        to_char(sysdate, 'YY-mm-dd day HH24:MI:SS'),
        to_char(sysdate, 'YY"년"mm"월"dd"일"(dy) HH24:MI:SS'), 
        to_char(sysdate, 'month'), -- '12월' 형식 표시
        to_char(sysdate, 'day'), -- 요일 dy 목, day'목요일' 형식 표시    
        to_char(sysdate, 'MI'), -- 분 표시
        to_char(sysdate, 'SS') --초 표시
FROM dual;



SELECT  sysdate,
        to_char(hire_date, 'YyYy-mm-dd'),
        to_char(sysdate, 'month'),
        to_char(sysdate, 'day')        
FROM employees
;


--단일행 함수
--일반함수>NVL(컬럼명, null일때값)/NVL2(컬럼명, null아닐때값, null일때 값)
SELECT  first_name,
        commission_pct,
        nvl (commission_pct, 0), --null 을 0으로 표시해준다 ->계산가능
        nvl2 (commission_pct, 100, 0) --100은 null이 아닐때
        nvl2 (commission_pct, 1, 0) --커미션이 있으면1 없으면0으로 표시
FROM employees
;



