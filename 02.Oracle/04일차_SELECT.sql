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


--------------------------------
--Single-Row Functions : Single-row functions return a single result row for every row of a queried table or view.



----------------------------------------
--Datetime Functions

--SYSDATE : SYSDATE returns the current date and time set for the operating system on which the database server resides. 

SELECT SYSDATE "NOW"
     FROM DUAL;
--18/08/16

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') "NOW"
     FROM DUAL;
--2018-08-16 09:10:20


--��¥ ������ ���� (�ϴ���)
SELECT TO_DATE('2019-03-21') - TO_DATE('2019-03-20') "��¥ ������ ����"
    FROM DUAL;


--��¥ ������ ���� (�ϴ���)
SELECT TRUNC(SYSDATE - TO_DATE('2019-02-21')) "��¥ ������ ����"
    FROM DUAL;


--��¥ ������ ���� (�ϴ���)
SELECT TRUNC(SYSDATE) - TO_DATE('2019-02-21') "��¥ ������ ����"
    FROM DUAL;
    

--���(2013) Ȯ��
SELECT TO_DATE('2013-03-01') - TO_DATE('2013-02-27') "��¥ ������ ����"
    FROM DUAL;
--2

--����(2012) Ȯ��
SELECT TO_DATE('2012-03-01') - TO_DATE('2012-02-27') "��¥ ������ ����"
    FROM DUAL;
--3




----------------------------------------
--Conversion Functions

--TO_CHAR : TO_CHAR (datetime) converts a datetime or interval value of DATE, TIMESTAMP, TIMESTAMP WITH TIME ZONE, TIMESTAMP WITH LOCAL TIME ZONE, INTERVAL DAY TO SECOND, or INTERVAL YEAR TO MONTH data type to a value of VARCHAR2 data type in the format specified by the date format fmt. 
--TO_CHAR : TO_CHAR (number) converts n to a value of VARCHAR2 data type, using the optional number format fmt.
--TO_NUMBER : TO_NUMBER converts expr to a value of NUMBER data type. 
--TO_DATE : TO_DATE converts char of CHAR, VARCHAR2, NCHAR, or NVARCHAR2 data type to a value of DATE data type.

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') "NOW"
     FROM DUAL;
--2018-08-16

SELECT TO_CHAR(SYSDATE, 'YYYY-MM') "NOW"
     FROM DUAL;
--2018-08

SELECT TO_CHAR(SYSDATE, 'YYYY') "NOW"
     FROM DUAL;
--2018

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI') "NOW"
     FROM DUAL;
--2018-08-16 09:23


SELECT TO_CHAR(TO_DATE('20180816'), 'YYYY-MM-DD') "FORMAT"
     FROM DUAL;
--2018-08-16

SELECT TO_CHAR(TO_DATE('900816'), 'YYYY-MM-DD') "FORMAT"
     FROM DUAL;
--1990-08-16

SELECT '10' + 20 FROM DUAL;
--30

SELECT TO_NUMBER('10') + 20 FROM DUAL;
--30


SELECT employee_id, first_name, last_name
    , TO_CHAR(hire_date, 'YYYY') "HIRE_DATE_YEAR"
     FROM hr.employees
     ORDER BY "HIRE_DATE_YEAR";


--����23) hr ����(������)�� employees ���̺��� �������� 
--�Ի�⵵(hire_date)�� 2005�⵵�� ��츸 ����ϴ� ���� �ۼ�.
--��½� �Ի����� ������ ��µǵ��� �Ѵ�.
--TO_CHAR() �Լ� ���

SELECT  employee_id, first_name, hire_date
    FROM HR.employees
    WHERE TO_CHAR(hire_date, 'YYYY') IN ('2005')
    ORDER BY hire_date;




---------------------------------------
--NULL-Related Functions
--NVL : NVL lets you replace null (returned as a blank) with a string in the results of a query. 
--NVL2 : NVL2 lets you determine the value returned by a query based on whether a specified expression is null or not null.


--����� ������ ����� NULL�� �ȴ�
SELECT NULL + 10 FROM DUAL;
SELECT NULL * 10 FROM DUAL;
SELECT TO_CHAR(NULL) FROM dual;
SELECT NULL, 'null' FROM DUAL;

SELECT employee_id, first_name, last_name
    , commission_pct
    , NVL(commission_pct, 0) commission_pct_
    , NVL(TO_CHAR(commission_pct), 'Not Applicable') commission
    , department_id
  FROM hr.employees;
  
  
  
SELECT employee_id, first_name, last_name, salary
    , commission_pct
    , salary + (salary * NVL(commission_pct, 0)) income
  FROM hr.employees; 
  
  
SELECT employee_id, first_name, last_name, salary
    , commission_pct
    , NVL2(commission_pct
        , salary + (salary * commission_pct)
        , salary) income
  FROM hr.employees;  
  

