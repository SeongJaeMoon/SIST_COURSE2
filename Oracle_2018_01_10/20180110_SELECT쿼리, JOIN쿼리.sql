------------------------
--JOIN
/*

1. ������ ����ϸ� ���̺� ���� ���� ���踦 �������� �� �̻��� ���̺��� �����͸� �˻��� �� �ִ�.

INNER JOIN - ���� ���� ������ ������ �����ϴ� ROW�� ���
OUTER JOIN - ���� ���� ������ ������ �����ϴ� ��� �ܿ��� ���

EQUI JOIN - =(equal) �����ڸ� �̿��� ������ ����� JOIN
NON-EQUI JOIN - =(equal) ������ ���� �����ڸ� �̿��� ������ ����� JOIN

SELF JOIN - �ڱ� �ڽ��� �� ���� ���� ���̺�� ���� JOIN�ϴ� ���. ��Ī ���.

ANSI JOIN - JOIN ������ ����Ŭ ����� �ƴ϶� ǥ������ ������� �ۼ��� ��.



2. employees, departments, job_history, jobs, locations, countries, regions ���̺��� ���� �м�

*/


-------------------------------
--3.EQUI JOIN

/*
�� �� �̻��� ���̺� ����Ǵ� �÷����� ������ ��ġ�ϴ� ��쿡 ����ϴ� ���� �Ϲ����� join ���·� WHERE ���� '='(��ȣ)�� ����Ѵ�. ���� PRIMARY KEY, FOREIGN KEY ���踦 �̿��ϸ� ����Ŭ������ NATURAL JOIN�� EQUI JOIN�� �����ϴ�. �Ǵ� USING ���� ����Ͽ� EQUI JOIN�� ������ ����� ��� �Ѵ�.
PRIMARY KEY, FOREIGN KEY ������ �ɷ��ִ� �÷��� ������ ��ġ�ϵ��� �Ǿ� �ִ�.


����-1
SELECT *
	FROM ���̺�_��1, ���̺�_��2
	WHERE ���̺�_��1.�÷�_��1=���̺�_��2.�÷�_��1;

SELECT ���̺�_��1.�÷�_��, ���̺�_��2.�÷�_�� 
	FROM ���̺�_��1, ���̺�_��2
	WHERE ���̺�_��1.�÷�_��1=���̺�_��2.�÷�_��1;

SELECT ��Ī1.�÷�_��, ��Ī2.�÷�_�� 
	FROM ���̺�_��1 ��Ī1, ���̺�_��2 ��Ī2
	WHERE ��Ī1.�÷�_��1=��Ī2.�÷�_��1
    AND ���ǽ�
    GROUP BY �÷�, ...
    ...;

����-ANSI SQL
SELECT ���̺�_��1.�÷�_��, ���̺�_��2.�÷�_�� 
	FROM ���̺�_��1 JOIN ���̺�_��2 
	ON ���̺�_��1.�÷�_��1=���̺�_��2.�÷�_��1
    WHERE ���ǽ�
    GROUP BY �÷�, ...
    ...;
*/



--PK, FK ������ �ִ� ���̺� �� �÷��� Ȯ���ϸ� JOIN ������ ���� �̷������.
--�������, hr.employees, hr.departments ���̺��̴�. ���� �÷��� department_id
--JOIN�� �̷������ hr.employees, hr.departments ���̺��� �� ���� ���� ���̺��� �ȴ�.
--��, ���� ���̺� ��� �����ϴ� �÷��� ��� ���̺�� ǥ�� �ʼ�.
/*
SELECT *
	FROM ���̺�_��1, ���̺�_��2
	WHERE ���̺�_��1.�÷�_��1=���̺�_��2.�÷�_��1;
*/

SELECT *
FROM hr.departments;
--27

SELECT *
FROM hr.employees;
--107

SELECT *
FROM hr.employees, hr.departments
WHERE hr.employees.department_id = hr.departments.department_id;
--106


SELECT employee_id, first_name, last_name
    , department_name
    , hr.employees.department_id
FROM hr.employees, hr.departments
WHERE hr.employees.department_id = hr.departments.department_id;
--106


--Oracle JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id;
--106


--ANSI JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e INNER JOIN hr.departments d
ON e.department_id = d.department_id;
--106



-------------------------------------
--JOIN(���� ����) + �Ϲ� ����


SELECT employee_id, first_name, last_name
    , department_id
FROM hr.employees
WHERE department_id = 100;


--Oracle JOIN
SELECT employee_id, first_name, last_name
    , e.department_id
    , department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id  
AND e.department_id = 100;


