/* 파일명: Or05Date.sql
날짜 함수
: 년, 월, 일, 시, 분, 초의 포맷으로 날짜 형식을 지정하거나
날짜를 계산할 때 활용하는 함수들 */

/* months_between()
: 현재 날짜와 기준 날짜 사이의 개월 수를 반환한다.

- 형식: months_between (현재 날짜, 기준 날짜(=과거 날짜)); */

-- 2020년01월01일부터 지금까지 몇 개월이 지났는가?
select
    months_between(sysdate, '2020-01-01') "전체 출력",
    ceil(months_between(sysdate, '2020-01-01')) "올림 처리",
    floor(months_between(sysdate, '2020-01-01')) "버림 처리"
from dual;

/* 퀴즈 ] 만약 "2020년01월01일" 문자열을 그대로 적용해서 개월 수를 계산하려면? */
select
    months_between(sysdate, to_date('2020년01월01일', 'yyyy"년"mm"월"dd"일"')) "지난 개월 수"
from dual;

/* last_day()
: 해당 월의 마지막 날짜를 반환한다. */

select last_day('22-04-03') from dual;  --> 4월은 30일까지 있음
select last_day('24-02-03') from dual;  --> 24년은 윤년이므로 29일 출력
select last_day('25-02-03') from dual;  --> 일반적으로 2월은 28일까지 있음

-- 컬럼이 date 타입인 경우 간단한 날짜 연산이 가능하다.
select
    sysdate "오늘",
    sysdate + 1 "내일",
    sysdate - 7 "일주일 전"
from dual;