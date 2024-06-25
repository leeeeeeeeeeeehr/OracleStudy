/* ���ϸ�: Or02Number.sql
����(����) ���� �Լ�
: ���� �����͸� ó���ϱ� ���� ���� ���� �Լ��� �н�,
���̺� ���� �� number Ÿ������ ����� �÷��� ����� �����͸� ������� �Ѵ�. */

-- ���� ������ ������ ������ ���̺�, ���� ����� �����ش�.
select * from tab;
-- �̿� ���� ���̺��� ���� ��쿡�� ���� ������ �߻��Ѵ�.
select * from tjoeun;

/* Dual ���̺�
: �ϳ��� ������ ����� ����ϱ� ���� �����Ǵ� ���̺��
����Ŭ���� �ڵ����� �����Ǵ� ���� ���̺��̴�.
varchar2(1)�� ���ǵ� dummy��� �� �ϳ��� �÷����� �����Ǿ� �ִ�. */
select * from dual;

/* abs()
: ���밪 ���ϱ� */
select abs(12000) from dual;
select abs(-9000) from dual;
select abs(salary) "�޿��� ���밪" from employees;

/* trunc()
: �Ҽ����� Ư�� �ڸ������� �߶� �� ����ϴ� �Լ�

- ����: trunc (�÷��� Ȥ�� ��, �Ҽ��� ���� �ڸ���)
         �� ��° ���ڰ�
            - ����� ��: �־��� ���ڸ�ŭ �Ҽ����� ǥ��
            - ���� ��: �����θ� ǥ��, �� �Ҽ��� �Ʒ� �κ��� ����
            - ������ ��: �����θ� ���ڸ�ŭ �߶� �������� 0���� ä�� */
            
-- 
select trunc(12345.12345, 2) from dual;      --> 12345.12
select trunc(12345.12345) from dual;         --> 12345
select trunc(12345.12345, -2) from dual;     --> 12300

////////////////////////////////////////////////////////////////////////////////////////////

/* �ó����� ] ��� ���̺��� ���� ����� �޿��� ���� Ŀ�̼��� ����Ͽ�
���� ����� ����ϴ� �������� �ۼ��Ͻÿ�.
ex ) �޿�: 1000, ���ʽ���: 0.1
      => 1000 + ( 1000 * 0.1) = 1100 */

-- 1-1 ) ���� ����� ã�� �����Ѵ�. (���� ����� job_id�� SA_XX�� �Ǿ��ִ�.)
select * from employees where job_id like 'SA_%';
-- 1-2 ) ���� ����� Ŀ�̼��� �ޱ� ������ ���� �ԷµǾ� �ִ�.
select * from employees where commission_pct is not null;

-- 2 ) Ŀ�̼��� ����Ͽ� �̸��� �Բ� ����Ѵ�.
select first_name, salary, commission_pct, salary+(salary*commission_pct)   
from employees where job_id like 'SA_%';

-- 3 ) Ŀ�̼��� �Ҽ��� 1�ڸ������θ� �ݾ� ����Ѵ�.
select first_name, salary, trunc(commission_pct, 1), salary+(salary*trunc(commission_pct, 1))  
from employees where job_id like 'SA_%';

-- 4 ) ������ ���Ե� �÷��� ��Ī�� �ο��Ѵ�.
select first_name, salary, trunc(commission_pct, 1) as comm_pct, salary+(salary*trunc(commission_pct, 1)) TotalSalary
from employees where job_id like 'SA_%';

/* �Ҽ��� ���� �Լ� */
/* ceil(): �Ҽ��� ���ϸ� ������ �ø� ó�� */
select ceil(32.8) from dual;
select ceil(32.2) from dual;
--> �� �� 33�� ��µȴ�.

/* floor(): �Ҽ��� ���ϸ� ������ ���� ó�� */
select floor(32.8) from dual;
select floor(32.2) from dual;
--> �� �� 32�� ��µȴ�.

/* round(��, �ڸ���): �ݿø� ó��
        �� ��° ���ڰ�
            - ���� ���: �Ҽ��� ù ��° �ڸ��� 5 �̻��̸� �ø�, �̸��̸� ����
            - �ִ� ���: ���ڸ�ŭ �Ҽ����� ǥ���ǹǷ� �� ���� ���� 5 �̻��̸� �ø�, �̸��̸� ���� */
select round(0.123), round(0.543) from dual;
--> ���� ������ �ø� ó���Ͽ� 0, 1�� ����Ѵ�.

select round(0.1234567, 6), round(2.345612, 4) from dual;
--> ù ��° �׸�: �Ҽ� ���� 6�ڸ����� ǥ���ϹǷ� 7�� �ø� ó���Ѵ�.
--> �� ��° �׸�: �Ҽ� ���� 4�ڸ����� ǥ���ϹǷ� 1�� ���� ó���Ѵ�.

/* mod() : �������� ���ϴ� �Լ� */
select mod(99, 4) "99�� 4�� ���� ������" from dual;

/* power(): �ŵ������� ���ϴ� �Լ� */
select power(2, 10) "2�� 10��" from dual;

/* sqrt(): ������(��Ʈ)�� ���ϴ� �Լ� */
select sqrt(49) "49�� ������" from dual;