--ANSI JOIN
SELECT employee_id, first_name, last_name
    , e.department_id
    , department_name
FROM hr.employees e INNER JOIN hr.departments d
ON e.department_id = d.department_id  
WHERE e.department_id = 100;





--����) hr.employees, hr.jobs ���̺��� ���� �����ϰ�
--, ���� ���̺� �÷� ������ ��� ���.

--Oracle JOIN

--ANSI JOIN




--����) hr.employees, hr.jobs ���̺��� ���� �����ϰ�
--job_title�� 'Stock Manager'�� ���� ���� ���.

--Oracle JOIN

--ANSI JOIN



------------------------------------

--job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ���� ���
SELECT *
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id
AND j.job_title = 'Stock Manager' OR j.job_title = 'Stock Clerk';

--job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ���� ���
SELECT employee_id, first_name, last_name
    , job_title
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id 
AND job_title IN ('Stock Manager', 'Stock Clerk');




--------------------------------------------
--4. Non-Equi Join
/*
- Join ���ǿ��� = ������ �ƴ� ��� ��츦 ���Ѵ�.
- �� ����� �÷� ���� �������� ��� �����ϴ�.

SELECT �÷�����Ʈ(��Ī ��� �ʿ�)
	FROM ���̺�1 ��Ī1, ���̺�2 ��Ī2
	WHERE ��Ī1.�÷� <= ��Ī2.�÷�;

SELECT �÷�����Ʈ(��Ī ��� �ʿ�)
	FROM ���̺�1 ��Ī1, ���̺�2 ��Ī2
	WHERE ��Ī1.�÷� >= ��Ī2.�÷�;
*/






-------------------------------------------------------
--5. Outer Join

/*
- ���� ���̺� ������ ���� �����ϴ� ��츸 ��µǴ� ���� Equi Join(Inner Join)�̰�,
������ ���� ��� �� �� ���̺��� �ڷ�� ��� ��µǴ� ���� Outer Join�Դϴ�.

--LEFT OUTER JOIN(���̺�2�� NULL�� ��µǴ� ����)
--���̺�1�� ��ü ���, ���̺�2�� �κ� ���(Equi Join ���� �����ϴ� ��츸 ���)
--¦�� ���� ��� NULL�� ��µȴ�.
--(+)�� NULL ��� ����ʿ� ���δ�.
SELECT �÷�����Ʈ
	FROM ���̺�1 ��Ī1, ���̺�2 ��Ī2
	WHERE ��Ī1.�÷� = ��Ī2.�÷�(+);

--RIGHT OUTER JOIN(���̺�1�� NULL�� ��µǴ� ����)
SELECT �÷�����Ʈ
	FROM ���̺�1 ��Ī1, ���̺�2 ��Ī2
	WHERE ��Ī1.�÷�(+) = ��Ī2.�÷�;

--ANSI LEFT OUTER JOIN(���̺�1�� �ڷ�� ��� ���)
SELECT �÷�����Ʈ
	FROM ���̺�1 ��Ī1 LEFT OUTER JOIN ���̺�2 ��Ī2
	ON ��Ī1.�÷� = ��Ī2.�÷�;
*/


--Oracle JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id(+);
--107


--ANSI JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e LEFT OUTER JOIN hr.departments d
ON e.department_id = d.department_id;
--107


--Oracle JOIN
SELECT d.department_id, d.department_name
    , e.employee_id, e.first_name, e.last_name
FROM hr.departments d, hr.employees e
WHERE d.department_id = e.department_id(+);
--122


--ANSI JOIN
SELECT d.department_id, d.department_name
    , e.employee_id, e.first_name, e.last_name
FROM hr.departments d LEFT OUTER JOIN hr.employees e
ON d.department_id = e.department_id;
--122



--------------------------
--����) OUTER JOIN�� ����� �÷��� �Ϲ� ���ǽĿ����� (+)�� ��� �ٿ��� �Ѵ�.
--Oracle JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id(+)
AND d.department_id(+) = 50;
--107



--����) hr.employees, hr.jobs(job_title) ���̺��� (LEFT) OUTER JOIN ��� ���.

--hr.employees ��ü ��� ����. Oracle JOIN.
--107


--hr.jobs ��ü ��� ����. Oracle JOIN.



--hr.departments ���̺��� ������ ���� �μ� ���� ���.
SELECT d.department_id, d.department_name
    , e.employee_id
FROM hr.departments d, hr.employees e
WHERE d.department_id = e.department_id(+)
AND employee_id IS NULL;
--16


