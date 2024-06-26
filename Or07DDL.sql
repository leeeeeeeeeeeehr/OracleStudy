/* 파일명: Or07DDL.sql
DDL (Data Definition Language, 데이터 정의어)
: 테이블, 뷰와 같은 객체를 생성 및 변경하는 쿼리문을 말한다. */

-- system 계정으로 접속한 후 아래 명령을 실행한다.

/* 새로운 사용자 계정을 생성한 후 접속 권한 및 테이블 생성 권한을 부여한다. */
alter session set "_ORACLE_SCRIPT"=true;
create user study identified by 1234;
grant connect, resource to study;

---------------------------------------------------------------------------------------

-- Study 계정을 디벨로퍼에 등록한 후 접속한다.
-- DDL문 실습은 Study 계정에서 진행한다.

-- 생성된 모든 계정에 논리적으로 존재하는 테이블
select * from dual;
/* 현재 접속한 계정에 생성된 테이블의 목록을 저장한 시스템 테이블로
이와 같이 관리의 목적으로 생성된 테이블을 '데이터 사전'이라고 표현한다. */
select * from tab;

/* 테이블 생성하기
- 형식: create table 테이블명 (
                컬러명1 자료형(크기),
                컬러명1 자료형(크기),
                컬러명1 자료형(크기)
                . . .
                primary key(컬럼명) 등의 제약 조건 추가
                ); */
                
create table tb_member (
    idx number(10),                --> 숫자형 (정수)
    userid varchar2(30),           --> 문자형
    passwd varchar2(50),
    username varchar2(30),
    mileage number(7, 2)         --> 숫자형 (실수)
);
-- 접속한 계정에 생성된 테이블의 목록을 확인한다.
select * from tab;
/* 테이블의 구조(스키마) 확인
컬럼명, 자료형, 크기를 확인할 수 있다. */
desc tb_member;

/* 기존 생성된 테이블에 새로운 컬럼 추가하기
-> tb_member 테이블에 email 컬럼을 추가하시오.

- 형식: alter table 테이블명 add 추가할컬럼명 자료형(크기) 제약조건; */
alter table tb_member add email varchar2(100);
desc tb_member;

/* 기존 생성된 테이블의 컬럼 수정(변경)하기
-> tb_member 테이블의 email 컬럼의 사이즈를 200으로 확장하시오. 
    또한, 이름이 저장되는 컬럼의 사이즈도 60으로 확장하시오.

- 형식: alter table 테이블명 modify 수정할컬럼명 자료형(크기); */
alter table tb_member modify email varchar2(200);
alter table tb_member modify username varchar2(60);
desc tb_member;

/* 기존 생성된 테이블에서 컬럼 삭제하기
-> tb_member 테이블의 mileage 컬럼을 삭제하시오.

- 형식: alter table 테이블명 drop column 삭제할 컬럼명; */
alter table tb_member drop column mileage;
desc tb_member;

/* 퀴즈 ] 테이블 정의서로 작성한 employees 테이블을
해당 study 계정에 그대로 생성하시오. 단, 제약 조건은 명시하지 않습니다. */
create table employees(
    employee_id number(6),
    first_name varchar2(20),
    last_name varchar2(25),
    email varchar2(25),
    phone_number varchar2(20),
    hire_date date,
    job_id varchar2(10),
    salary number(8, 2),
    commission_pct number(8, 2),
    manager_id number(6),
    department_id number(4)
);
desc employees;

/* 테이블 삭제하기
-> employees 테이블은 더 이상 사용하지 않으므로 삭제하시오. 

- 형식: drop table 삭제할테이블명; */
drop table employees;
desc employees;
select * from tab;

-- 테이블은 삭제(drop)하면 휴지통(recyclebin)에 임시 보관된다.
show recyclebin;
-- 휴지통 비우기
purge recyclebin;
-- 휴지통에 보관된 테이블 복원하기, 여기서는 employees를 복원한다.
flashback table employees to before drop;

/* tb_member 테이블에 새로운 레코드를 삽입한다. (DML에서 학습 예정)
하지만 테이블 스페이스가 부족해서 삽입할 수 없는 상태이다. */
insert into tb_member values (1, 'tjoeun', '1234', '더조은', 'tj@naver.com');

/* Oracle 11g에서는 새로운 계정을 생성한 후
connect, resource 롤(Role)만 부여하면 테이블 생성 및 삽입까지 되지만
그 이후 버전에서는 테이블 스페이스 관련 오류가 발생한다.
따라서 아래와 같이 테이블 스페이스에 대한 권한도 함께 부여해야 한다. */

-- cmd를 사용하고 있다면 conn 명령을 통해 다른 계정으로 스위칭 한다.
/* conn system/123456; */
-- 디벨로퍼에서는 우측 상단의 접속 콤보 박스를 통해 system 계정으로 변경한 후 명령을 실행한다.
grant unlimited tablespace to study;        --> Study 계정으로는 불가능함

-- 레코드 삽입을 위해 study 계정으로 전환 후 insert 쿼리를 실행한다.
insert into tb_member values (2, 'hong', '1234', '홍조은', 'hong@naver.com');
insert into tb_member values (3, 'sung', '1234', '성조은', 'sung@naver.com');
-- 삽입된 레코드를 확인
select * from tb_member;
-- true의 조건이므로 모든 레코드를 대상으로 인출한다.
select * from tb_member where 1=1;
-- false의 조건이므로 레코드를 인출하지 않는다.
select * from tb_member where 1=0;

-- 테이블 복사 1 ) 스키마(구조)만 복사하기
create table tb_member_copy
as 
select * from tb_member where 1=0;
-- 테이블이 복사되었는지 확인
desc tb_member_copy;
-- 테이블의 구조만 복사되었으므로 레코드는 인출되지 않는다. 
select * from tb_member_copy;

-- 테이블 복사 2 ) 스키마(구조)와 레코드까지 모두 복사하기
create table tb_member_clone
as 
select * from tb_member where 1=1;
-- 테이블이 복사되었는지 확인
desc tb_member_clone;
-- true의 조건으로 레코드까지 복사했으므로 인출된다.
select * from tb_member_clone;