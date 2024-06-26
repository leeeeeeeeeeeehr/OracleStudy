/* 파일명: Or08DML.sql
DML (Data Manipulation Language, 데이터 조작어)
: 레코드를 조작할 때 사용하는 쿼리문,
앞에서 학습했던 select문을 비롯하여
update(레코드 수정), delete(레코드 삭제), insert(레코드 입력)가 있다. */

-- Study 계정에서 실습한다.

-- 새로운 테이블 생성하기 
create table tb_sample (
    no number(10),
    name varchar2(20),
    loc varchar2(15),
    manager varchar2(30)
);
desc tb_sample;

/* insert
: 레코드 입력하기,
레코드 입력을 위한 쿼리문으로 문자형은 반드시 ' '로 감싸야 하고, 숫자형은 ' ' 없이 기술한다.
만약, 숫자형에 ' '을 감싸는 경우에는 자동으로 변환되어 입력된다. */

-- 레코드 입력 1 ) 컬럼을 지정한 후 insert 한다.
insert into tb_sample (no, name, loc, manager)
    values (10, '기획실', '서울', '유비');
insert into tb_sample (no, name, loc, manager)
    values (20, '전산팀', '수원', '관우');
select * from tb_sample;

-- 레코드 입력 2 ) 컬럼 지정 없이 전체 컬럼을 대상으로 insert 한다.
insert into tb_sample
    values (30, '영업실', '대구', '장비');
insert into tb_sample values
    (40, '인사실', '부산', '조자룡');
select * from tb_sample;

/* 컬럼을 지정해서 insert 하는 경우 데이터를 삽입하지 않을 컬럼을 지정할 수 있다.
아래의 경우 name 컬럼은 null 값이 입력된다. */
insert into tb_sample (no, loc, manager)
    values (50, '제주', '동탁');
select * from tb_sample;

/* 지금까지의 작업(트랜잭션)을 그대로 유지하겠다는 명령으로
커밋을 수행하지 않으면 외부에서는 변경된 레코드를 확인할 수 없다.
여기서 말하는 외부란 Java/JSP와 같은 Oracle 이외의 프로그램을 말한다.

※ 트랜잭션: 송금과 같은 하나의 단위 작업을 말한다. */
commit;

-- 커밋 이후 새로운 레코드를 삽입하면 임시 테이블에 저장된다.
insert into tb_sample (no, loc, manager) values (60, '태국', '손오공');
-- select 명령문으로 확인할 수 있지만 실제 테이블에는 반영되지 않은 상태이다.
select * from tb_sample;
-- 롤백 명령으로 마지막 커밋 상태로 되돌릴 수 있다.
rollback;
-- 마지막 커밋 작업 이후에 입력한 '손오공'은 제거된다.
select * from tb_sample;

/* update
: 레코드 수정하기

- 형식: update 테이블명
            set 컬럼1=값, 컬럼2=값, . . .
            where 조건;

※ 조건이 없는 경우 모든 레코드가 한꺼번에 수정된다.
※ 테이블명 앞에 from이 들어가지 않는다. */

-- 번호가 40인 레코드의 지역을 '미국'으로 수정하시오.
update tb_sample set loc='미국' where no=40;
select * from tb_sample;
-- 지역이 서울인 레코드의 매니저명을 '제갈공명'으로 변경하시오.
update tb_sample set manager='제갈공명' where loc='서울';
select * from tb_sample;
/* 모든 레코드를 대상으로 지역을 '종각'으로 변경하시오.
 전체 레코드가 대상인 경우에는 where 절을 생략한다. */
update tb_sample set loc='종각';
select * from tb_sample;

/* delete
: 레코드 삭제하기

- 형식: delete from 테이블명 where 조건;

※ 레코드를 삭제하므로 delete 뒤에 컬럼을 명시하지 않는다. */

-- 번호가 10인 레코드를 삭제하시오.
delete from tb_sample where no=10;
select * from tb_sample;
-- 레코드 전체를 삭제하시오.
delete from tb_sample;
select * from tb_sample;

-- 마지막에 커밋했던 지점으로 되돌려준다.
rollback;
select * from tb_sample;


/* DDL문 (Date Definition Language, 데이터 정의어)
: 테이블을 생성 및 조작하는 쿼리문

- 테이블 생성: create table 테이블명
- 테이블 수정
        - 컬럼 추가: alter table 테이블명 add 컬럼명
        - 컬럼 수정: alter table 테이블명 modify 컬럼명
        - 컬럼 삭제: alter table 테이블명 drop column 컬럼명
- 테이블 삭제: drop table 테이블명

-----------------------------------------------------------------

DML문 (Date Manipulation Language, 데이터 조작어)
: 레코드를 입력 및 조작하는 쿼리문

- 레코드 입력: insert into 테이블명 (컬럼) values (값)
- 레코드 수정: update 테이블명 set 컬럼=값 where 조건
- 레코드 삭제: delete from 테이블명 where 조건 */


