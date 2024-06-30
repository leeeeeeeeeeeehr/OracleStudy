/* JDBC 프로그래밍 실습을 위한 워크시트 */

/* Java에서 member 테이블에 CRUD 기능 구현하기 */

--  member 테이블 생성
create table member (
    /* id, pass, name은 문자 타입으로 선언했다.
    null 값을 허용하지 않는 컬럼으로 정의했다.
    즉, 반드시 입력값이 있어야 insert가 가능하다. */
	id varchar2(30) not null,
	pass varchar2(40) not null,
	name varchar2(50) not null,
    /* 날짜 타입으로 선언했다.
    null을 허용하는 컬럼으로 정의했다.
    만약, 입력값이 없다면 현재 시각(sysdate)을 디폴트로 입력한다. */
	regidate date default sysdate,
    /* 아이디를 기본키로 지정했다. */
	primary key (id)
);
