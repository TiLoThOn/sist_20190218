/*
SELECT : Ư�� ���̺�(�ڷῡ ������ �����)�� ���� ��ȸ ���
����)������ ����(CONNECT, RESOURCE role + SELECT ANY TABLE)�� �ο��� ��츸 ��ȸ ����

����
SELECT column1, column2....columnN
    FROM   table_name
    WHERE  condition
    GROUP BY column_name
    HAVING (arithematic function condition)
    ORDER BY column_name {ASC|DESC};

*/


----------------------------------------------
--Selecting All Columns + All Rows of a Table
/*
SELECT *
FROM   table_name;
*/

SELECT * 
    FROM hr.employees;

SELECT *
    FROM hr.departments;
    
    
--����001) hr ����(������)�� jobs ���̺��� ������ ��ü ����ϴ� ���� �ۼ�.,




------------------------------------------
--Selecting Specific Columns + All Rows of a Table
/*
SELECT column1, column2....columnN
FROM   table_name;
*/

SELECT employee_id, first_name, phone_number
    FROM hr.employees;

SELECT department_id, department_name
    FROM hr.departments;
    
--����002) hr ����(������)�� jobs ���̺��� �������� 
-- job_id, job_title �÷� ������ ����ϴ� ���� �ۼ�.


------------------------------------------
--Displaying Selected Columns Under New Headings
/*
����1)
SELECT column1 alias1, column2 alias2, ....columnN  aliasN
FROM   table_name;
����2)
SELECT column1 AS alias1, column2 AS alias2, ....columnN AS aliasN
FROM   table_name;
����3)
SELECT column1 "alias1", column2 "alias2", ....columnN  "aliasN"
FROM   table_name;
*/

SELECT employee_id eid, first_name fname, phone_number phone
    FROM hr.employees;
SELECT employee_id AS eid, first_name AS fname, phone_number AS phone
    FROM hr.employees;    
SELECT employee_id "Employee Id", first_name "First Name", phone_number "Phone Number"
    FROM hr.employees;
    

--����003) hr ����(������)�� jobs ���̺��� �������� 
-- job_id �÷��� "Job Id", job_title �÷��� "Job Title"�� Ÿ��Ʋ �����ؼ� ����ϴ� ���� �ۼ�.



------------------------------------------
--Selecting Data that Satisfies Specified Conditions
/*
SELECT column1, column2....columnN
FROM   table_name
WHERE  condition;

=, !=, <, >, <=, >=
IS [NOT] NULL, LIKE, [NOT] BETWEEN, [NOT] IN, EXISTS, IS OF type
NOT, AND, OR

����) �����ڸ� �̿��ؼ� ���ǽ� �ۼ��� �ڷ���(data type) Ȯ�� �ʿ�. NUMBER(����), VARCHAR2(���ڿ�), DATE(��¥), ...
*/

SELECT employee_id, first_name, phone_number, salary
    FROM hr.employees
    WHERE salary = 10000;
--4 rows

SELECT employee_id, first_name, phone_number, department_id
    FROM hr.employees
    WHERE department_id = 100;
--6 rows


--����004) hr ����(������)�� employees ���̺��� �������� 
-- job_id�� 'ST_CLERK'�� ��츸 ����ϴ� ���� �ۼ�.


--����005) hr ����(������)�� employees ���̺��� �������� 
-- salary�� 10000 �̻��� ��츸 ����ϴ� ���� �ۼ�.


--����006) hr ����(������)�� employees ���̺��� �������� 
-- salary�� 5000 ������ ��츸 ����ϴ� ���� �ۼ�.

-------------------------------------------
SELECT employee_id, first_name, phone_number, department_id
    FROM hr.employees
    WHERE department_id = ANY (90, 100);

SELECT employee_id, first_name, phone_number, salary
    FROM hr.employees
    WHERE salary >= ALL (9000, 10000);
    
--------------------------------------------
SELECT employee_id, first_name, hire_date
    FROM hr.employees;
--yy/mm/dd
--��¥���� ������ yyyy-mm-dd�� ��ȯ ����. TO_CHAR() function
SELECT employee_id, first_name
    , TO_CHAR(hire_date, 'YYYY-MM-DD') AS hire_date1
    , TO_CHAR(hire_date, 'YYYY-MM') AS hire_date2
    , TO_CHAR(hire_date, 'YYYY') AS hire_date3
    FROM hr.employees;

SELECT employee_id, first_name, department_id, hire_date
    FROM hr.employees
    WHERE TO_CHAR(hire_date, 'YYYY') = '2005';
    
--����007) hr ����(������)�� employees ���̺��� �������� 
--�̴�(8����)�� �Ի��ڸ� ����ϴ� ���� �ۼ�. TO_CHAR() �Լ� ���.



------------------------------------------------
--SQL IN Clause
/*
SELECT column1, column2....columnN
FROM   table_name
WHERE  column_name IN (val-1, val-2,...val-N);
*/
SELECT employee_id, first_name, phone_number, department_id
    FROM hr.employees
    WHERE department_id IN (90, 100);
    
SELECT employee_id, first_name, phone_number, salary
    FROM hr.employees
    WHERE salary IN (8000, 9000, 10000);
    
    
--����008) hr ����(������)�� employees ���̺��� �������� 
--Ư����(8����, 9����) �Ի��ڸ� ����ϴ� ���� �ۼ�. IN ������ ���.

        
---------------------------------------------

