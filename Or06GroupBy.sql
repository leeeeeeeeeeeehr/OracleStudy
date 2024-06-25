/* 파일명: Or06GroupBy.sql
그룹 함수 (select문 2번째)
: 전체 레코드에서 통계적인 결과를 구하기 위해 하나 이상의 레코드를
그룹으로 묶어서 연산 후 결과를 반환하는 함수 혹은 쿼리문 */

-- 사원 테이블에서 담당 업무 인출, 총 107개가 인출된다.
select job_id from employees;
/* distinct
: 동일한 값이 있는 경우, 중복된 레코드를 제거한 후
하나의 레코드만 가져와서 보여준다.
순수한 하나의 레코드이므로 통계적인 값을 계산할 수 없다. */
select distinct job_id from employees;
/* group by
: 동일한 값이 있는 레코드를 하나의 그룹으로 묶어서 인출한다.
보여지는건 하나의 레코드지만 다수의 레코드가 하나의 그룹으로
묶여진 결과이므로 통계적인 값을 계산할 수 있다.
최대, 최소, 평균, 합계 등의 연산이 가능하다. */
select job_id from employees group by job_id;

-- 각 담당 업무 별 직원 수는 몇 명일까요?
select job_id, count(*) from employees group by job_id;
/* count() 함수를 통해 인출된 행의 갯수는
아래와 같이 일반적인 select문으로 검증할 수 있다. */
select * from employees where job_id='PU_CLERK';
select * from employees where job_id='SA_REP';

/* group by 절이 포함된 select문의 형식
: select
     컬럼1, 컬럼2, . . .  혹은 전체(*)
  from
     테이블명
  where
     조건1 and 조건2 or 조건3 (물리적으로 존재하는 컬럼)
  group by
     레코드의 그룹화를 위한 컬럼명
  having
     그룹에서의 조건 (논리적으로 생성된 컬럼)
  order by
     정렬을 위한 컬럼명과 정렬 방식 */

/* sum()
: 합계를 구할 때 사용하는 함수

- number 타입의 컬럼에서만 사용할 수 있다.
- 필드명이 필요한 경우 as를 이용해서 별칭을 부여할 수 있다. */

-- 전체 직원의 급여의 합계를 출력하시오.
select 
    sum(salary) sumSalary,
    to_char(sum(salary), '999,000') "+서식 지정",
    ltrim(to_char(sum(salary), '999,000')) "+공백 제거"
from employees;

-- 10번 부서에 근무하는 사원들의 급여 합계는 얼마인지 출력하시오.
select
    ltrim(to_char(sum(salary), '$999,000')) "sumSalary"
from employees where department_id=10;

/* count()
: 그룹화된 레코드의 갯수를 카운트할 때 사용하는 함수

- 아래 2가지 방법 모두 가능하지만 *를 사용할 것을 권장한다.
컬럼의 특성 혹은 데이터에 따른 방해를 받지 않으므로 실행 속도가 빠르다. */
select count(*) from employees;
select count(employee_id) from employees;

/* count() 함수의 사용법
1 ) count (all 컬럼명)
    : 디폴트 사용법으로 컬럼 전체의 레코드를 기준으로 카운트한다.
2 ) count (distinct 컬럼명)
    : 중복을 제거한 상태에서 카운트한다. */
select
    count(job_id) "담당 업무 전체 갯수 1", 
    count(all job_id) "담당 업무 전체 갯수 2",
    count(distinct job_id) "순수 담당 업무 갯수"
from employees;

/* avg()
: 평균값을 구할 때 사용하는 함수 */

-- 전체 사원의 평균 급여는 얼마인지 출력하는 쿼리문을 작성하시오.
select
    count(*) "전체 사원 수",                                  --> 총 사원 수
    sum(salary) "급여 합계",                                  --> 급여의 합계
    sum(salary) / count(*) "평균 급여 (직접 계산)",     --> 급여 평균
    avg(salary) "평균 급여 (함수 사용)",
    trim(to_char(avg(salary), '999,000.00'))
from employees;

/* 영업팀(SALES)의 평균 급여는 얼마인가요? */
-- 1단계 ) 부서 테이블에서 영업팀의 부서 번호가 몇 번인지 확인한다.
select * from departments where department_name='SALES';            --> 데이터의 대소문자가 다르므로 결과가 인출되지 않는다.
-- 2단계 ) 컬럼 자체의 값을 대문자로 변환 후 쿼리의 조건으로 사용한다.
select * from departments where upper(department_name)='SALES';  --> 80번 부서임을 확인한다.
-- 3단계 ) 80번 부서에서 근무하는 사원들의 평균 급여를 구해 출력한다.
select
    ltrim(to_char(avg(salary), '$999,000.0'))
from employees where department_id=80;