--����) hr.employees ���̺��� ���� ����(���� ������ ���� ����) ���� ���.
--�ڱ� �ڽ��� employee_id�� �ٸ� ������ manager_id�� ���� ����.
--���� ���, employee_id�� 150, 200�� ������ ���� �����̴�.
--SELF JOIN + OUTER JOIN ���





-------------------------------
--6. Self Join

/*
- �Ϲ����� Join�� �� ���� ���� �ٸ� ���̺��� ������� Join�� ������,
Self Join�� �ڱ� �ڽ��� ������ ���̺�(���̺�1, ���̺�2�� ��� �ڱ� �ڽ��� ����)�� �����ϰ� Join�� �����ϴ� ��.
- ��Ī ��� �ʼ�

SELECT �÷�����Ʈ
	FROM ���̺� ��Ī1, ���̺� ��Ī2
	WHERE ��Ī1.�÷� = ��Ī2.�÷�;

SELECT �÷�����Ʈ
	FROM ���̺� ��Ī1, ���̺� ��Ī2
	WHERE ��Ī1.�÷� <= ��Ī2.�÷�;

SELECT �÷�����Ʈ
	FROM ���̺� ��Ī1, ���̺� ��Ī2
	WHERE ��Ī1.�÷� >= ��Ī2.�÷�;
*/


SELECT e1.employee_id, e1.first_name, e1.last_name
, e2.employee_id, e2.first_name, e2.last_name
FROM hr.employees e1, hr.employees e2
WHERE e1.salary = e2.salary;


--hr.employees ���̺��� employee_id�� 150�� ������ �޿��� ���� �޿��� �޴� ���� ���� ���.
SELECT e1.employee_id, e1.first_name, e1.last_name
    , e1.salary
, e2.employee_id, e2.first_name, e2.last_name
, e2.job_id, e2.department_id
FROM hr.employees e1, hr.employees e2
WHERE e1.salary = e2.salary
AND e1.employee_id = 150;



--hr.employees ���̺��� employee_id�� 150�� ������ �޿����� �� ���� �޿��� �޴� ���� ���� ���.
SELECT e1.employee_id, e1.first_name, e1.last_name
    , e1.salary
, e2.employee_id, e2.first_name, e2.last_name
, e2.job_id, e2.department_id
, e2.salary
FROM hr.employees e1, hr.employees e2
WHERE e1.salary <= e2.salary
AND e1.employee_id = 150;
--19



--hr.employees ���̺��� Ư����(employee_id�� 150�� ����)�� �Ŵ��� ���� ���.
SELECT employee_id, first_name, last_name
    , manager_id
FROM hr.employees
WHERE employee_id=150;

SELECT employee_id, first_name, last_name
    , manager_id
FROM hr.employees
WHERE employee_id=100;


SELECT employee_id, first_name, last_name
    , manager_id
FROM hr.employees
WHERE manager_id IS NULL;


SELECT e1.employee_id, e1.first_name, e1.last_name
    , e1.manager_id
    , e1.department_id
    , e2.employee_id, e2.first_name, e2.last_name
    , e2.department_id
FROM hr.employees e1, hr.employees e2
WHERE e1.manager_id = e2.employee_id
AND e1.employee_id=150;


SELECT e1.employee_id, e1.first_name, e1.last_name
    , e1.manager_id
    , e1.department_id
    , e2.employee_id, e2.first_name, e2.last_name
    , e2.department_id
FROM hr.employees e1, hr.employees e2
WHERE e1.manager_id = e2.employee_id
AND e1.employee_id=100;


--����) hr.employees ���̺��� ���� ����(���� ������ ���� ����) ���� ���.
--�ڱ� �ڽ��� employee_id�� �ٸ� ������ manager_id�� ���� ����.
--���� ���, employee_id�� 150, 200�� ������ ���� �����̴�.
--89



SELECT employee_id, first_name, last_name, job_id, manager_id, department_id
FROM hr.employees 
WHERE employee_id NOT IN (SELECT manager_id
FROM hr.employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id)
ORDER BY employee_id;



SELECT employee_id, first_name,last_name,job_id, manager_id
FROM hr.employees
WHERE employee_id NOT IN (SELECT DISTINCT manager_id
FROM hr.employees
WHERE manager_id IS NOT NULL)
ORDER BY employee_id;



SELECT employee_id, first_name,last_name,job_id, manager_id
FROM hr.employees e
WHERE NOT EXISTS (SELECT * FROM hr.employees 
                WHERE manager_id=e.employee_id);






-------------------------------------------
--���̺� 3�� �̻� JOIN

