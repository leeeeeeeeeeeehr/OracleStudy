/* ���ϸ�: Or01SelectBasic.sql
ó������ �����غ��� ���Ǿ�(SQL�� Ȥ�� Query��)
�����ڵ� ���̿����� '����'�̶�� ǥ���ϱ⵵ �Ѵ�.
����: select, where, order by �� ���� �⺻���� DQL�� ����غ��� */

/* SQL Developer���� �ּ� ����ϱ�
�� ���� �ּ�: �ڹٿ� �����ϴ�.
���� ���� �ּ�: -- ���� ����, ������ 2���� �������� ����Ѵ�. */

/* select�� ���̺� ����� ���ڵ带 ��ȸ�ϴ� SQL������ DQL���� �ش��Ѵ�.

- ����: select �÷�1, �÷�2, ... Ȥ�� *(��ü �÷�)
         from ���̺��
         where ����1 and ����2 or ����3
         order by ������ �÷� asc(��������), desc(��������); */

/* employees ���̺� ����� ��� ���ڵ带 ������� ��� �÷��� ��ȸ�Ѵ�. */
select * from employees;
/* �������� ��ҹ��ڸ� �������� �ʴ´�. */
SELECT * FROM employees;

/* �÷����� �����ؼ� ��ȸ�ϰ� ���� �÷��� ��ȸ�ϱ�
=> ��� ��ȣ, �̸�, �̸���, �μ� ��ȣ�� ��ȸ�Ͻÿ�. */

-- �ϳ��� �������� ���� �� ;�� �ݵ�� ����ؾ� �Ѵ�.
select employee_id, first_name, last_name, email, department_id from employees;


/* ���̺��� ������ �÷��� �ڷ��� �� ũ�⸦ ������ش�.
��, ���̺��� ��Ű��(����)�� �� �� �ִ�. */
desc employees;

/* �÷��� ������(number)�� ��� ��������� �����ϴ�.
=> 100�� �λ�� ������ �޿��� ��ȸ�Ͻÿ�. */
select employee_id, first_name, last_name, salary, salary+100 from employees;


/* number(����) Ÿ���� �÷������� ������ �� �ִ�. */
select employee_id, first_name, salary, salary+commission_pct from employees;

/* AS (�˸��ƽ�)
: ���̺� Ȥ�� �÷��� ��Ī(����)�� �ο��� �� ����Ѵ�.
���� ���ϴ� �̸�(����, �ѱ�)���� ������ �� ����� �� �ִ�.

ex ) �޿� + �������� => SalComm�� ���� ���·� ��Ī�� �ο��Ѵ�. */
select employee_id, first_name, salary, salary+100 as "�޿� 100�� ����" from employees;

/* ��Ī�� �ѱ۷� ����� �� ������ �������� ����ϴ� ���� �����Ѵ�. */
select first_name, salary, commission_pct, salary+(salary*commission_pct) as SalComm from employees;

/* as�� ������ �� �ִ�. */
select employee_id "��� ��ȣ", first_name "�̸�", last_name "��" from employees where first_name='William';

/* ����Ŭ�� �⺻������ ��ҹ��ڸ� �������� �ʴ´�.
������� ��� ��ҹ��� ���о��� ����� �� �ִ�. */
SELECT employee_id "��� ��ȣ", first_name "�̸�", last_name "��" FROM employees WHERE first_name='William';

/* ��, ���ڵ��� ��� ��ҹ��ڸ� �����Ѵ�.
���� �Ʒ� SQL���� �����ϸ� �ƹ��� ����� ������� �ʴ´�. */
select employee_id "��� ��ȣ", first_name "�̸�", last_name "��" from employees where first_name='william';

/* where���� �̿��ؼ� ���ǿ� �´� ���ڵ� �����ϱ�
=> last_name�� Smith�� ���ڵ带 �����Ͻÿ�. */
select * from employees where last_name='Smith';

/* where���� 2�� �̻��� ������ �ʿ��� �� and Ȥ�� or�� ����� �� �ִ�.
=> last_name�� Smith�̸鼭 �޿��� 8000�� ����� �����Ͻÿ�. */

-- �÷��� �������̸� �̱� �����̼��� ���Ѵ�. ���ڶ�� �����Ѵ�.
select * from employees where last_name='Smith' and salary=8000;
-- �������� �̱� �����̼��� ������ �� ����. ���� ������ �߻��Ѵ�.
select * from employees where last_name=Smith and salary=8000;
-- �������� ��� �̱� �����̼� ������ �⺻������ ������ ������ ���� �ʴ´�.
select * from employees where last_name='Smith' and salary='8000';

/* �񱳿����ڸ� ���� ������ �ۼ�
: �̻�, ���Ͽ� ���� ���ǿ� >, <= �� ���� �񱳿����ڸ� ����� �� �ִ�.
��¥�� ��� ����, ���Ŀ� ���� ���ǵ� �����ϴ�. */

-- �޿��� 5000 �̸��� ����� ������ �����Ͻÿ�.
select * from employees where salary<5000;
-- �Ի����� 04�� 01�� 01�� ������ ����� ������ �����Ͻÿ�.
select * from employees where hire_date>='04/01/01';

