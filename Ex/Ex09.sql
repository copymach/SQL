--2021 12 23 DDL(Data Definition Language, 데이터 정의어) --> 테이블 관리
--DDL webdb 계정에 book 테이블 만들기

create table book(
    book_id number(5), 
    title varchar2(50),
    author varchar2(10),
    pub_date date
);

select * from book;

--book테이블에 pubs 컬럼 추가하기
alter table book add (pubs varchar2(50));

-- book 테이블에 컬럼 속성 변경하기
alter table book modify (title varchar2(100));
alter table book rename column title to subject;

--작가 컬럼 삭제
alter table book drop(author);

--테이블 명 변경하기
rename book to article;

SELECT * FROM book;

--테이블 삭제
drop table article;


--작가테이블 만들기
create table author (
    author_id number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    primary key (author_id) --프라이머리 키 지정
);

SELECT * FROM author;
SELECT * FROM all_tables;
 
-- rename authordesc to author_desc;
--컬럼명 변경 : editid -> edit_id
ALTER TABLE author RENAME COLUMN authordesc TO author_desc;



-- 책 book 테이블 만들기
create table book (
    book_id number(10),
    title varchar2(100) not null,
    pubs varchar2(100),
    pub_date date,
    author_id number(10),
    primary key (book_id),
    constraint book_fk foreign key (author_id)
    REFERENCES author(author_id)
);


SELECT    * FROM book;
SELECT    * FROM author;    



--작가 (author) 테이블에 테이터 추가 insert 
--묵시적 방법
insert into author
values (1, '박경리', '토지 작가');


--명시적방법
insert into author (author_id, author_name, author_desc)
values (2, '이문열', '삼국지 등등 작가');
--2 위치는 자료형 맞춰서 숫자만 가능
--작가이름은 null 허용을 안해서 빈칸으로 두면 에러