--����24) hr ����(������)�� employees ���̺��� �������� 
--department_id�� null�� �ƴ� ��� department_id�� ����ϰ�,
--department_id�� null�� ��� '�μ�����'���� ����ϴ� ���� �ۼ�. NVL() �Լ� ���.

SELECT employee_id, first_name, last_name
    , department_id
    , NVL(TO_CHAR(department_id), '�μ�����') department_id_
    FROM hr.employees;





-------------------------------
--Encoding and Decoding Functions

--DECODE : DECODE compares expr to each search value one by one. If expr is equal to a search, then Oracle Database returns the corresponding result. 

/*
40	Human Resources
50	Shipping
60	IT
*/

SELECT employee_id, first_name
    , department_id
    , DECODE(department_id
                    , 40, 'Human Resources'
                    , 50, 'Shipping'
                    , 60, 'IT') "department_name"
    FROM hr.employees
    ORDER BY department_id;
   
   
SELECT employee_id, first_name
    , department_id
    , DECODE(department_id
                , 40, 'Human Resources'
                , 50, 'Shipping'
                , 60, 'IT'
                , 'etc.') "department_name"
    FROM hr.employees
    ORDER BY department_id; 
    
    
SELECT employee_id, first_name
    , department_id
    , DECODE(department_id
                , 40, 'Human Resources'
                , 50, 'Shipping'
                , 60, 'IT') "department_name"
    FROM hr.employees
    WHERE department_id BETWEEN 40 AND 60
    ORDER BY department_id;
    
    

--����25) hr ����(������)�� employees ���̺��� �������� 
--salary �÷��� ���� 3���� ������� �����ؼ� ����ϴ� ���� �ۼ�. 
--DECODE() �Լ� ���.
--��½� salary�� ���� ������ ���� ����ϵ��� �Ѵ�. 
--'10000�̸�' -> '10000�޷��̸�'
--'10000�̻�~20000�̸�' -> '10000�޷���'
--'20000�̻�' -> '20000�޷���'

SELECT employee_id, first_name, salary
        , DECODE(TRUNC(salary, -4)
                    , 10000, '10000�޷���'
                    , 20000, '20000�޷���'
                    , '10000�޷��̸�') AS "SALARY ���" 
        FROM hr.employees 
        ORDER BY salary DESC;



------------------------------
--CASE ~ END ����
--���α׷����� if ~ else if ~ else ������ �ϴ� ����
--����1
/*
    CASE ���� 
        WHEN ��1 THEN ��ȯ��1
        WHEN ��2 THEN ��ȯ��2
        WHEN ��3 THEN ��ȯ��3
        ELSE ��ȯ��4
    END
*/
SELECT employee_id, first_name, salary
        , CASE TRUNC(salary, -4)
            WHEN 20000 THEN '20000�޷���'
            WHEN 10000 THEN '10000�޷���'
            ELSE '10000�޷��̸�'
          END "SALARY ���" 
        FROM hr.employees 
        ORDER BY salary DESC;
        
        
--����2
/*
    CASE  
        WHEN ���ǽ�1 THEN ��ȯ��1
        WHEN ���ǽ�2 THEN ��ȯ��2
        WHEN ���ǽ�3 THEN ��ȯ��3
        ELSE ��ȯ��4
    END
*/

SELECT employee_id, first_name, salary
        , CASE
            WHEN salary >= 20000 THEN '20000�޷���'
            WHEN salary >= 10000 THEN '10000�޷���'
            ELSE '10000�޷��̸�'
          END "SALARY ���" 
        FROM hr.employees 
        ORDER BY salary DESC;



---------------------------------------------------------------------
--Aggregate function
--Aggregate functions return a single result row based on groups of rows, rather than on single rows

--����) Aggregate function�� �ܵ� �����ؾ� �Ѵ�. �ٸ� �Լ�(Single-Row Functions)�� ���� ����� �� ����.

--COUNT : COUNT returns the number of rows returned by the query.
--SUM : SUM returns the sum of values of expr. 
--AVG : AVG returns average value of expr.
--RANK : RANK calculates the rank of a value in a group of values. 1, 2, 2, 4
--DENSE_RANK  : DENSE_RANK calculates the rank of a value in a group of values.  1, 2, 2, 3
--����) null ���� ���� �Լ� ���꿡 �������� �ʴ´�.

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
SELECT COUNT(*) "count"
    FROM hr.employees
    WHERE commission_pct IS NULL;
--72


�߰�����) hr ����(������)�� employees ���̺��� �������� 
--���������� �ִ� ������ ���� ����ϴ� ���� �ۼ�. COUNT() �Լ� ���.
--DISTINCT Ű����� �ߺ� ���� ����



----------------------------------------------
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
--SH_CLERK, ST_CLERK, PU_CLERK




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
--SH_CLERK, ST_CLERK, PU_CLERK



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
--�޿� ����� ���� ����(???) �̻��� ��츸 ���. HAVING ����.



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