/* in ������
: or �����ڿ� ���� �ϳ��� �÷��� ���� ���� ������ ������ �ɰ���� �� ���
=> �޿��� 4200, 6400, 8000�� ����� ������ �����Ͻÿ�. */

-- ��� 1: or�� ����Ѵ�. �� ����� �÷����� �ݺ������� ����ؾ� �ϹǷ� �����ϴ�.
select * from employees where salary=4200 or salary=6400 or salary=8000;
-- ��� 2: in�� ����Ѵ�. �� ����� �÷����� �� ���� ����ϸ� �ǹǷ� ���ϴ�.
select * from employees where salary in (4200, 6400, 8000);

/* not ������
: �ش� ������ �ƴ� ���ڵ带 �����Ѵ�.
=> �μ� ��ȣ�� 50�� �ƴ� ��� ������ �����ϴ� SQL���� �ۼ��Ͻÿ�. */
select * from employees where department_id<>50;
select * from employees where not (department_id=50);
select * from employees where department_id!=50;

/* between and ������
: �÷��� ������ ���� �˻��� �� ����Ѵ�.
=> �޿��� 4000~8000 ������ ����� �����Ͻÿ�. */
select * from employees where salary>=4000 and salary<=8000;
select * from employees where salary between 4000 and 8000;

/* distinct ������
: �÷����� �ߺ��Ǵ� ���ڵ带 ������ �� ����Ѵ�.
Ư�� �������� select ���� �� �ϳ��� �÷����� �ߺ��Ǵ� ���� �ִ� ���
�ߺ����� ������ �� ����� ����� �� �ִ�.
=> ��� ���� ���̵��� �ߺ��� ������ �� �����Ͻÿ�. */
select job_id from employees;
select distinct job_id from employees;

/* like ������
: Ư�� Ű���带 ���� ���ڿ��� �˻��� �� ����Ѵ�. 
ex ) �÷��� like '%�˻���%' */

/* ���ϵ�ī�� ����

&: ��� ���� Ȥ�� ���ڿ��� ��ü
- D�� ���۵Ǵ� �ܾ�: D% => Da, Dae, Daewoo
- Z�� ������ �ܾ�: %Z => aZ, abxZ
- C�� ���ԵǴ� �ܾ�: %C% => aCb, abCde, Vitamin-C

_: �ϳ��� ���ڸ� ��ü
- D�� �����ϴ� 3������ �ܾ�: D__ => Dad, Ddd, Dxy
- A�� �߰��� ���� 3������ �ܾ�: _A_ => aAa, xAy*/

-- first_name�� 'D'�� �����ϴ� ������ �����Ͻÿ�.
select * from employees where first_name like 'D%';
-- first_name�� ����° ���ڰ� a�� ������ �����Ͻÿ�.
select * from employees where first_name like '__a%'; 
-- last_name���� y�� ������ ������ �����Ͻÿ�.
select * from employees where last_name like '%y';
-- ��ȭ��ȣ���� 1344�� ���Ե� ���� ��ü�� �����Ͻÿ�.
select * from employees where phone_number like '%1344%';

/* ���ڵ� �����ϱ� (Sorting)
: 2�� �̻��� �÷����� �����ؾ� �� ���, �޸��� �����ؼ� �����Ѵ�.
��, �̶� ���� �Է��� �÷����� ���ĵ� ���¿��� �� ��° �÷��� ���ĵȴ�.

- �������� ����: order by �÷��� asc (Ȥ�� ���� ����)
- �������� ����: order by �÷��� desc */

/* �ó����� ] ��� ���� ���̺��� �޿��� ���� �������� ���� ������ ����ǵ��� �����Ͽ� �����Ͻÿ�.
- ����� �÷�: �̸�, �޿�, �̸���, ��ȭ��ȣ */
select first_name, salary, email, phone_number from employees order by salary asc;
-- �������� ������ ��� asc�� ������ �� �ִ�.
select first_name, salary, email, phone_number from employees order by salary;

/* �ó����� ] �μ� ��ȣ�� ������������ ������ ��
�ش� �μ����� ���� �޿��� �޴� ������ ���� ��µǵ��� SQL���� �ۼ��Ͻÿ�.
- ����� �÷�: �����ȣ, �̸�, ��, �޿�, �μ� ��ȣ */
select employee_id, first_name, last_name, salary, department_id
from employees order by department_id desc, salary asc;

/* is null Ȥ�� is not null ������
: ���� null�̰ų� null�� �ƴ� ���ڵ� �����ϱ�,
�÷� �� null ���� ����ϴ� ��� ���� �Է����� ������ null ���� �Ǵµ�
�̸� ������� select �ؾ� �� �� ����Ѵ�. */
-- ���ʽ����� ���� ����� ��ȸ�Ͻÿ�.
select * from employees where commission_pct is null;
-- ���� ����̸鼭 �޿��� 8000 �̻��� ����� ��ȸ�Ͻÿ�.
select * from employees where commission_pct is not null and salary>=8000;
