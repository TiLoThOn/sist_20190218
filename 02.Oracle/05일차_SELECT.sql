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



/*
FUNCTION  : Functions are similar to operators in that they manipulate data items and return a result.

1. function(argument, argument, ...) 
2. ���� �Լ�(SQL, ����Ŭ ���� �Լ�), ����� ���� �Լ�(PL/SQL)
3. ���� �� �Լ�(Single-Row Functions), ���� �� �Լ�(Aggregate Functions)
4. ���� �ڷ��� �Լ�, ���� �ڷ��� �Լ�, ��¥ �ڷ��� �Լ�, �� ��ȯ �Լ�

*/



---------------------------------------------------------------------
--Aggregate function
--Aggregate functions return a single result row based on groups of rows, rather than on single rows

--����) Aggregate function�� �ܵ� �����ؾ� �Ѵ�. �ٸ� �Լ�(Single-Row Functions)�� ���� ����� �� ����.

--COUNT : COUNT returns the number of rows returned by the query.
--SUM
--AVG
--RANK
--DENSE_RANK
--����) null ���� ���� �Լ� ���꿡 �������� �ʴ´�.



------------------------------
SELECT employee_id, first_name, COUNT(*) "count"
    FROM hr.employees;
--ORA-00937: not a single-group group function

SELECT COUNT(*) "count"
    FROM hr.employees;
--107

SELECT COUNT(*) "count"
    FROM hr.employees
    WHERE manager_id IS NULL;
--1

SELECT COUNT(*) "count"
    FROM hr.employees
    WHERE department_id IS NULL;
--1


SELECT COUNT(employee_id) "count"
    FROM hr.employees;
--PK ������ �ִ� �÷��� ������� COUNT() �Լ� ���� ��ü ī����
--107

SELECT COUNT(commission_pct) "count"
    FROM hr.employees;
--null�� �ִ� �÷��� ������� COUNT() �Լ� ���� �Ϻ� ī����. null ���� ī���� ����.
--35

SELECT COUNT(department_id) "count"
    FROM hr.employees;
--106


--����26)  hr ����(������)�� employees ���̺��� �������� 
--commission_pct�� ����(���� null��) ������ ���� ����ϴ� ���� �ۼ�. COUNT() �Լ� ���.
--DISTINCT Ű����� �ߺ� ���� ����






-----------------------------------
SELECT SUM(salary) "Total"
     FROM hr.employees;
     
SELECT SUM(salary) "Total"
     FROM hr.employees
     WHERE department_id = 100;
     

SELECT ROUND(AVG(salary),2) "Total"
     FROM hr.employees;
     
SELECT ROUND(AVG(salary)) "Total"
     FROM hr.employees
     WHERE department_id = 100;     
     
     
--����027) hr ����(������)�� employees ���̺��� �������� 
--Ư�� ����(job_id)�� ���� ������ �޿� �� �� ��� ����ϴ� ���� �ۼ�.
--'CLERK'���� ������ ������ ���� ���� ���. SUBSTR() �Լ� ���.
-->SH_CLERK, ST_CLERK, PU_CLERK





--------------------------------
SELECT department_id, last_name, salary,
       RANK() OVER (ORDER BY salary DESC) "RANK"
  FROM hr.employees;

SELECT department_id, last_name, salary,
       DENSE_RANK() OVER (ORDER BY salary DESC) "DENSE_RANK"
  FROM hr.employees;


--����028) hr ����(������)�� employees ���̺��� �������� 
--�Ի�����(hire_date)�� ���� ������ ��� �ο� ����ϴ� ���� �ۼ�.
--RANK() OVER() �Լ� ���






--------------------------------------------------------
--SQL GROUP BY Clause
--Specify the GROUP BY clause if you want the database to group the selected rows based on the value of expr(s) for each row and return a single row of summary information for each group.
/*
SELECT column_name1, SUM(column_name2), ...
FROM   table_name
GROUP BY column_name1;
*/
--����) GROUP BY Ű���忡 ����ϴ� �÷��� �ߺ��� �ڷᰡ �ִ� �÷�(FK ������ �ִ� �÷�) ����. PK, UK ������ �ִ� �÷��� ������ ����� �ƴϴ�.

SELECT department_id, COUNT(*), SUM(salary)
    FROM  hr.employees
    GROUP BY department_id
    ORDER BY department_id;

SELECT MIN(salary), MAX(salary)
    FROM hr.employees;

SELECT department_id, MIN(salary), MAX(salary)
    FROM hr.employees
    GROUP BY department_id
    ORDER BY department_id;
   
SELECT job_id, COUNT(*) "COUNT", AVG(salary)
    FROM hr.employees
    GROUP BY job_id
    ORDER BY job_id;
    
SELECT department_id, job_id, COUNT(*)
    FROM hr.employees
    GROUP BY department_id, job_id
    ORDER BY department_id, job_id;    
   
     
--����029) hr ����(������)�� employees ���̺��� �������� 
--Ư�� ����(job_id)�� ������ �޿� �� �� ��� ����ϴ� ���� �ۼ�.
--'CLERK'���� ������ ������ ���� ���� ���. SUBSTR() �Լ� ���.
-->SH_CLERK, ST_CLERK, PU_CLERK






------------------------------------
--SQL HAVING Clause
/*
SELECT column_name1, SUM(column_name2), ...
FROM   table_name
GROUP BY column_name1
HAVING (arithematic function condition);
*/
--HAVING Ű����� GROUP BY Ű���尡 ���� ����Ѵ�. �ܵ� ���� ����.
--HAVING Ű���忡�� ���ǽ� �ۼ��� �����Լ��� ����Ѵ�.

SELECT department_id, COUNT(*) "COUNT", SUM(salary)
    FROM  hr.employees
    GROUP BY department_id
    ORDER BY "COUNT";

SELECT department_id, COUNT(*) "COUNT", SUM(salary)
    FROM  hr.employees
    GROUP BY department_id
    HAVING COUNT(*) >= 10
    ORDER BY "COUNT";

--����030) hr ����(������)�� employees ���̺��� �������� 
--'CLERK'���� ������ ������ ���� ���� ���. SUBSTR() �Լ� ���. WHERE ����
--Ư�� ����(job_id)�� ������ �޿� �� �� ��� ����ϴ� ���� �ۼ�. GROUP BY ����.
--�޿� ����� ���� ����(3000) �̻��� ��츸 ���. HAVING ����.





---------------------------------------------------------
--�м� �Լ� ���� Ư�� �׷��� ���� �Ŀ� �Լ� ����
--PARTITION BY Ű���� ���

SELECT department_id, last_name, salary,
       RANK() OVER (PARTITION BY department_id  ORDER BY salary DESC) "RANK"
  FROM hr.employees;

SELECT department_id, last_name, salary,
       DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) "DENSE_RANK"
  FROM hr.employees;
  
  
  
  
  
  
----------------------------------------------------------
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