/*
SELECT �÷�����Ʈ
    FROM ���̺�1, ���̺�2, ���̺�3, ...
    WHERE ���̺�1.�÷��� = ���̺�2.�÷���
            AND ���̺�2.�÷��� = ���̺�3.�÷���
            AND ... ;
*/








/*

1. ������ ����ϸ� ���̺� ���� ���� ���踦 �������� �� �̻��� ���̺��� �����͸� �˻��� �� �ִ�.

INNER JOIN - ���� ���� ������ ������ �����ϴ� ROW�� ���
OUTER JOIN - ���� ���� ������ ������ �����ϴ� ��� �ܿ��� ���

EQUI JOIN - =(equal) �����ڸ� �̿��� ������ ����� JOIN
NON-EQUI JOIN - =(equal) ������ ���� �����ڸ� �̿��� ������ ����� JOIN
SELF JOIN - �ڱ� �ڽ��� �� ���� ���� ���̺�� ���� JOIN�ϴ� ���. ��Ī ���.


ANSI JOIN - JOIN ������ ����Ŭ ����� �ƴ϶� ǥ������ ������� �ۼ��� ��.



2. employees, departments, job_history, jobs, locations, countries, regions ���̺��� ���� �м�

*/


-------------------------------------------------------------------------------------------------------------------------------
--3.EQUI JOIN

/*
�� �� �̻��� ���̺� ����Ǵ� �÷����� ������ ��ġ�ϴ� ��쿡 ����ϴ� ���� �Ϲ����� join ���·� WHERE ���� '='(��ȣ)�� ����Ѵ�. 
���� PRIMARY KEY, FOREIGN KEY ���踦 �̿��ϸ� ����Ŭ������ NATURAL JOIN�� EQUI JOIN�� �����ϴ�. 
�Ǵ� USING ���� ����Ͽ� EQUI JOIN�� ������ ����� ��� �Ѵ�.
PRIMARY KEY, FOREIGN KEY ������ �ɷ��ִ� �÷��� ������ ��ġ�ϵ��� �Ǿ� �ִ�.


����-Oracle SQL
/*
SELECT *
   FROM ���̺�_��1, ���̺�_��2
   WHERE ���̺�_��1.�÷�_��1=���̺�_��2.�÷�_��1;

SELECT ���̺�_��1.�÷�_��, ���̺�_��2.�÷�_�� 
   FROM ���̺�_��1, ���̺�_��2
   WHERE ���̺�_��1.�÷�_��1=���̺�_��2.�÷�_��1;

SELECT ��Ī1.�÷�_��, ��Ī2.�÷�_�� 
   FROM ���̺�_��1 ��Ī1, ���̺�_��2 ��Ī2
   WHERE ��Ī1.�÷�_��1=��Ī2.�÷�_��1
    AND ���ǽ�
    GROUP BY �÷�, ...
    ...;

����-ANSI SQL
SELECT ���̺�_��1.�÷�_��, ���̺�_��2.�÷�_�� 
   FROM ���̺�_��1 JOIN ���̺�_��2 
   ON ���̺�_��1.�÷�_��1=���̺�_��2.�÷�_��1
    WHERE ���ǽ�
    GROUP BY �÷�, ...
    ...;

--PK, FK ������ �ִ� ���̺� �� �÷��� Ȯ���ϸ� JOIN ������ ���� �̷������.
--�������, hr.employees, hr.departments ���̺��̴�. ���� �÷��� department_id
--JOIN�� �̷������ hr.employees, hr.departments ���̺��� �� ���� ���� ���̺��� �ȴ�.
--��, ���� ���̺� ��� �����ϴ� �÷��� ��� ���̺�� ǥ�� �ʼ�.
/*
SELECT *
   FROM ���̺�_��1, ���̺�_��2
   WHERE ���̺�_��1.�÷�_��1=���̺�_��2.�÷�_��1;
*/


-------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM hr.departments;
--27

SELECT *
FROM hr.employees;
--107

SELECT *
FROM hr.employees, hr.departments
WHERE hr.employees.department_id = hr.departments.department_id;
--106 (hr.employees���̺� department_id�� �Ҵ���� ���� ����� �ִ�.)

SELECT employee_id, first_name, last_name
    , department_name
    , hr.employees.department_id
FROM hr.employees, hr.departments
WHERE hr.employees.department_id = hr.departments.department_id;
-- 106


-- ORACLE JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id;                        -- ���̺� ��Ī�� ���� �ڵ� ���̱�
-- 106 


-- AMSI JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e INNER JOIN hr.departments d
ON e.department_id = d.department_id;
-- 106 


