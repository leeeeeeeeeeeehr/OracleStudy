/* 파일명: Or09Join.sql 
테이블 조인
: 두 개 이상의 테이블을 동시에 참조하여 데이터를 가져와야 할 때 사용하는 SQL문 */

-- HR 계정에서 진행한다. 

/* inner join (내부 조인)
- 가장 많이 사용하는 조인문으로
  테이블 간에 연결 조건을 모두 만족하는 레코드를 검색할 때 사용한다.
- 일반적으로 기본키(Primary key)와 외래키(Foreign key)를 사용하여 join 하는 경우가 대부분이다.
- 두 개의 테이블에 동일한 이름의 컬럼이 존재하면 '테이블명.컬럼명' 형태로 기술해야 한다.
- 테이블의 별칭을 사용하면 '별칭.컬럼명' 형태롤 기술할 수 있다. */

/* 형식 1 ) 표준 방식: select 컬럼1, 컬럼2
                            from 테이블1 inner join 테이블2
                                on 테이블1.기본키컬럼 = 테이블2.외래키컬럼
                            where 조건1 and 조건2 . . . ; */
    
/* 시나리오 ] 사원 테이블과 부서 테이블을 조인하여 각 직원이
어떤 부서에서 근무하는지 출력하시오. 단, 표준 방식으로 작성하시오.
- 출력 결과: 사원 아이디, 이름, 성, 이메일, 부서 번호, 부서명 */
select
    employee_id,
    first_name,
    last_name,
    email,
    department_id,         --> 에러 발생
    department_name
from employees inner join departments
    on employees.department_id = departments.department_id;
/* 위의 쿼리문을 실행하면 열의 정의가 애매하다는 에러가 발생한다.
부서 번호를 뜻하는 department_id가 양쪽 테이블에 모두 존재하므로
어떤 테이블에서 가져와 인출해야할지 명시해야 한다. */
select
    employee_id,
    first_name,
    last_name,
    email,
    employees.department_id,                      
    department_name
from employees inner join departments
    on employees.department_id = departments.department_id;
/* 실행 결과에서는 소속된 부서가 없는 1명을 제외한 나머지 106명의 레코드가 인출된다.
즉, inner join은 조인한 테이블 양쪽 모두 만족되는 레코드가 인출된다.*/

-- as (= 알리아스)를 통해 테이블에 별칭을 부여하면 쿼리문이 간단해진다.
select
    employee_id,
    first_name,
    last_name,
    email,
    Emp.department_id,                      
    department_name
from employees Emp inner join departments Dep
    on Emp.department_id = Dep.department_id;

/* 3개 이상의 테이블 조인하기

시나리오 ] seattle(시애틀)에 위치한 부서에서 근무하는 직원의 정보를 출력하는
쿼리문을 작성하시오. 단, 표준 방식으로 작성하시오. 

- 출력 결과: 사원 이름, 이메일, 부서 아이디, 부서명, 담당업무 아이디, 담당업무명, 근무 지역

위 출력 결과는 다음 테이블에 존재한다. 
- 사원 테이블: 사원 이름, 이메일, 부서 아이디, 담당업무 아이디
- 부서 테이블: 부서 아이디 (참조), 부서명, 지역 일련번호 (참조)
- 담당업무 테이블: 담당업무명, 담당업무 아이디 (참조)
- 지역 테이블: 근무 부서, 지역 일련번호 (참조) */

-- 1 ) 지역 테이블을 통해 seattle이 위치한 레코드의 일련번호를 찾아본다.
select * from locations where city=initcap('seattle');      --> 지역 일련번호가 '1700'인 것을 확인
-- 2 ) 지역 일련번호를 통해 부서 테이블의 레코드를 확인한다. 
select * from departments where location_id=1700;     --> 21개의 부서가 있는 것을 확인
-- 3 ) 부서 일련번호를 통해 사원 테이블의 레코드를 확인한다.
select * from employees where department_id=10;      --> 1명 확인
select * from employees where department_id=30;      --> 6명 확인
-- 4 ) 담당업무명 확인하기
select * from jobs where job_id='PU_MAN';                --> Purchasing Manager
select * from jobs where job_id='PU_CLERK';               --> Purchasing Clerk
-- 5 ) join 쿼리문 작성
/* 양쪽 테이블에 동시에 존재하는 칼럼인 경우에는
반드시 테이블명이나 별칭을 명시해야 한다. */
select
    first_name, last_name, email,
    departments.department_id, department_name,
    city, state_province,
    jobs. job_id, job_title
from locations
    inner join departments
        on locations.location_id = departments.location_id
    inner join employees
        on employees.department_id = departments.department_id
    inner join jobs
        on employees.job_id = jobs.job_id
