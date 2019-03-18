/*

DB(Database) : ������ ����ҿ� ����� �ڷ� ����

DBMS(Database Management System) : DB � ���� ����Ʈ����. ��ǥ������ Oracle, MySQL, ...

SQL : DBMS���� ����ϴ� (ǥ��)��ɾ� ����

SQL is a language to operate databases; it includes database creation, deletion, fetching rows, modifying rows, etc. 

DDL - Data Definition Language
CREATE
ALTER
DROP

DML - Data Manipulation Language
SELECT
INSERT
UPDATE
DELETE

DCL - Data Control Language
GRANT
REVOKE

*/


/*
Ư�� ���̺�(�ڷῡ ������ �����)�� ���� ��ȸ ���
����)������ ����(CONNECT, RESOURCE role + SELECT ANY TABLE)�� �ο��� ��츸 ��ȸ ����

SELECT [�÷���] 
    FROM [���̺��];

Ư�� ���̺��� �ڷ� ��ȸ
�÷��� ������ *(���ϵ�ī��) ��� ����

SELECT column1, column2....columnN
    FROM   table_name
    WHERE  condition
    GROUP BY column_name
    HAVING (arithematic function condition)
    ORDER BY column_name {ASC|DESC};
    
*/


--hr ������ employees ���̺� ���� SELECT ���� ����
SELECT * 
    FROM hr.employees;
    
--hr ������ departments ���̺� ���� SELECT ���� ����
SELECT *
    FROM hr.departments;
    