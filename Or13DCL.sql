/* 파일명: Or13DCL.sql
DCL (Data Control Language, 데이터 제어어)
: 사용자 권한,
새로운 사용자 계정을 생성하고 시스템 권한을 부여하는 방법을 학습한다. */

/* [ 사용자 계정 생성 및 권한 설정 ]
- 해당 부분은 DBA 권한이 있는 최고 관리자 (= sys, system)으로 접속한 후 실행해야 한다.
- 새로운 사용자 계정이 생성된 후 접속 및 쿼리 실행 테스트는 CMD(= 명령 프롬프트)에서 진행한다. */

/* 1 ) 사용자 계정 생성 및 암호 설정
- 형식: create user 아이디 identified by 패스워드;

오라클 12c 이후부터는 일반 계정 생성 시 접두어로 C##을 추가해야만 계정을 생성할 수 있다.
따라서 아래와 같이 세션을 변경하는 명령을 통해 접두어 없이 계정을 생성해야 한다. */
alter session set "_ORACLE_SCRIPT"=true;
-- 새로운 사용자 계정 생성
create user test_user1 identified by 1234;
/* 계정 생성 직후 CMD에서 sqplus 명령으로 접속을 시도해보면
create session 권한이 없어 접속할 수 없다는 에러가 발생한다. */

/* 2 ) 생성된 사용자 계정에 권한 혹은 역할 부여
- 형식: grant 시스템권한1, 권한2 혹은 역할(Role)
            to 사용자계정
                [with grant 옵션] */

-- 접속 권한 부여
grant create session to test_user1;
/* create session 권한 부여 후 접속에는 성공했지만 테이블은 생성할 수 없다. */

-- 테이블 생성 권한 부여
grant create table to test_user1;
/* create table 권한 부여 후 테이블 생성 및 desc 명령으로 스키마를 확인할 수 있다. */

/* 3 ) 암호 변경
- 형식: alter user 사용자계정 identified by 변경할암호; */
alter user test_user1 identified by 4321;
/* exit 혹은 quit 명령으로 접속을 해제한 후 다시 접속하면 기존의 암호로는
접속할 수 없다. 변경한 암호로 접속해야 한다. */

/* 4 ) Role(= 롤, 역할)을 통해 여러 가지 권한을 동시에 부여하기
: 여러 사용자가 다양한 권한을 효과적으로 관리할 수 있도록
관련된 권한끼리 묶어놓은 것을 말한다.

※ 우리는 실습을 위해 새롭게 생성한 계정에 connect, resource 롤을 주로 부여한다. */

-- 두 번째 계정 생성 후 Role을 통해 권한을 부여한다.
create user test_user2 identified by 1234;
/* 아래 2개의 Role은 오라클에서 기본적으로 제공된다.
접속 및 테이블 생성 등 대부분의 기본 작업을 할 수 있는 권한이 포함되어 있다.  */
grant connect, resource to test_user2;

/* 4-1 ) Role 생성하기
: 사용자가 원하는 권한을 묶어 새로운 룰을 생성한다. */
create role my_role;

/* 4-2 ) Role에 권한 부여하기
: 새롭게 생성한 Role에 3가지 권한을 부여한다. */
grant create session, create table, create view to my_role;
-- 3번째 계정 생성
create user test_user3 identified by 1234;
-- 우리가 생성한 Role을 통해 권한을 부여한다.
grant my_role to test_user3;
/* my_role을 통해 권한을 부여했으므로 접속 및 테이블 생성이 가능하다. */

/* 4-3 ) Role 삭제하기 */
drop role my_role;
/* test_user3은 my_role을 통해 권한을 부여받았으므로 해당 Role을 삭제하면
모든 권한이 회수(Revoke) 된다. 즉, Role 삭제 후에는 접속 및 기타 작업을 할 수 없다. */

/* 5 ) 권한 제거 (회수)
- 형식: revoke 권한 혹은 롤 from 사용자계정; */
revoke create session from test_user1;
/* 접속 권한 회수 후 접속을 시도할 때 비밀번호가 틀리면 '부적합' 에러가 발생하고
비밀번호가 일치하면 create session 권한이 없다고 출력된다. */

/* 6 ) 사용자 계정 삭제
- 형식: drop user 사용자계정 [cascade];

※ cascade를 명시하면 사용자 계정과 관련된 모든 데이터베이스 스키마가
데이터 사전으로부터 삭제되고 모든 스키마 객체도 물리적으로 삭제된다. */

-- 현재 생성된 사용자 계정을 확인할 수 있는 데이터 사전
select username from dba_users;
select * from dba_users where username=upper('test_user1');
-- 계정을 삭제하면서 모든 물리적인 스키마까지 같이 삭제한다.
drop user test_user1 cascade;

