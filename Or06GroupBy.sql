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

/* min() / max()
: 최소값, 최대값을 찾을 때 사용하는 함수 */

/* 전체 사원 중 급여가 가장 적은 직원은 누구인가요? */

/* 아래 쿼리문은 에러가 발생한다.
그룹 함수는 일반 컬럼에 바로 사용할 수 없다.
이와 같은 경우에는 뒤에서 학습할 '서브쿼리'를 사용해야 한다. */
select first_name, sal from employees where salary=min(salary);

-- 전체 사원 중 가장 낮은 급여는 얼마인가요? (= 급여의 최소값은 얼마인가요?)
select min(salary) from employees;
-- 따라서 2100을 받는 직원을 찾으면 해결할 수 있다.
select first_name, last_name, salary
from employees where salary=2100;
-- 위 2개의 쿼리문을 합치면 아래와 같은 서브쿼리가 된다.
select first_name, last_name, salary
from employees where salary=(select min(salary) from employees);

/* group by 절
: 여러 개의 레코드를 하나의 그룹으로 그룹화하여 묶여진 결과를 반환하는 쿼리문

주의 ) distinct는 단순히 중복값을 제거한다. */

/* 사원 테이블에서 각 부서별 급여의 합계는 얼마인가요? */
-- 60번(= IT) 부서의 급여 합계
select sum(salary) from employees where department_id=60;
-- 100번(= Finance) 부서의 급여 합계
select sum(salary) from employees where department_id=100;

/* 1단계 ) 부서가 많은 경우 일일이 부서별로 확인할 수 없으므로 부서를 그룹화한다.
중복이 제거된 결과로 보이지만 동일한 레코드가 하나의 그룹으로 합쳐진 결과가 인출된다. */
select department_id
from employees group by department_id;
/* 2단계 ) 각 부서별로 급여의 합계를 구할 수 있다. */
select department_id, sum(salary)
from employees group by department_id;

/* 아래 쿼리문은 부서 번호를 그룹으로 묶어서 결과를 인출하므로
이름을 기술하면 에러가 발생한다.
각 레코드 별로 서로 다른 이름이 저장되어 있으므로
그룹의 조건에 단일 컬럼을 사용할 수 없기 때문이다. */
select department_id, sum(salary), first_name
from employees group by department_id;
--> fist_name 때문에 에러 발생

/* 퀴즈 ] 사원 테이블에서 각 부서별 사원 수와 평균 급여는 얼마인지 출력하는
쿼리문을 작성하시오. 출력 시 부서 번호를 기준으로 오름차순 정렬하시오.

- 출력: 부서 번호, 급여 총합, 사원 총합, 평균 급여 */
select
    department_id,
    trim(to_char(sum(salary), '999,000')) sum_salary,
    count(*) cnt_employee,
    trim(to_char(floor(avg(salary)), '999,000')) avg_salary
from employees group by department_id order by department_id;

/* having
: 물리적으로 존재하는 컬럼이 아닌 그룹 함수를 통해
논리적으로 생성된 컬럼의 조건을 추가할 때 사용한다.
해당 조건을 where 절에 추가하면 에러가 발생한다. */

/* 시나리오 ] 사원 테이블에서 각 부서별로 근무하고 있는 직원의
담당 업무별 사원 수와 평균 급여가 얼마인지 출력하는 쿼리문을 작성하시오.
단, 사원 수가 10을 초과하는 레코드만 인출하시오. */

/* 같은 부서에서 근무하더라도 담당 업무는 다를 수 있으므로
이 문제에서는 group by 절에 2개의 컬럼을 명시해야 한다.
즉, 부서로 그룹화한 후 다시 담당 업무별로 그룹화한다. */
select
    department_id, job_id, count(*),
    trim(to_char(floor(avg(salary)), '999,000')) avg_salary
from employees
where count(*)>10                             --> 이 부분에서 에러가 발생된다.
group by department_id, job_id;
/* 담당 업무별 사원 수는 물리적으로 존재하는 컬럼이 아니므로
where 절에 추가하면 에러가 발생한다.
이 경우에는 having 절에 조건을 추가해야 한다. 

ex ) 급여가 3000인 사원 => 물리적으로 존재하므로 where 절에 추가
      평균 급여가 3000인 사원 => 개발자가 상황에 맞게 논리적으로 만들어낸 결과이므로
                                            having 절에 추가해야 함 */

/* 앞에서 발생한 문제는 having 절로 조건을 옮기면 해결된다. */
select
    department_id, job_id,
    count(*),
    trim(to_char(floor(avg(salary)), '999,000')) avg_salary
from employees
group by department_id, job_id
having count(*)>10;

/* 시나리오 ] 담당 업무별 사원의 최저 급여를 출력하시오.
단, '관리자(Manager)가 없는 사원과 최저 급여가 3000 미만인 그룹'은 제외시키고
결과를 급여의 내림차순으로 정렬하여 출력하시오. */

/* 관리자가 없는 사원은 물리적으로 존재하므로 where 절에 기술한다.
최저 급여는 그룹 함수를 통해 만들어진 결과이므로 having 절에 기술한다.
select 절에 사용한 가상의 컬럼 (계산식 등)은 order by 절에 사용할 수 있다. */
select job_id, min(salary)
from employees where manager_id is not null
group by job_id having not min(salary)<3000
order by min(salary) desc;
