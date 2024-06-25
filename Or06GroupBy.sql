/* ���ϸ�: Or06GroupBy.sql
�׷� �Լ� (select�� 2��°)
: ��ü ���ڵ忡�� ������� ����� ���ϱ� ���� �ϳ� �̻��� ���ڵ带
�׷����� ��� ���� �� ����� ��ȯ�ϴ� �Լ� Ȥ�� ������ */

-- ��� ���̺��� ��� ���� ����, �� 107���� ����ȴ�.
select job_id from employees;
/* distinct
: ������ ���� �ִ� ���, �ߺ��� ���ڵ带 ������ ��
�ϳ��� ���ڵ常 �����ͼ� �����ش�.
������ �ϳ��� ���ڵ��̹Ƿ� ������� ���� ����� �� ����. */
select distinct job_id from employees;
/* group by
: ������ ���� �ִ� ���ڵ带 �ϳ��� �׷����� ��� �����Ѵ�.
�������°� �ϳ��� ���ڵ����� �ټ��� ���ڵ尡 �ϳ��� �׷�����
������ ����̹Ƿ� ������� ���� ����� �� �ִ�.
�ִ�, �ּ�, ���, �հ� ���� ������ �����ϴ�. */
select job_id from employees group by job_id;

-- �� ��� ���� �� ���� ���� �� ���ϱ��?
select job_id, count(*) from employees group by job_id;
/* count() �Լ��� ���� ����� ���� ������
�Ʒ��� ���� �Ϲ����� select������ ������ �� �ִ�. */
select * from employees where job_id='PU_CLERK';
select * from employees where job_id='SA_REP';

/* group by ���� ���Ե� select���� ����
: select
     �÷�1, �÷�2, . . .  Ȥ�� ��ü(*)
  from
     ���̺��
  where
     ����1 and ����2 or ����3 (���������� �����ϴ� �÷�)
  group by
     ���ڵ��� �׷�ȭ�� ���� �÷���
  having
     �׷쿡���� ���� (�������� ������ �÷�)
  order by
     ������ ���� �÷���� ���� ��� */

/* sum()
: �հ踦 ���� �� ����ϴ� �Լ�

- number Ÿ���� �÷������� ����� �� �ִ�.
- �ʵ���� �ʿ��� ��� as�� �̿��ؼ� ��Ī�� �ο��� �� �ִ�. */

-- ��ü ������ �޿��� �հ踦 ����Ͻÿ�.
select 
    sum(salary) sumSalary,
    to_char(sum(salary), '999,000') "+���� ����",
    ltrim(to_char(sum(salary), '999,000')) "+���� ����"
from employees;

-- 10�� �μ��� �ٹ��ϴ� ������� �޿� �հ�� ������ ����Ͻÿ�.
select
    ltrim(to_char(sum(salary), '$999,000')) "sumSalary"
from employees where department_id=10;

/* count()
: �׷�ȭ�� ���ڵ��� ������ ī��Ʈ�� �� ����ϴ� �Լ�

- �Ʒ� 2���� ��� ��� ���������� *�� ����� ���� �����Ѵ�.
�÷��� Ư�� Ȥ�� �����Ϳ� ���� ���ظ� ���� �����Ƿ� ���� �ӵ��� ������. */
select count(*) from employees;
select count(employee_id) from employees;

/* count() �Լ��� ����
1 ) count (all �÷���)
    : ����Ʈ �������� �÷� ��ü�� ���ڵ带 �������� ī��Ʈ�Ѵ�.
2 ) count (distinct �÷���)
    : �ߺ��� ������ ���¿��� ī��Ʈ�Ѵ�. */
select
    count(job_id) "��� ���� ��ü ���� 1", 
    count(all job_id) "��� ���� ��ü ���� 2",
    count(distinct job_id) "���� ��� ���� ����"
from employees;

/* avg()
: ��հ��� ���� �� ����ϴ� �Լ� */

-- ��ü ����� ��� �޿��� ������ ����ϴ� �������� �ۼ��Ͻÿ�.
select
    count(*) "��ü ��� ��",                                  --> �� ��� ��
    sum(salary) "�޿� �հ�",                                  --> �޿��� �հ�
    sum(salary) / count(*) "��� �޿� (���� ���)",     --> �޿� ���
    avg(salary) "��� �޿� (�Լ� ���)",
    trim(to_char(avg(salary), '999,000.00'))
from employees;

/* ������(SALES)�� ��� �޿��� ���ΰ���? */
-- 1�ܰ� ) �μ� ���̺��� �������� �μ� ��ȣ�� �� ������ Ȯ���Ѵ�.
select * from departments where department_name='SALES';            --> �������� ��ҹ��ڰ� �ٸ��Ƿ� ����� ������� �ʴ´�.
-- 2�ܰ� ) �÷� ��ü�� ���� �빮�ڷ� ��ȯ �� ������ �������� ����Ѵ�.
select * from departments where upper(department_name)='SALES';  --> 80�� �μ����� Ȯ���Ѵ�.
-- 3�ܰ� ) 80�� �μ����� �ٹ��ϴ� ������� ��� �޿��� ���� ����Ѵ�.
select
    ltrim(to_char(avg(salary), '$999,000.0'))
from employees where department_id=80;