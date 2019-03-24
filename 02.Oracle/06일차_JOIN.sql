/*
JOIN : �� �� �̻��� ���̺��� �����ؼ� ��ȸ�ϴ� ���

1. INNER JOIN : returns rows when there is a match in both tables.
2. LEFT JOIN : returns all rows from the left table, even if there are no matches in the right table.
3. RIGHT JOIN : returns all rows from the right table, even if there are no matches in the left table.
4. FULL JOIN : returns rows when there is a match in one of the tables.
5. SELF JOIN : is used to join a table to itself as if the table were two tables, temporarily renaming at least one table in the SQL statement.
6. CARTESIAN JOIN : returns the Cartesian product of the sets of records from the two or more joined tables.
*/



/*
INNER JOIN : = (������ ���ϴ� ������)�� �̿��� ���� ���� ����
����) PK, FK ������ ������ �÷��� ������� ���� ���� ����

ANSI [American National Standards Institute] ǥ���
    SELECT table1.column1, table2.column2...
    FROM table1
    INNER JOIN table2
    ON table1.common_field = table2.common_field;
    --WHERE ���ǽ�

Oracle ǥ���
    SELECT table1.column1, table2.column2...
    FROM table1, table2
    WHERE table1.common_field = table2.common_field;
    --AND ���ǽ�

*/

--hr.departments, hr.employees 
SELECT hr.departments.department_id, department_name, employee_id, first_name
    FROM hr.departments INNER JOIN hr.employees
    ON hr.departments.department_id = hr.employees.department_id;

--hr.departments, hr.employees 
SELECT hr.departments.department_id, department_name, employee_id, first_name
    FROM hr.departments, hr.employees
    WHERE hr.departments.department_id = hr.employees.department_id;
    
--Alias ����
SELECT d.department_id, department_name, employee_id, first_name
    FROM hr.departments d, hr.employees e
    WHERE d.department_id = e.department_id;
    
    
--hr.jobs, hr.employees 
SELECT employee_id, first_name, last_name, job_title
    FROM hr.jobs j, hr.employees e
    WHERE j.job_id = e.job_id
    ORDER BY employee_id;
    
--hr.jobs, hr.employees, hr.departments
SELECT employee_id, first_name, last_name, job_title, department_name
    FROM hr.jobs j 
    INNER JOIN hr.employees e ON j.job_id = e.job_id
    INNER JOIN hr.departments d ON e.department_id = d.department_id
    --WHERE �Ϲ����ǽ�
    ORDER BY employee_id;
    
    
--hr.jobs, hr.employees, hr.departments
SELECT employee_id, first_name, last_name, job_title, department_name
    FROM hr.jobs j, hr.employees e, hr.departments d
    WHERE j.job_id = e.job_id
    AND e.department_id = d.department_id
    --AND �Ϲ����ǽ�
    ORDER BY employee_id;


--����031) hr ����(������)�� employees, departments ���̺��� �������� 
--�μ����̵�, �μ��� �� �μ����� ��������(�������̵�, �̸�)�� ���� ����ϴ� ���� �ۼ�. INNER JOIN ���.

--ANSI ǥ���

    
--Oracle ǥ���



--����032) hr ����(������)�� employees, departments, locations, countries, regions ���̺��� �������� 
--���� ����(�������̵�, �̸�, �μ���, �μ���ġ)�� ����ϴ� ���� �ۼ�. INNER JOIN ���.

--ANSI ǥ���

    
--Oracle ǥ���






------------------------
/*
LEFT JOIN (OUTER JOIN)

ANSI ǥ���
    SELECT table1.column1, table2.column2...
    FROM table1
    LEFT JOIN table2
    ON table1.common_field = table2.common_field;
    
Oracle ǥ���
    SELECT table1.column1, table2.column2...
    FROM table1, table2
    WHERE table1.common_field = table2.common_field(+);

*/

--ANSI ǥ���
SELECT d.department_id, department_name, d.manager_id, employee_id, first_name, last_name
    FROM hr.departments d LEFT JOIN hr.employees e
    ON d.department_id = e.department_id;

--Oracle ǥ���
SELECT d.department_id, department_name, d.manager_id, employee_id, first_name, last_name
    FROM hr.departments d, hr.employees e
    WHERE d.department_id = e.department_id(+);




SELECT  employee_id, first_name, last_name, d.department_id, department_name, d.manager_id
    FROM hr.employees e LEFT JOIN hr.departments d
    ON e.department_id = d.department_id;    

SELECT  employee_id, first_name, last_name, d.department_id, department_name, d.manager_id
    FROM hr.employees e, hr.departments d
    WHERE e.department_id = d.department_id(+);



SELECT d.department_id, department_name, d.manager_id, employee_id, first_name, last_name
    FROM hr.departments d LEFT JOIN hr.employees e
    ON d.manager_id = e.employee_id;

SELECT d.department_id, department_name, d.manager_id, employee_id, first_name, last_name
    FROM hr.departments d, hr.employees e
    WHERE d.manager_id = e.employee_id(+);


--����033) hr ����(������)�� jobs, employees ���̺��� �������� 
--���� ������ �������� ���� ������ ���� ����ϴ� ���� �ۼ�. LEFT JOIN ���.

--ANSI ǥ���


--Oracle ǥ���




--����034) hr ����(������)�� employees, job_history ���̺��� �������� 
--���� ������ �������� �μ�, ���� ���� ������ ���� ����ϴ� ���� �ۼ�. LEFT JOIN ���.

--ANSI ǥ���

    
    
--Oracle ǥ���



