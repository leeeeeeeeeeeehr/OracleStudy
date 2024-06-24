/* 파일명: Or02Number.sql
숫자(수학) 관련 함수
: 숫자 데이터를 처리하기 위한 숫자 관련 함수를 학습,
테이블 생성 시 number 타입으로 선언된 컬럼에 저장된 데이터를 대상으로 한다. */

-- 현재 접속한 계정에 생성된 테이블, 뷰의 목록을 보여준다.
select * from tab;
-- 이와 같이 테이블이 없는 경우에는 쿼리 에러가 발생한다.
select * from tjoeun;

/* Dual 테이블
: 하나의 행으로 결과를 출력하기 위해 제공되는 테이블로
오라클에서 자동으로 생성되는 논리적 테이블이다.
varchar2(1)로 정의된 dummy라는 단 하나의 컬럼으로 구성되어 있다. */
select * from dual;

/* abs()
: 절대값 구하기 */
select abs(12000) from dual;
select abs(-9000) from dual;
select abs(salary) "급여의 절대값" from employees;

/* trunc()
: 소수점을 특정 자리수에서 잘라낼 때 사용하는 함수

- 형식: trunc (컬럼명 혹은 값, 소수점 이하 자리수)
         두 번째 인자가
            - 양수일 때: 주어진 숫자만큼 소수점을 표현
            - 없을 때: 정수부만 표현, 즉 소수점 아래 부분은 버림
            - 음수일 때: 정수부를 숫자만큼 잘라 나머지를 0으로 채움 */
            
-- 
select trunc(12345.12345, 2) from dual;      --> 12345.12
select trunc(12345.12345) from dual;         --> 12345
select trunc(12345.12345, -2) from dual;     --> 12300

/* 시나리오 ] 사원 테이블에서 영업 사원의 급여에 대한 커미션을 계산하여
합한 결과를 출력하는 쿼리문을 작성하시오.
ex ) 급여: 1000, 보너스율: 0.1
      => 1000 + ( 1000 * 0.1) = 1100 */

-- 1-1 ) 영업 사원을 찾아 인출한다. (영업 사원의 job_id는 SA_XX로 되어있다.)
select * from employees where job_id like 'SA_%';
-- 1-2 ) 영업 사원은 커미션을 받기 때문에 값이 입력되어 있다.
select * from employees where commission_pct is not null;

-- 2 ) 커미션을 계산하여 이름과 함께 출력한다.
select first_name, salary, commission_pct, salary+(salary*commission_pct)   
from employees where job_id like 'SA_%';

-- 3 ) 커미션을 소수점 1자리까지로만 금액 계산한다.
select first_name, salary, trunc(commission_pct, 1), salary+(salary*trunc(commission_pct, 1))  
from employees where job_id like 'SA_%';

-- 4 ) 계산식이 포함된 컬럼명에 별칭을 부여한다.
select first_name, salary, trunc(commission_pct, 1) as comm_pct, salary+(salary*trunc(commission_pct, 1)) TotalSalary
from employees where job_id like 'SA_%';