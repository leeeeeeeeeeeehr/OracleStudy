/* ���ϸ�: Or10SubQuery.sql
��������
: ������ �ȿ� �� �ٸ� �������� ���� ������ select�� */

/* ������ ��������
- ����: select * from ���̺�� where �÷� = (
                select �÷� from ���̺�� where ���� );

�� ��ȣ ���� ���������� �ݵ�� �ϳ��� ����� �����ؾ� �Ѵ�. */

/* �ó����� ] ��� ���̺��� ��ü ����� ��� �޿����� ���� �޿��� �޴�
������� �����Ͽ� ����Ͻÿ�.
- ��� �׸�: ��� ��ȣ, �̸�, �̸���, ����ó, �޿� */

-- 1 ) ��� �޿� ���ϱ� (���: 6462)
select round(avg(salary)) from employees;
-- 2 ) �տ��� ���� ��� �޿����� �޿��� ���� ������ ���� (���: 56��)
select * from employees where salary<6462;
/* 1, 2���� ���� �Ʒ��� ���� �������� �ۼ��ϸ� ������ �߻��Ѵ�. 
���ƻ� �´� ��ó�� �������� �׷� �Լ��� �����࿡ ������ �߸��� �������̴�. */
select * from employees where salary<round(avg(salary));
-- 3 ) ���������� �ۼ��ϱ�
select * from employees
where salary < (
    select round(avg(salary)) from employees
);

/* �ó����� ] ��ü ��� �� �޿��� ���� ���� ����� �̸��� �޿���
����ϴ� ������������ �ۼ��Ͻÿ�.
- ��� �׸�: �̸�, ��, �̸���, �޿� */

-- �ּ� �޿��� Ȯ�� (���: 2100)
select min(salary) from employees;
-- �׷� �Լ��� �����࿡ ��������Ƿ� ���� �߻���
select first_name, last_name, email, salary
from employees where min(salary);
-- 2100���� �޴� ������ ����
select first_name, last_name, email, salary
from employees where salary=2100;
-- 2���� �������� ���ļ� ���������� �����.
select
    first_name, last_name, email, salary
from employees
where salary = (
    select min(salary) from employees
);

/* �ó����� ] ��� �޿����� ���� �޿��� �޴� ������� �����
��ȸ�� �� �ִ� ������������ �ۼ��Ͻÿ�.
- ��� �׸�: �̸�, ��, ��������, �޿�

�� ���������� jobs ���̺� �����Ƿ� join �ؾ� �Ѵ�. */

-- ��� �޿� Ȯ���ϱ�
select round(avg(salary)) from employees;
-- ���̺��� ���������Ͽ� ���ǿ� �´� ���ڵ� ����
select
    first_name, last_name, job_title, salary
from employees
    inner join jobs using(job_id)
where salary>6462;
-- �������������� ����
select
    first_name, last_name, job_title, salary
from employees
    inner join jobs using(job_id)
where salary > (
    select round(avg(salary)) from employees
);

/* ������ �������� + ������ ������ in
- ����: select * from ���̺�� where �÷� in (
                select �÷� from ���̺�� where ���� );

�� ��ȣ ���� ���������� 2�� �̻��� ����� �����ؾ� �Ѵ�.
�� ��쿡 ���� 1���� ����� �������� ������ �߻����� �ʴ´�. */

/* �ó����� ] ���������� ���� ���� �޿��� �޴� ����� ����� ��ȸ�Ͻÿ�.
- ��� �׸�: ��� ���̵�, �̸�, ������ ���̵�, �޿� */

-- ���������� ���� ���� �޿��� Ȯ��
select job_id, max(salary)
from employees group by job_id;
-- �տ��� ���� ����� �������� �ܼ��� or ������ ����ؼ� ������ �ۼ�
select
    employee_id, first_name, last_name,
    job_id, salary
from employees
where (job_id='AD_PRES' and salary=24000)
        or (job_id='AD_VP' and salary=17000)
        or (job_id='IT_PROG' and salary=9000)
        or (job_id='FI_MGR' and salary=12008);
/* ���� �������� 19���� ����� ����Ǿ����� ������ ���� ����ϴ� ����
�����ϹǷ�  4�������� ����� Ȯ���غ��Ҵ�. 

2���� �÷��� �̿��ؾ� �ϹǷ� �����װ� �������� in���� �����Ѵ�. */
select
    employee_id, first_name, last_name,
    job_id, salary
