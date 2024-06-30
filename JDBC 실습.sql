/* JDBC ���α׷��� �ǽ��� ���� ��ũ��Ʈ */

/* Java���� member ���̺� CRUD ��� �����ϱ� */

--  member ���̺� ����
create table member (
    /* id, pass, name�� ���� Ÿ������ �����ߴ�.
    null ���� ������� �ʴ� �÷����� �����ߴ�.
    ��, �ݵ�� �Է°��� �־�� insert�� �����ϴ�. */
	id varchar2(30) not null,
	pass varchar2(40) not null,
	name varchar2(50) not null,
    /* ��¥ Ÿ������ �����ߴ�.
    null�� ����ϴ� �÷����� �����ߴ�.
    ����, �Է°��� ���ٸ� ���� �ð�(sysdate)�� ����Ʈ�� �Է��Ѵ�. */
	regidate date default sysdate,
    /* ���̵� �⺻Ű�� �����ߴ�. */
	primary key (id)
);
