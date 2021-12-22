--DCL(Data Control Language, 데이터 제어어)   User 관리


--계정 만들기
create user webdb2 identified by 1234;

-- 권한주기
grant resource, connect to webdb;

-- 비번 바꾸기
alter user webdb identified by 비밀번호; 

-- 계정 삭제하기
DROP USER user [CASCADE];

-- 권한보기(참고)
SELECT grantee, privilege
FROM DBA_SYS_PRIVS
WHERE grantee = 'RESOURCE';

-- 계정리스트 보기(참고)
select * from all_users;


/*
오라클 비번 바꾸는 방법
# SYS 및 SYSTEM 계정으로 접속
1. cmd 창에서 SQLPlus 실행
2. 사용자명 입력: sys as sysdba
3. 비밀번호 입력: 아무런 입력 없이 엔터

# 접속한 계정의 비밀번호 변경
4. 하기 명령어와 같이 비밀번호를 변경한다. 
    ex) alter user sys identified by 비번자리 manager;
5. 변경된 계정으로 접근이 가능한지 접속해본다.
    ex) conn sys/manger as sysdba
*/