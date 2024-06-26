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

/* min() / max()
: �ּҰ�, �ִ밪�� ã�� �� ����ϴ� �Լ� */

/* ��ü ��� �� �޿��� ���� ���� ������ �����ΰ���? */

/* �Ʒ� �������� ������ �߻��Ѵ�.
�׷� �Լ��� �Ϲ� �÷��� �ٷ� ����� �� ����.
�̿� ���� ��쿡�� �ڿ��� �н��� '��������'�� ����ؾ� �Ѵ�. */
select first_name, sal from employees where salary=min(salary);

-- ��ü ��� �� ���� ���� �޿��� ���ΰ���? (= �޿��� �ּҰ��� ���ΰ���?)
select min(salary) from employees;
-- ���� 2100�� �޴� ������ ã���� �ذ��� �� �ִ�.
select first_name, last_name, salary
from employees where salary=2100;
-- �� 2���� �������� ��ġ�� �Ʒ��� ���� ���������� �ȴ�.
select first_name, last_name, salary
from employees where salary=(select min(salary) from employees);

/* group by ��
: ���� ���� ���ڵ带 �ϳ��� �׷����� �׷�ȭ�Ͽ� ������ ����� ��ȯ�ϴ� ������

���� ) distinct�� �ܼ��� �ߺ����� �����Ѵ�. */

/* ��� ���̺��� �� �μ��� �޿��� �հ�� ���ΰ���? */
-- 60��(= IT) �μ��� �޿� �հ�
select sum(salary) from employees where department_id=60;
-- 100��(= Finance) �μ��� �޿� �հ�
select sum(salary) from employees where department_id=100;

/* 1�ܰ� ) �μ��� ���� ��� ������ �μ����� Ȯ���� �� �����Ƿ� �μ��� �׷�ȭ�Ѵ�.
�ߺ��� ���ŵ� ����� �������� ������ ���ڵ尡 �ϳ��� �׷����� ������ ����� ����ȴ�. */
select department_id
from employees group by department_id;
/* 2�ܰ� ) �� �μ����� �޿��� �հ踦 ���� �� �ִ�. */
select department_id, sum(salary)
from employees group by department_id;

/* �Ʒ� �������� �μ� ��ȣ�� �׷����� ��� ����� �����ϹǷ�
�̸��� ����ϸ� ������ �߻��Ѵ�.
�� ���ڵ� ���� ���� �ٸ� �̸��� ����Ǿ� �����Ƿ�
�׷��� ���ǿ� ���� �÷��� ����� �� ���� �����̴�. */
select department_id, sum(salary), first_name
from employees group by department_id;
--> fist_name ������ ���� �߻�

/* ���� ] ��� ���̺��� �� �μ��� ��� ���� ��� �޿��� ������ ����ϴ�
�������� �ۼ��Ͻÿ�. ��� �� �μ� ��ȣ�� �������� �������� �����Ͻÿ�.

- ���: �μ� ��ȣ, �޿� ����, ��� ����, ��� �޿� */
select
    department_id,
    trim(to_char(sum(salary), '999,000')) sum_salary,
    count(*) cnt_employee,
    trim(to_char(floor(avg(salary)), '999,000')) avg_salary
from employees group by department_id order by department_id;

/* having
: ���������� �����ϴ� �÷��� �ƴ� �׷� �Լ��� ����
�������� ������ �÷��� ������ �߰��� �� ����Ѵ�.
�ش� ������ where ���� �߰��ϸ� ������ �߻��Ѵ�. */

/* �ó����� ] ��� ���̺��� �� �μ����� �ٹ��ϰ� �ִ� ������
��� ������ ��� ���� ��� �޿��� ������ ����ϴ� �������� �ۼ��Ͻÿ�.
��, ��� ���� 10�� �ʰ��ϴ� ���ڵ常 �����Ͻÿ�. */

/* ���� �μ����� �ٹ��ϴ��� ��� ������ �ٸ� �� �����Ƿ�
�� ���������� group by ���� 2���� �÷��� ����ؾ� �Ѵ�.
��, �μ��� �׷�ȭ�� �� �ٽ� ��� �������� �׷�ȭ�Ѵ�. */
select
    department_id, job_id, count(*),
    trim(to_char(floor(avg(salary)), '999,000')) avg_salary
from employees
where count(*)>10                             --> �� �κп��� ������ �߻��ȴ�.
group by department_id, job_id;
/* ��� ������ ��� ���� ���������� �����ϴ� �÷��� �ƴϹǷ�
where ���� �߰��ϸ� ������ �߻��Ѵ�.
�� ��쿡�� having ���� ������ �߰��ؾ� �Ѵ�. 

ex ) �޿��� 3000�� ��� => ���������� �����ϹǷ� where ���� �߰�
      ��� �޿��� 3000�� ��� => �����ڰ� ��Ȳ�� �°� �������� ���� ����̹Ƿ�
                                            having ���� �߰��ؾ� �� */

/* �տ��� �߻��� ������ having ���� ������ �ű�� �ذ�ȴ�. */
select
    department_id, job_id,
    count(*),
    trim(to_char(floor(avg(salary)), '999,000')) avg_salary
from employees
group by department_id, job_id
having count(*)>10;

/* �ó����� ] ��� ������ ����� ���� �޿��� ����Ͻÿ�.
��, '������(Manager)�� ���� ����� ���� �޿��� 3000 �̸��� �׷�'�� ���ܽ�Ű��
����� �޿��� ������������ �����Ͽ� ����Ͻÿ�. */

/* �����ڰ� ���� ����� ���������� �����ϹǷ� where ���� ����Ѵ�.
���� �޿��� �׷� �Լ��� ���� ������� ����̹Ƿ� having ���� ����Ѵ�.
select ���� ����� ������ �÷� (���� ��)�� order by ���� ����� �� �ִ�. */
select job_id, min(salary)
from employees where manager_id is not null
group by job_id having not min(salary)<3000
order by min(salary) desc;