----------------------------------
--����035) hr ����(������)�� employees, jobs ���̺��� ��������  
--first_name 'Neena', last_name 'Kochhar' ������ ������(job_title)���� ���. INNER JOIN ���.

--ANSI ǥ���

    
--Oracle ǥ���





--����036)  hr ����(������)�� employees, jobs ���̺��� �������� 
--������(job_title)�� �ּұ޿�(min_salary)�� �޴� ���� ���. INNER JOIN ���.
--3��

--ANSI ǥ���

    
--Oracle ǥ���



--����037) hr ����(������)�� employees, jobs ���̺��� ��������
--������(job_title)�� ������ �� ���.  INNER JOIN ���.

--ANSI ǥ���

    
--Oracle ǥ���


--����038)  hr ����(������)�� employees, departments ���̺��� �������� 
--first_name 'David', last_name 'Austin' ������ ���� 
--�μ���(department_name), �μ���(manager)�̸�(first_name, last_name) ���.  INNER JOIN ���.

--ANSI ǥ���


--Oracle ǥ���

        


------------------------
/*
SELF JOIN : Alias ���� �ʼ�

ANSI ǥ���
    SELECT a.column_name, b.column_name...
    FROM table1 a INNER JOIN table1 b
    ON a.common_field = b.common_field;


Oracle ǥ���
    SELECT a.column_name, b.column_name...
    FROM table1 a, table1 b
    WHERE a.common_field = b.common_field;
*/


--hr.employees e1, hr.employees e2
SELECT e2.first_name, e2.last_name, e2.salary, e2.department_id, e2.job_id, e2.hire_date
    FROM hr.employees e1 INNER JOIN hr.employees e2
    ON e1.salary = e2.salary
    WHERE e1.first_name='David' AND e1.last_name='Austin';

--hr.employees e1, hr.employees e2
SELECT e2.first_name, e2.last_name, e2.salary, e2.department_id, e2.job_id, e2.hire_date
    FROM hr.employees e1, hr.employees e2
    WHERE e1.salary = e2.salary
    AND e1.first_name='David' AND e1.last_name='Austin';
    
    
    
--hr.employees e1, hr.employees e2
SELECT e2.first_name, e2.last_name, e2.salary, e2.department_id, e2.job_id, e2.hire_date
    FROM hr.employees e1 INNER JOIN hr.employees e2
    ON e1.department_id = e2.department_id
    WHERE e1.first_name='David' AND e1.last_name='Austin';    
    
--hr.employees e1, hr.employees e2
SELECT e2.first_name, e2.last_name, e2.salary, e2.department_id, e2.job_id, e2.hire_date
    FROM hr.employees e1, hr.employees e2
    WHERE e1.department_id = e2.department_id
    AND e1.first_name='David' AND e1.last_name='Austin';


--hr.employees e1, hr.employees e2
SELECT e2.first_name, e2.last_name, e2.salary, e2.department_id, e2.job_id, e2.hire_date
    FROM hr.employees e1, hr.employees e2
    WHERE e1.department_id = e2.department_id
    AND e1.hire_date <= e2.hire_date
    AND e1.first_name='Valli' AND e1.last_name='Pataballa';



--����039)  hr ����(������)�� employees ���̺��� �������� 
--first_name 'Donald', last_name 'OConnell'�� �������̵�(job_id)�� ���� ���� ���� ����ϴ� ���� �ۼ�. SELF JOIN ���.

--ANSI ǥ���


--Oracle ǥ���


--����040)  hr ����(������)�� employees, jobs ���̺��� �������� 
--first_name 'Donald', last_name 'OConnell'�� ������(job_title)�� ���� ���� ���� ����ϴ� ���� �ۼ�. SELF JOIN ���.

--ANSI ǥ���


--Oracle ǥ���


----------------------
/*
CARTESIAN JOIN(or CROSS JOIN)

ANSI ǥ���
    SELECT table1.column1, table2.column2...
    FROM  table1 CROSS JOIN table2;

Oracle ǥ���
    SELECT table1.column1, table2.column2...
    FROM  table1, table2;

*/

--hr.departments, hr.employees 
SELECT hr.departments.department_id, department_name, employee_id, first_name
    FROM hr.departments CROSS JOIN hr.employees;


--hr.departments, hr.employees 
SELECT hr.departments.department_id, department_name, employee_id, first_name
    FROM hr.departments, hr.employees;
    
    
    
    
----------------------
/*
FULL JOIN

ANSI ǥ���
    SELECT table1.column1, table2.column2...
    FROM table1 FULL JOIN table2
    ON table1.common_field = table2.common_field;

����) Oracle ǥ��������� FULL JOIN ���� ����
*/

--ANSI ǥ���
SELECT d.department_id, department_name, employee_id, first_name
    FROM hr.departments d FULL JOIN hr.employees e
    ON d.department_id = e.department_id;
    
--ORA-01468: a predicate may reference only one outer-joined table 
SELECT d.department_id, department_name, employee_id, first_name
    FROM hr.departments d, hr.employees e
    WHERE d.department_id(+) = e.department_id(+);



--------------------------
--����041) hr ����(������)�� employees ���̺��� ��������  
--first_name 'Steven', last_name 'King' ������ ���� ���� ���. 


--����042) hr ����(������)�� employees, jobs, job_history ���̺��� ��������  
--employee_id�� 101�� ������ �������丮(first_name, last_name, start_date, end_date, job_title) ���.


--����043) hr ����(������)�� employees ���̺��� �������� 
--���� ������ ���� ���� ���.


--����044) hr ����(������)�� employees ���̺��� �������� 
--first_name 'Gerald', last_name 'Cambrault'�� salary���� �޿��� �� ���� �޴� ���� ���� ���.
