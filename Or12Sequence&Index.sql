/* ���ϸ�: Or12Sequence&Index.sql
������ & �ε���
: ���̺��� �⺻Ű �ʵ忡 �������� �Ϸ� ��ȣ�� �ο��ϴ� ��������
�˻� �ӵ��� ����ų �� �ִ� �ε��� */

-- Study �������� �н��մϴ�.

/* ������ (Sequence)
- ���̺��� �÷�(�ʵ�)�� �ߺ����� �ʴ� �������� �Ϸ� ��ȣ�� �ο��Ѵ�.
- �������� ���̺� ���� �� ������ ������ �Ѵ�.
  ��, �������� ���̺�� ���������� ����ǰ� �����ȴ�. */
  
  /* [������ ���� ����]
  create sequence ��������
    [Increment by N] -> ����ġ ����
    [Start with N] -> ���۰� ����
    [MinValue | NoMinValue] -> ������ �ּҰ� ����, ����Ʈ 1
    [MaxValue | NoMaxValue] -> ������ �ִ밪 ����, ����Ʈ 1.00E + 28
    [Cycle | NoCycle] -> �ִ�/�ּ� ���� ������ ��� ó������ �ٽ� ��������
                               ���θ� ���� (Cycle�� �����ϸ� �ִ밪���� ���� ��
                               �ٽ� ���۰����� ����۵�)
    [Cache | NoCache] -> cache �޸𸮿� ����Ŭ ������ ���������� �Ҵ��ϴ°� ���θ� ���� */

/* ������ ���� �� ���ǻ���
1. Start with�� MinValue���� ���� ���� ������ �� ����.
   ��, Start with ���� MinValue���� ���ų� Ŀ�� �Ѵ�.
2. NoCycle�� �����ϰ� �������� ��� ���� �� MaxValue�� �������� �ʰ��ϸ� ������ �߻��Ѵ�.
3. Primary key���� Cycle �ɼ��� ���� �����ϸ� �ȵȴ�. */

create table tb_goods (
    idx  number(10) primary key,
    g_name varchar2(30)
);
insert into tb_goods values (1, '��Ϲ���Ĩ');
-- idx�� PK�� ������ �÷��̹Ƿ� �ߺ����� �ԷµǸ� ���� �߻��ȴ�.
insert into tb_goods values (1, '���±�');

-- ������ ����
create sequence seq_serial_num
    increment by 1       --> ����ġ: 1
    start with 100         --> �ʱⰪ (���۰�): 100
    minvalue 99           --> �ּҰ�: 99
    maxvalue 110         --> �ִ밪: 110
    cycle                     --> �ִ밪 ���� �� �ּҰ����� ��������� ����: Yes
    nocache;                --> ĳ�� �޸� ��� ����: no

-- ������ �������� ������ ������ ���� Ȯ��
select * from user_sequences;
/* ������ ���� �� ���� ���� �ÿ��� currval�� ������ �� ���� ������ �߻��Ѵ�.
nextval�� ���� �����ؼ� �������� ���� �� ����ؾ� �Ѵ�. */
select seq_serial_num.currval from dual;
/* ���� �Է��� �������� ��ȯ�Ѵ�.
������ ������ ������ ����ġ��ŭ ������ ���� ��ȯ�ȴ�. */
select seq_serial_num.nextval from dual;
/* �������� nextval�� ����ϸ� ��� ���ο� ���� ��ȯ�ϹǷ�
�Ʒ��� ���� insert���� ����� �� �ִ�.
����, ���� ������ ������ �����ϴ��� �������� �Էµȴ�.

��, �������� cycle �ɼǿ� ���� �ִ밪�� �����ϸ� �������� �ٽ� ó������ �����ǹǷ�
���Ἲ �������ǿ� ����Ǿ� ������ �߻��Ѵ�.
��, PK �÷��� ����� �������� Cycle �ɼ��� ������� �ʾƾ� �Ѵ�. */
insert into tb_goods values (seq_serial_num.nextval, '���±�');
select * from tb_goods;

/* ������ ����
: ���̺�� �����ϰ� alter ����� ����Ѵ�.
��, start with�� ������ �� ����. */
alter sequence seq_serial_num
    increment by 1
    minvalue 00
    nomaxvalue          --> �ִ밪 ������� ���� (= ǥ���� �� �ִ� �ִ� ������ �����)
    nocycle                --> cycle ������� ����
    nocache;               --> cache �޸� ������� ����

/* ������ ���� */
drop sequence seq_serial_num;
select * from user_sequences;

---------------- ���� �� �ٽ� ���� ----------------
/* �Ϲ����� ������ ������ �Ʒ��� ���� �ϸ� �ȴ�.
�ַ� PK�� ������ �÷��� �Ϸ� ��ȣ�� �Է��ϴ� �뵵�� ���ǹǷ�
�ִ밪, ����Ŭ, ĳ�ô� ������� �ʴ� ���� �����Ѵ�. */
create sequence seq_serial_num
    increment by 1
    start with 1
    minvalue 1
    nomaxvalue
    nocycle
    nocache;

/* �ε��� (Index)
- ���� �˻� �ӵ��� ����ų �� �ִ� ��ü
- �ε����� �����(create index)��
  �ڵ���(primary key, unique)���� ������ �� �ִ�.
- �÷��� ���� �ε����� ������ ���̺� ��ü�� �˻��Ѵ�.
- ��, �ε����� ������ ������ ����Ű�� ���� �� �����̴�.
- �ε����� �Ʒ��� ���� ��쿡 �����Ѵ�.
    1 ) where �����̳� join ���ǿ� ���� ����ϴ� �÷�
    2 ) �������� ���� �����ϴ� �÷�
    3 ) ���� null ���� �����ϴ� �÷� */

-- �ε��� �����ϱ�
create index tb_goods_name_idx on tb_goods (g_name);
-- ������ �������� Ȯ��
/* ����� ���� PK Ȥ�� Unique�� ������ �÷���
�ڵ����� �ε����� �����Ǿ��ִ� ���� �� �� �ִ�. */
select * from user_ind_columns;
-- �ε��� �����ϱ�
drop index tb_goods_name_idx;
/* �ε����� ������ �Ұ����ϴ�.
������ �ʿ��ϴٸ� ���� �� �ٽ� �����ؾ� �Ѵ�. */