-------------------------------------------------------------------------------------------------------------------------------
-- JOIN(���� ����) + �Ϲ� ����
SELECT employee_id, first_name, last_name
    , department_id
FROM hr.employees
WHERE department_id = 100;

-- ORACLE SQL
SELECT employee_id, first_name, last_name
    , e.department_id
    , department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id 
AND e.department_id = 100;

-- ANSI SQL
-- (WHERE �� ON�� ������ ������ �Ѵ�, �׷��� FROM ���� ON������ FROM�̶� �����ϰ� WHERE ���� ������ ����.)
SELECT employee_id, first_name, last_name
    , e.department_id
    , department_name
FROM hr.employees e INNER JOIN hr.departments d
ON e.department_id = d.department_id 
WHERE e.department_id = 100;


--(����) hr.employees, hr.jobs ���̺��� ���� �����ϰ�
--, �������̺� �÷� ������ ��� ���

-- ORACLE JOIN
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, salary commission_pct, manager_id, department_id
    ,e.job_id, j.job_title, j.max_salary, j.min_salary 
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id; 

-- ANSI JOIN
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, salary commission_pct, manager_id, department_id
    ,e.job_id, j.job_title, j.max_salary, j.min_salary 
FROM hr.employees e INNER JOIN hr.jobs j
ON e.job_id = j.job_id; 


--(����) hr.employees, hr.jobs ���̺��� ���� �����ϰ�
-- job_title�� 'Stock_Manager'�� ���� ���� ���.
-- ORACLE JOIN
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, salary commission_pct, manager_id, department_id
    ,e.job_id, j.job_title, j.max_salary, j.min_salary 
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id
AND j.job_title = 'Stock Manager';

-- ANSI JOIN
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, salary commission_pct, manager_id, department_id
    ,e.job_id, j.job_title, j.max_salary, j.min_salary 
FROM hr.employees e INNER JOIN hr.jobs j
ON e.job_id = j.job_id
WHERE j.job_title = 'Stock Manager'; 





-------------------------------------------------------------------------------------------------------------------------------
--4. Non-Equi Join(240p) 
/*
- Join ���ǿ��� = ������ �ƴ� ��� ��츦 ���Ѵ�.
- �� ����� �÷� ���� �������� ��� �����ϴ�.

SELECT �÷�����Ʈ(��Ī ��� �ʿ�)
   FROM ���̺�1 ��Ī1, ���̺�2 ��Ī2
   WHERE ��Ī1.�÷� <= ��Ī2.�÷�;

SELECT �÷�����Ʈ(��Ī ��� �ʿ�)
   FROM ���̺�1 ��Ī1, ���̺�2 ��Ī2
   WHERE ��Ī1.�÷� >= ��Ī2.�÷�;
*/


-------------------------------------------------------------------------------------------------------------------------------
-- job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ���� ���
SELECT *
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id
AND j.job_title = 'Stock Manager' OR j.job_title = 'Stock Clerk';


-- job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ���� ���
SELECT e.employee_id, e.first_name, e.last_name
    , job_title
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id
AND job_title IN ('Stock Manager', 'Stock Clerk');


-------------------------------------------------------------------------------------------------------------------------------
--5. Outer Join (244p)

/*
- ���� ���̺� ������ ���� �����ϴ� ��츸 ��µǴ� ���� Equi Join(Inner Join)�̰�,
������ ���� ��� �� �� ���̺��� �ڷ�� ��� ��µǴ� ���� Outer Join�Դϴ�.

--LEFT OUTER JOIN(���̺�2�� NULL�� ��µǴ� ����)
--���̺�1�� ��ü ���, ���̺�2�� �κ� ���(Equi Join ���� �����ϴ� ��츸 ���)
--¦�� ���� ��� NULL�� ��µȴ�.
--(+)�� NULL ��� ����ʿ� ���δ�.
SELECT �÷�����Ʈ
   FROM ���̺�1 ��Ī1, ���̺�2 ��Ī2
   WHERE ��Ī1.�÷� = ��Ī2.�÷�(+);

--RIGHT OUTER JOIN(���̺�1�� NULL�� ��µǴ� ����)
SELECT �÷�����Ʈ
   FROM ���̺�1 ��Ī1, ���̺�2 ��Ī2
   WHERE ��Ī1.�÷�(+) = ��Ī2.�÷�;

--ANSI LEFT OUTER JOIN(���̺�1�� �ڷ�� ��� ���)
SELECT �÷�����Ʈ
   FROM ���̺�1 ��Ī1 LEFT OUTER JOIN ���̺�2 ��Ī2
   ON ��Ī1.�÷� = ��Ī2.�÷�;
    
    -- *****************FROM �������̺�, �������̺��̶�� ����ϸ� ����!!!!****************
*/