where city=initcap('seattle');
-- 6 ) 테이블의 별칭을 사용하여 쿼리문을 조금 더 간단하게 만들기
select
    first_name, last_name, email,
    D.department_id, department_name,
    city, state_province,
    J. job_id, job_title
from locations L
    inner join departments D
        on L.location_id = D.location_id
    inner join employees E
        on E.department_id = D.department_id
    inner join jobs J
        on E.job_id = J.job_id
where city=initcap('seattle');

/* 형식 2 ) 오라클 방식: select 컬럼1, 컬럼2, . . .
                               from 테이블1, 테이블2
                               where
                                    테이블1.기본키컬럼 = 테이블2.외래키컬럼
                                    and 조건1 and 조건2 . . . ; 
                                    
- 표준 방식에서 사용한 inner join과 on을 제거하고 조인의 조건을 where절에 표기하는 방식이다. */

/* 시나리오 ] 사원 테이블과 부서 테이블을 조인하여 각 직원이 어떤 부서에서 근무하는지
출력하시오. 단, 오라클 방식으로 작성하시오.
- 출력 결과: 사원 아이디, 이름, 성, 이메일, 부서 번호, 부서명 */
select
    employee_id, first_name, last_name, email,
    Dep.department_id, department_name
from employees Emp, departments Dep
where
    Emp.department_id = Dep.department_id;
    
/* 시나리오 ] seattle(시애틀)에 위치한 부서에서 근무하는 직원의 정보를 출력하는
쿼리문을 작성하시오. 단, 오라클 방식으로 작성하시오. 

- 출력 결과: 사원 이름, 이메일, 부서 아이디, 부서명, 담당업무 아이디, 담당업무명, 근무 지역

위 출력 결과는 다음 테이블에 존재한다. 
- 사원 테이블: 사원 이름, 이메일, 부서 아이디, 담당업무 아이디
- 부서 테이블: 부서 아이디 (참조), 부서명, 지역 일련번호 (참조)
- 담당업무 테이블: 담당업무명, 담당업무 아이디 (참조)
- 지역 테이블: 근무 부서, 지역 일련번호 (참조) */
select
    first_name, last_name, email,
    D.department_id, department_name,
    J.job_id, job_title,
    city, state_province
from locations L, departments D, employees E, jobs J
where
    L.location_id = D.location_id
    and D.department_id = E.department_id
    and E.job_id = J.job_id
    and lower(city)='seattle';

/* outer join (외부 조인)
: outer join은 inner join과 달리 두 테이블에 조인 조건이 정확히 일치하지 않아도
기준이 되는 테이블에서 레코드를 인출하는 방식이다.
outer join을 사용할 때는 반드시 기준이 되는 테이블을 결정하고 쿼리문을 작성해야 한다.
-> left (왼쪽 테이블 기준), right (오른쪽 테이블 기준), full (양쪽 테이블) */

/* 형식 1 ) 표준 방식: select 컬럼1, 컬럼2, . . .
                            from 테이블1
                                left [right, full] outer join
                                    on 테이블1.기본키 = 테이블2.참조키
                            where 조건1 and 조건2 or 조건3 . . . ; */

/* 시나리오 ] 전체 직원의 사원 번호, 이름, 부서 아이디, 부서명, 지역을
외부 조인 (left)을 통해 출력하시오. */
select
    employee_id, first_name, last_name,
    De.department_id, department_name,
    city
from employees Em
    left outer join departments De
        on Em.department_id = De.department_id
    left outer join locations Lo
        on De.location_id = Lo.location_id;
/* 실행 결과를 보면 내부 조인과는 다르게 107개의 레코드가 인출된다.
(내부 조인은 106개의 레코드가 인출되었다.)
부서가 지정되지 않은 사원까지 인출되기 때문이다.
이 경우 부서 쪽에 레코드가 없으므로 null 값이 출력된다. */

/* 형식 2 ) 오라클 방식: select 컬럼1, 컬럼2
                               from 테이블1, 테이블2
                               where
                                    테이블1.기본키 = 테이블2.외래키 (+)
                                    and 조건1 and 조건2 or 조건3 . . . ;

- 오라클 방식으로 변경 시에는 outer join 연산자인 (+)를 붙여준다.
- 위의 경우 왼쪽 테이블이 기준이 된다.
- 기준이 되는 테이블을 변경할 때는 테이블의 위치를 옮겨준다.
  (+)를 옮기지 않는다. */
  
/* 시나리오 ] 전체 직원의 사원 번호, 이름, 부서 아이디, 부서명, 지역을
외부 조인 (left)을 통해 출력하시오. 단, 오라클 방식을 사용하시오. */
select
    employee_id, first_name, last_name,
    De.department_id, department_name,
    city
from employees Em, departments De, locations Lo
where
    Em.department_id = De.department_id (+)
    and De.location_id = Lo.location_id (+);
