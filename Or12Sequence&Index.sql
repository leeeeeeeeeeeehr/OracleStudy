/* 파일명: Or12Sequence&Index.sql
시퀀스 & 인덱스
: 테이블의 기본키 필드에 순차적인 일련 번호를 부여하는 시퀀스와
검색 속도를 향상시킬 수 있는 인덱스 */

-- Study 계정에서 학습합니다.

/* 시퀀스 (Sequence)
- 테이블의 컬럼(필드)에 중복되지 않는 순차적인 일련 번호를 부여한다.
- 시퀀스는 테이블 생성 후 별도로 만들어야 한다.
  즉, 시퀀스는 테이블과 독립적으로 저장되고 생성된다. */
  
  /* [시퀀스 생성 구문]
  create sequence 시퀀스명
    [Increment by N] -> 증가치 설정
    [Start with N] -> 시작값 지정
    [MinValue | NoMinValue] -> 시퀀스 최소값 지정, 디폴트 1
    [MaxValue | NoMaxValue] -> 시퀀스 최대값 지정, 디폴트 1.00E + 28
    [Cycle | NoCycle] -> 최대/최소 값에 도달할 경우 처음부터 다시 시작할지
                               여부를 설정 (Cycle로 지정하면 최대값까지 증가 후
                               다시 시작값부터 재시작됨)
    [Cache | NoCache] -> cache 메모리에 오라클 서버가 시퀀스값을 할당하는가 여부를 지정 */

/* 시퀀스 생성 시 주의사항
1. Start with에 MinValue보다 작은 값을 지정할 수 없다.
   즉, Start with 값은 MinValue보다 같거나 커야 한다.
2. NoCycle로 설정하고 시퀀스를 계속 얻어올 때 MaxValue에 지정값을 초과하면 에러가 발생한다.
3. Primary key에는 Cycle 옵션을 절대 지정하면 안된다. */

create table tb_goods (
    idx  number(10) primary key,
    g_name varchar2(30)
);
insert into tb_goods values (1, '허니버터칩');
-- idx는 PK로 지정된 컬럼이므로 중복값이 입력되면 에러 발생된다.
insert into tb_goods values (1, '먹태깡');

-- 시퀀스 생성
create sequence seq_serial_num
    increment by 1       --> 증가치: 1
    start with 100         --> 초기값 (시작값): 100
    minvalue 99           --> 최소값: 99
    maxvalue 110         --> 최대값: 110
    cycle                     --> 최대값 도달 시 최소값부터 재시작할지 여부: Yes
    nocache;                --> 캐시 메모리 사용 여부: no

-- 데이터 사전에서 생성된 시퀀스 정보 확인
select * from user_sequences;
/* 시퀀스 생성 후 최초 실행 시에는 currval을 실행할 수 없어 에러가 발생한다.
nextval을 먼저 실행해서 시퀀스를 얻어온 후 사용해야 한다. */
select seq_serial_num.currval from dual;
/* 다음 입력할 시퀀스를 반환한다.
실행할 때마다 설정한 증가치만큼 증가된 값이 반환된다. */
select seq_serial_num.nextval from dual;
/* 시퀀스의 nextval을 사용하면 계속 새로운 값을 반환하므로
아래와 같이 insert문에 사용할 수 있다.
또한, 같은 문장을 여러번 실행하더라도 문제없이 입력된다.

단, 시퀀스의 cycle 옵션에 의해 최대값에 도달하면 시퀀스가 다시 처음부터 생성되므로
무결성 제약조건에 위배되어 에러가 발생한다.
즉, PK 컬럼에 사용할 시퀀스는 Cycle 옵션을 사용하지 않아야 한다. */
insert into tb_goods values (seq_serial_num.nextval, '먹태깡');
select * from tb_goods;

/* 시퀀스 수정
: 테이블과 동일하게 alter 명령을 사용한다.
단, start with는 수정할 수 없다. */
alter sequence seq_serial_num
    increment by 1
    minvalue 00
    nomaxvalue          --> 최대값 사용하지 않음 (= 표현할 수 있는 최대 범위를 사용함)
    nocycle                --> cycle 사용하지 않음
    nocache;               --> cache 메모리 사용하지 않음

/* 시퀀스 삭제 */
drop sequence seq_serial_num;
select * from user_sequences;

---------------- 삭제 후 다시 생성 ----------------
/* 일반적인 시퀀스 생성은 아래와 같이 하면 된다.
주로 PK로 지정된 컬럼에 일련 번호를 입력하는 용도로 사용되므로
최대값, 사이클, 캐시는 사용하지 않는 것을 권장한다. */
create sequence seq_serial_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;

/* 인덱스 (Index)
- 행의 검색 속도를 향상시킬 수 있는 개체
- 인덱스는 명시적(create index)과
  자동적(primary key, unique)으로 생성할 수 있다.
- 컬럼에 대한 인덱스가 없으면 테이블 전체를 검색한다.
- 즉, 인덱스는 쿼리의 성능을 향상시키는 것이 그 목적이다.
- 인덱스는 아래와 같은 경우에 설정한다.
    1 ) where 조건이나 join 조건에 자주 사용하는 컬럼
    2 ) 광범위한 값을 포함하는 컬럼
    3 ) 많은 null 값을 포함하는 컬럼 */

-- 인덱스 생성하기
create index tb_goods_name_idx on tb_goods (g_name);
-- 데이터 사전에서 확인
/* 결과를 보면 PK 혹은 Unique로 지정된 컬럼은
자동으로 인덱스가 생성되어있는 것을 볼 수 있다. */
select * from user_ind_columns;
-- 인덱스 삭제하기
drop index tb_goods_name_idx;
/* 인덱스는 수정이 불가능하다.
수정이 필요하다면 삭제 후 다시 생성해야 한다. */