-- Oracle JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id(+);
--107 (NULL���� ��µȴ�.)

-- ANSI JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e LEFT OUTER JOIN hr.departments d
ON e.department_id = d.department_id;
-- 107


-- Oracle JOIN
SELECT d.department_id, d.department_name
    , e.employee_id, e.first_name, e.last_name
FROM hr.departments d, hr.employees e
WHERE d.department_id = e.department_id(+);
--122

-- ANSI JOIN
SELECT d.department_id, d.department_name
    , e.employee_id, e.first_name, e.last_name
FROM hr.departments d LEFT OUTER JOIN hr.employees e
ON d.department_id = e.department_id;
--122


-------------------------------------------------------------------------------------------------------------------------------

-- (����) OUTER JOIN�� ����� �÷��� �Ϲ� ���ǽĿ����� (+)�� ��� �ٿ��� �Ѵ�.
-- Oracle join
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id(+)
AND d.department_id(+) = 50; -- OUTER JOIN�� �䱸�ϴ� employee ��ü ���
--107 

SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id(+)
AND d.department_id = 50;   -- INNER JOIN�� ������� ���..(department_id �� 50�� ��츸.)
-- 45


-- (����) hr.employees, hr.jobs(job_titel) ���̺��� Outer JOIN ��� ���
-- hr.employees ��ü ��� ����
SELECT employee_id, first_name, last_name
    , e.job_id, job_title
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id(+);

-- hr.jobs ��ü ��� ����
SELECT job_title
    , j.job_id, e.employee_id, e.first_name, e.last_name
FROM hr.jobs j, hr.employees e
WHERE e.job_id = j.job_id(+);


--(����) ���� ����(���� ������ ���� ����) ���� ���
-- �ڱ� �ڽ��� employee_id�� ���� manager_id�� ���� ����
-- ���� ���, employee_id�� 150, 200�� ������ ���� �����̴�.
-- SELF JOIN + OUTER JOIN
select e1.employee_id, e1.first_name, e1.last_name, e2.manager_id
from hr.employees e1, hr.employees e2
where e1.employee_id = e2.manager_id(+)
and e2.manager_id is null;


-------------------------------------------------------------------------------------------------------------------------------
--6. Self Join (255p)

/*
- �Ϲ����� Join�� �� ���� ���� �ٸ� ���̺��� ������� Join�� ������,
Self Join�� �ڱ� �ڽ��� ������ ���̺�(���̺�1, ���̺�2�� ��� �ڱ� �ڽ��� ����)�� �����ϰ� Join�� �����ϴ� ��.
- ��Ī ��� �ʼ�

SELECT �÷�����Ʈ
   FROM ���̺� ��Ī1, ���̺� ��Ī2
   WHERE ��Ī1.�÷� = ��Ī2.�÷�;

SELECT �÷�����Ʈ
   FROM ���̺� ��Ī1, ���̺� ��Ī2
   WHERE ��Ī1.�÷� <= ��Ī2.�÷�;

SELECT �÷�����Ʈ
   FROM ���̺� ��Ī1, ���̺� ��Ī2
   WHERE ��Ī1.�÷� >= ��Ī2.�÷�;
*/


SELECT e1.employee_id, e1.first_name, e1.last_name
    , e2.employee_id, e2.first_name, e2.last_name
FROM hr.employees e1, hr.employees e2
WHERE e1.salary = e2.salary;


-- hr.employees ���̺��� employee_id�� 150�� ������ �޿��� ���� �޿��� �޴� ���� ����
SELECT e1.employee_id, e1.first_name, e1.last_name, e1.salary
    , e2.employee_id, e2.first_name, e2.last_name, e2.job_id, e2.department_id
FROM hr.employees e1, hr.employees e2
WHERE e1.salary = e2.salary
AND e1.employee_id = 150;                                                           -- 4��


-- Non-Equi Join
-- hr.employees ���̺��� employee_id�� 150�� ������ �޿����� �� ���� �޿��� �޴� ���� ����
SELECT e1.employee_id, e1.first_name, e1.last_name, e1.salary
    , e2.employee_id, e2.first_name, e2.last_name, e2.job_id, e2.department_id, e2.salary
FROM hr.employees e1, hr.employees e2
WHERE e1.salary <= e2.salary
AND e1.employee_id = 150;                                                           -- 19��


-- hr.employees ���̺��� Ư����(employee_id�� 150)�� �Ŵ���(���� ���) ���� ���.
SELECT employee_id, first_name, last_name
    , manager_id