from employees
where (job_id, salary) in (
    select job_id, max(salary)
    from employees group by job_id
);

/* ������ ������ any
: ���������� �� ������ ���������� �˻� ����� �ϳ� �̻� ��ġ�ϸ� ���� �Ǵ� ������,
��, �� �� �ϳ��� �����ϸ� �ش� ���ڵ带 �����Ѵ�. */

/* �ó����� ] ��ü ��� �߿��� �μ� ��ȣ�� 20�� ������� �޿����� ���� �޿��� �޴�
�������� �����ϴ� ������������ �ۼ��Ͻÿ�. ��, �� �� �ϳ��� �����ϴ��� �����Ͻÿ�.*/

-- 20�� �μ��� �޿��� Ȯ�� (���: 6000, 13000)
select first_name, salary from employees where department_id=20;
-- �� ����� �ܼ��� or���� �ۼ�
select first_name, salary from employees where salary>13000 or salary>6000;
/* �� �� �ϳ��� �����ϸ� �ǹǷ� ������ ������ any�� �̿��ؼ� ���������� ����� �ȴ�.
��, 6000 Ȥ�� 13000���� ū �������� �������� ����ȴ�. */
select
    first_name, salary
from employees
where salary > any (
    select salary from employees where department_id=20
);
-- ��������� 6000���ٸ� ũ�� ���ǿ� �����Ѵ�. (���: 55��)

/* ������ ������ all
: ���������� �� ������ ���������� �˻� ����� ��� ��ġ�ؾ� ���ڵ带 �����Ѵ�. */

/* �ó����� ] ��ü ��� �߿��� �μ� ��ȣ�� 20�� ������� �޿����� ���� �޿��� �޴�
�������� �����ϴ� ������������ �ۼ��Ͻÿ�. ��, �� �� �����ϴ� ���ڵ常 �����Ͻÿ�.*/

-- �ܼ��� and���� �ۼ�
select
    first_name, salary
from employees
where salary > 6000 and salary > 13000;
-- all�� �̿��ؼ� ���������� �ۼ�
select
    first_name, salary
from employees
where salary > all (
    select salary from employees where department_id=20
);
/* 6000 �̻��̰� ���ÿ� 13000���ٵ� Ŀ���ϹǷ�
��������� 13000 �̻��� ���ڵ常 �����ϰ� �ȴ�. (���: 5��) */

/* RowNum
: ���̺��� ���ڵ带 ��ȸ�� ������� ������ �ο��Ǵ� ������ �÷��� ���Ѵ�.
�ش� �÷��� ��� ���̺� �������� �����Ѵ�. */

-- ��� ������ �������� �����ϴ� ���̺�
select * from dual;
/* ��� ���ڵ带 ���� ���� �����ͼ� rownum�� �ο��Ѵ�.
�� ��� rownum�� ������� ��µȴ�. */
select employee_id, first_name, rownum from employees;
/* �̸��̳� ��� ��ȣ�� ���� �����ϸ� rownum�� ������ �����⵵ �ϰ� ������� �����⵵ �Ѵ�. */
select employee_id, first_name, rownum from employees order by first_name;
select employee_id, first_name, rownum from employees order by employee_id;
/* rownum�� �츮�� ������ ������� ��ο��ϱ� ���� ���������� ����Ѵ�.
���� from������ ���̺��� ���;��ϴµ� �Ʒ��� �ڵ带 ���� from���� ���������� �����ִ�.
�̴� ��� ���̺��� ��ü ���ڵ带 ������� �ϵ� �̸��� ������ ���·�
���ڵ带 �������� �ǹǷ� ���̺��� ��ü�� �� �ְ� �ȴ�.
����, ���ĵ� ���¿��� rownum�� ���� �������� ������ �ο��ȴ�. */
select first_name, rownum from (select * from employees order by first_name desc);

/* �̸��� �������� ���ĵ� ���ڵ忡 rownum�� �ο������Ƿ�
where���� �Ʒ��� ���� ������ ���� ������ ���� select �� �� �ִ�. */
select * from
    (select tb.*, rownum rNum from
        (select * from employees order by first_name asc) tb)
-- where rNum >= 1 and rNum <= 10;
-- where rNum >= 11 and rNum <= 20;
where rNum between 21 and 30;





