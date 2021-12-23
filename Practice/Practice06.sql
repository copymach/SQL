/* webdb book author 테이블 만들기 */

--테이블 삭제
drop table author;
drop table book;

--테이블 상태 확인
select * from book;
select * from author;


--저자 테이블 만들기
create table author (
    author_id number(10),  --50짜리 만들어 보려고 했는데 에러 
    author_name varchar2(100),
    author_desc varchar2(500),
    primary key (author_id) --프라이머리 키 지정
);


--책 테이블 만들기
create table book (
    book_id number(10), 
    title varchar2(100),
    pubs varchar2(100),
    pub_date date,
    author_id number(10),
    primary key (book_id),
    constraint book_fk foreign key (author_id) -- 포린키 연결
    references author (author_id)
);



-- 저자 id번호 자동생성을 위한 시퀀스 sequence
create sequence seq_author_id
increment by 1
start with 1
nocache
;



--저자정보 입력하기 (자동생성id, 저자이름, 저자설명)
INSERT INTO author VALUES (seq_author_id.nextval, '김문열', '경북 영양' );

INSERT INTO author VALUES (seq_author_id.nextval, '박경리', '경상남도 통영' );

INSERT INTO author VALUES (seq_author_id.nextval, '유시민', '17대 국회의원' );

INSERT INTO author VALUES (seq_author_id.nextval, '기안84', '기안동에서 산 84년생' );

INSERT INTO author VALUES (seq_author_id.nextval, '강풀', '온라인 만화가 1세대' );

INSERT INTO author VALUES (seq_author_id.nextval, '김영하', '알쓸신잡' );


-- 저자 입력 연습
INSERT INTO author VALUES (seq_author_id.nextval, '손오공', '원숭이' )
INSERT INTO author VALUES (seq_author_id.nextval, '사오정', '나방~' )
INSERT INTO author VALUES (seq_author_id.nextval, '둘리', '아기공룡' );

INSERT INTO author(seq_author_id.nextval, author_name, author_desc)
VALUES ('코난', '명탐정' );







-- 책 id번호 자동생성을 위한 시퀀스 sequence
create sequence seq_book_id
increment by 1
start with 1
nocache
;
--id 번호 자동생성 꼬일때 리셋
drop SEQUENCE seq_book_id; 
drop SEQUENCE seq_author_id; 
drop table book;

--책정보 입력하기 (자동생성 책id, 책제목, 출판사, 출판일, 저자id) 
INSERT INTO book VALUES (seq_book_id.nextval, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);

INSERT INTO book VALUES (seq_book_id.nextval, '삼국지', '민음사', '2002-03-01', 1);

INSERT INTO book VALUES (seq_book_id.nextval, '토지', '마로니에북스', '20120815', 2);

INSERT INTO book VALUES (seq_book_id.nextval, '유시민의 글쓰기 특강', '생각의길', '20150401', 3);

INSERT INTO book VALUES (seq_book_id.nextval, '패션왕', '중앙북스(books)', '20120222', 4);

INSERT INTO book VALUES (seq_book_id.nextval, '순정만화', '재미주의', '20110803', 5);

INSERT INTO book VALUES (seq_book_id.nextval, '오직두사람', '문학동네', '20170504', 6);

INSERT INTO book VALUES (seq_book_id.nextval, '26년', '재미주의', '20120204', 5);



INSERT INTO book VALUES (seq_book_id.nextval, 'title', 'pub', '20120815', id);


-- 책 정보 보기
SELECT    * FROM book;

-- 저자 정보 보기
SELECT    * FROM author;

-- 모든 정보 보기 (카디전)
SELECT    * FROM book, author
    where book.author_id = author.author_id;

--강풀(id 5번)의 author_desc 를 서울 특별시로 변경하기
UPDATE author
SET author_desc = '서울 특별시'
WHERE author_id = 5 ;

set author_desc = '1세대 온라인 만화가'

--author 테이블에서 기안84(id 4) 데이터를 삭제해 보세요
TRUNCATE TABLE author WHERE author_id = 2;

DELETE FROM book WHERE author_id = 1 ;

DELETE FROM author WHERE author_id = 4 ;
--포린키 때문에 삭제가 안된다 무슨 방법이 없을까?


--커밋 
commit;