FROM hr.employees
WHERE employee_id = 150;


SELECT e1.employee_id, e1.first_name, e1.last_name
    , e1.manager_id
    , e1.department_id
    , e2.employee_id, e2.first_name, e2.last_name
    , e2.department_id
FROM hr.employees e1, hr.employees e2
WHERE e1.manager_id = e2.employee_id 
AND e1.employee_id = 150;                                            -- 150   Peter   Tucker   145   80   145   John   Russell   80


SELECT e1.employee_id, e1.first_name, e1.last_name
    , e1.manager_id
    , e1.department_id
    , e2.employee_id, e2.first_name, e2.last_name
    , e2.department_id
FROM hr.employees e1, hr.employees e2
WHERE e1.manager_id = e2.employee_id 
AND e1.employee_id = 100;                                            -- (��� ����)���� ���� = ����

-- �ְ� ����� ��¹�
SELECT employee_id, first_name, last_name
    , manager_id
FROM hr.employees
WHERE manager_id IS NULL;


--(����) ���� ����(���� ������ ���� ����) ���� ���
-- �ڱ� �ڽ��� employee_id�� ���� manager_id�� ���� ����
-- ���� ���, employee_id�� 150, 200�� ������ ���� �����̴�.

SELECT employee_id, first_name, last_name, manager_id
FROM hr.employees
WHERE employee_id NOT IN (SELECT manager_id
FROM hr.employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id)
ORDER BY employee_id;


SELECT employee_id, first_name, last_name, manager_id
FROM hr.employees
WHERE employee_id NOT IN (SELECT DISTINCT manager_id
FROM hr.employees
WHERE manager_id IS NOT NULL)
ORDER BY employee_id;


SELECT employee_id, first_name, last_name, manager_id
FROM hr.employees e
WHERE NOT EXISTS (SELECT * FROM hr.employees WHERE manager_id = e.employee_id);



-------------------------------------------------------------------------------------------------------------------------------
--���̺� 3�� �̻� JOIN (238p �Ʒ�)

/*
SELECT �÷�����Ʈ
    FROM ���̺�1, ���̺�2, ���̺�3, ...
    WHERE ���̺�1.�÷��� = ���̺�2.�÷���
            AND ���̺�2.�÷��� = ���̺�3.�÷���
            AND ... ;
*/


SELECT e.employee_id, e.first_name, e.last_name
    , j.job_title
    , d.department_name
FROM hr.employees e, hr.jobs j, hr.departments d
WHERE e.job_id = j.job_id
AND e.department_id = d.department_id;


SELECT e.employee_id, e.first_name, e.last_name
    , j.job_title
    , d.department_name
    , l.city
FROM hr.employees e, hr.jobs j, hr.departments d, hr.locations l
WHERE e.job_id = j.job_id
AND e.department_id = d.department_id
AND d.location_id = l.location_id;






-------------------------------------------------------------------------------------------------------------------------------
--JOIN ���� Ǯ�� (HR ��Ű�� �̿�)


-1. hr.departments, hr.employees ���̺�. �μ���(department_name), �μ����� �̸�(first_name, last_name) ���. ���� ���� �̿�.
--JOIN ���� �̿��� ���
SELECT department_name
    , first_name, last_name
FROM hr.departments d, hr.employees e
WHERE d.department_id = e.department_id
AND d.manager_id = e.employee_id;


--���� ���� �̿��� ���
SELECT first_name, last_name
    , (SELECT department_name
        FROM hr.departments
        WHERE department_id = e.department_id) department_name
FROM hr.employees e
WHERE employee_id = (SELECT manager_id
                        FROM hr.departments
                        WHERE department_id = e.department_id);


--2. hr.employees, hr.jobs ���̺�. 'Neena', 'Kochhar' ������ ������(job_title)���� ���. ���� ���� �̿�.
--JOIN ���� �̿��� ���
SELECT employee_id, first_name, last_name 
    , job_title
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id
AND first_name = 'Neena';

--���� ���� �̿��� ���
SELECT employee_id, first_name, last_name 
    , (SELECT job_title
        FROM hr.jobs
        WHERE job_id = e.job_id) job_title
FROM hr.employees e
WHERE first_name = 'Neena';


--3. hr.employees, hr.jobs ���̺�. ������(job_title)�� �ּұ޿�(min_salary)�� �޴� ���� ���. ���� ���� �̿�.
--JOIN ���� �̿��� ���
SELECT first_name, last_name, j.job_id, job_title, j.min_salary, salary
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id
AND e.salary = j.min_salary;

--���� ���� �̿��� ���
SELECT employee_id, first_name, last_name
    , job_id, salary
FROM hr.employees
WHERE (job_id, salary) IN (SELECT job_id, min_salary
FROM hr.jobs);


--4. hr.jobs, hr.employees ���̺�. ������(job_title)�� ������ �� ���. ���� ���� �̿�.
--JOIN ���� �̿��� ���
SELECT job_title, COUNT(*) �����Ǽ�
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id
GROUP BY job_title;

--���� ���� �̿��� ���
SELECT (SELECT j.job_title FROM hr.jobs j WHERE e.job_id = j.job_id)
    , COUNT(*)
FROM hr.employees e
GROUP BY e.job_id;


--5. hr.employees, hr.departments ���̺��� 'David', 'Austin' ������ ���� �μ���(department_name), �μ���(manager)�̸�(first_name, last_name) ���. ���� ���� �̿�.
--JOIN ���� �̿��� ���
SELECT department_name
    , e2.first_name, e2.last_name
FROM hr.employees e1, hr.employees e2, hr.departments d
WHERE e1.department_id = d.department_id
AND e2.department_id = d.department_id
AND e1.first_name = 'David'
AND e1.last_name = 'Austin'
AND d.manager_id = e2.employee_id;


--���� ���� �̿��� ���
SELECT (SELECT department_name
        FROM hr.departments
        WHERE department_id = e.department_id) department_name
    ,first_name, last_name
FROM hr.employees e
WHERE employee_id = (SELECT manager_id
                        FROM hr.departments d
                        WHERE department_id = (SELECT department_id
                                                FROM hr.employees
                                                WHERE department_id = d.department_id
                                                AND first_name = 'David'
                                                AND last_name = 'Austin'));




--6. hr.employees ���̺��� 'Steven', 'King' ������ ���� ���� ���. ���� ����.
--JOIN ���� �̿��� ���
SELECT e2.employee_id, e2.first_name, e2.last_name
FROM hr.employees e1, hr.employees e2
WHERE e1.employee_id = e2.manager_id
AND e1.first_name = 'Steven';


--���� ���� �̿��� ���
SELECT employee_id, first_name, last_name, e1.manager_id
FROM hr.employees e1
WHERE e1.manager_id IN (SELECT e2.employee_id
FROM hr.employees e2
WHERE e2.first_name = 'Steven');


--7. hr.employees, hr.jobs, hr.job_history ���̺�. employee_id�� 101�� ������ �������丮(first_name, last_name, start_date, end_date, job_title) ���.
--JOIN ���� �̿��� ���
SELECT first_name, last_name, start_date, end_date, job_title
FROM hr.employees e, hr.jobs j, hr.job_history h
WHERE e.job_id = j.job_id
AND e.employee_id = h.employee_id
AND e.employee_id = '101';



--���� ���� �̿��� ���
SELECT (SELECT first_name
        FROM hr.employees
        WHERE employee_id = h.employee_id) first_name
        , (SELECT last_name
        FROM hr.employees
        WHERE employee_id = h.employee_id) last_name
        , start_date, end_date
        , (SELECT job_title
        FROM hr.jobs
        WHERE job_id = h.job_id) job_title
FROM hr.job_history h
WHERE employee_id = '101';




--8. hr.employees ���̺��� ���� ������ ���� ���� ���.
--JOIN ���� �̿��� ���
SELECT e1.employee_id, e1.first_name, e1.last_name
FROM hr.employees e1, hr.employees e2
WHERE e1.employee_id = e2.manager_id(+)
AND e2.manager_id IS NULL;

--���� ���� �̿��� ���
SELECT employee_id, first_name, last_name, manager_id
FROM hr.employees e
WHERE NOT EXISTS (SELECT * FROM hr.employees WHERE manager_id = e.employee_id);



--9. hr.employees ���̺��� Ư�� ����(first_name�� 'Gerald', last_name�� 'Cambrault'�� ����)�� salary���� �޿��� �� ���� �޴� ���� ���� ���.
--JOIN ���� �̿��� ���
SELECT e2.employee_id, e2.first_name, e2.last_name, e2.salary
FROM hr.employees e1, hr.employees e2
WHERE e1.salary <= e2.salary
AND e1.first_name = 'Gerald';



--���� ���� �̿��� ���
SELECT employee_id, first_name, last_name, salary
FROM hr.employees e
WHERE salary >= (SELECT salary
                    FROM hr.employees
                    WHERE first_name = 'Gerald'
                    AND last_name = 'Cambrault');




