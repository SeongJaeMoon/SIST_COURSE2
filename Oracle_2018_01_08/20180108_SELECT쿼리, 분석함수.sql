--------------------------------------------------
/*
�Լ�(Function)
-- ���� �Լ�, ����� ���� �Լ�
-- �Ű������� � ���� �����ϸ�, �������� ó���� �����ϰ�, ����� ��ȯ�ϵ��� ������� �ڵ�.
-- ������ �Լ�(��� ��� �� ��)�� ������ �Լ�(�������� ���� �����ϸ� ��� �� ��)�� ���еȴ�.
-- ������ �Լ��� �����Լ�, �����Լ�, ��¥�Լ�, ��ȯ�Լ�, �Ϲ��Լ��� ����.
*/



----------------------------
--�м� �Լ�
--�ೢ�� �����̳� �񱳸� ���� �������ֱ� ���� �Լ�
--ROLLUP(), CUBE(), GROUPING SETS(), LISTAGG(), PIVOT(), LAG(), READ(), RANK(), DENSE_RANK(), ROW_NUMBER(), SUM() OVER()


------------------------------
--ROLLUP() �Լ�
--���غ�(GROUP BY) �Ұ�(COUNT, SUM)�� ����ؼ� �����ִ� �Լ�

--hr.employees ���̺��� �μ���ȣ(department_id)���� �ο��� ���
SELECT NVL(department_id, -1) department_id, COUNT(*)
FROM hr.employees
GROUP BY NVL(department_id, -1)
ORDER BY department_id;

--hr.employees ���̺��� �μ���ȣ(department_id)���� �ο��� �� �ο��� ���� ���
SELECT NVL(department_id, -1)  department_id, COUNT(*)
FROM hr.employees
GROUP BY ROLLUP(NVL(department_id, -1))
ORDER BY department_id;


--hr.employees ���̺��� �������̵�(job_id)���� �ο��� �� �ο��� ���� ���
SELECT job_id, COUNT(*)
FROM hr.employees
GROUP BY ROLLUP(job_id)
ORDER BY job_id;


--hr.employees ���̺��� �μ���ȣ(department_id) �� �������̵�(job_id)���� �ο��� �� �ο��� �Ұ�, ���� ���
SELECT department_id, job_id, COUNT(*)
FROM hr.employees
GROUP BY ROLLUP(department_id, job_id)
ORDER BY department_id, job_id;


------------------------------
--CUBE() �Լ�
--���غ�(GROUP BY) �Ұ�(COUNT, SUM) �� ��ü�հ踦 ����ؼ� �����ִ� �Լ�

--hr.employees ���̺��� �������̵�(job_id)���� �ο��� �� �ο��� ���� ���
SELECT job_id, COUNT(*)
FROM hr.employees
GROUP BY CUBE(job_id)
ORDER BY job_id;


--hr.employees ���̺��� �μ���ȣ(department_id) �� �������̵�(job_id)���� �ο��� �� �ο��� �Ұ�, ���� ���
SELECT department_id, job_id, COUNT(*)
FROM hr.employees
GROUP BY CUBE(department_id, job_id)
ORDER BY department_id, job_id;



---------------------------
--GROUPING SETS() �Լ�
--���غ�(GROUP BY) �Ұ�(COUNT, SUM) �� ��ü�հ踦 ����ؼ� �����ִ� �Լ�


--hr.employees ���̺��� �μ���ȣ(department_id) �� �������̵�(job_id)���� �ο��� �� �ο��� �Ұ�, ���� ���
SELECT department_id, job_id, COUNT(*)
FROM hr.employees
GROUP BY GROUPING SETS(department_id, job_id)
ORDER BY department_id, job_id;


--------------------------
--LISTAGG() �Լ�
--��½� �ڷḦ �ϳ��� ���ڿ��� ���� ���.

--hr.employees ���̺��� �μ���ȣ(department_id)�� �ο��� �� ���(first_name) ���.
SELECT department_id
    , COUNT(*)
    , LISTAGG(first_name, '/') WITHIN GROUP(ORDER BY first_name) first_names
FROM hr.employees
GROUP BY department_id;


--------------------------
--PIVOT() �Լ�
--��½� ����(����) ���¸� ����(����) ���·� �ٲ��ִ� �Լ�.

--hr.employees ���̺��� �μ���ȣ �� �������̵� �ο��� ���
SELECT department_id
    , COUNT(*)
    , COUNT(DECODE(job_id, 'AD_ASST', 1)) AD_ASST
    , COUNT(DECODE(job_id, 'MK_MAN', 1)) MK_MAN
    , COUNT(DECODE(job_id, 'MK_REP', 1)) MK_REP
FROM hr.employees
GROUP BY department_id;

--hr.employees ���̺��� �μ���ȣ �� �������̵� �ο��� ���
SELECT * 
FROM (SELECT employee_id, department_id, job_id FROM hr.employees)
PIVOT (
    COUNT(employee_id) FOR job_id IN ('AD_ASST', 'MK_MAN', 'MK_REP')
)
ORDER BY department_id;



----------------------------------
--LAG() �Լ�
--���� �� ���� �������� �Լ�

--hr.employees ���̺��� �޿�(salary)�� ����ϵ�, ���� ���� �޿�(salary)�� ���� ���.
SELECT employee_id, first_name, last_name
    , salary
    , LAG(salary, 1, 0) OVER (ORDER BY salary DESC) LAG_
    , salary - LAG(salary, 1, 0) OVER (ORDER BY salary DESC) LAG2_
FROM hr.employees;


----------------------------------
--LEAD() �Լ�
--���� �� ���� �������� �Լ�

--hr.employees ���̺��� �޿�(salary)�� ����ϵ�, ���� ���� �޿�(salary)�� ���� ���.
SELECT employee_id, first_name, last_name
    , salary
    , LEAD(salary, 1, 0) OVER (ORDER BY salary DESC) LEAD_
    , salary - LEAD(salary, 1, 0) OVER (ORDER BY salary DESC) LEAD2_
FROM hr.employees;


-------------------------------
--RANK() �Լ�
--��ü ���� �ο� �Լ�
--����) ������ ó�� Ȯ��. ���� ���, 1, 2, 2, 4 ���·� ó��.

SELECT employee_id, first_name, last_name
    , salary
    , RANK() OVER (ORDER BY salary DESC) rank_
FROM hr.employees;

--hr.employees ���̺��� �޿�(salary)�� ���� ������ 5��° ������ ���.

SELECT * FROM (SELECT employee_id, first_name, last_name
    , salary
    , RANK() OVER (ORDER BY salary DESC) rank_
FROM hr.employees)
WHERE rank_ <= 5;



-------------------------------
--DENSE_RANK() �Լ�
--��ü ���� �ο� �Լ�
--����) ������ ó�� Ȯ��. ���� ���, 1, 2, 2, 3 ���·� ó��.

SELECT employee_id, first_name, last_name
    , salary
    , DENSE_RANK() OVER (ORDER BY salary DESC) rank_
FROM hr.employees;


-------------------------------
--ROW_NUMBER() �Լ�
--���� ��ȣ�� ������� �ο��ϴ� �Լ�
--���� ���, 1, 2, 3, 4 ���·� ��ȣ �ο�

SELECT employee_id, first_name, last_name
    , salary
    , ROW_NUMBER() OVER (ORDER BY salary DESC) rn_
FROM hr.employees;



-------------------------------------
--SUM() OVER() �Լ�
--�׷캰 ���踦 ������ִ� �Լ�

SELECT SUM(salary)
FROM hr.employees
WHERE department_id = 90;

SELECT employee_id, first_name, last_name
    ,department_id
    , salary
    , (SELECT SUM(salary)
        FROM hr.employees
        WHERE department_id = emp.department_id) sum_
FROM hr.employees emp
ORDER BY employee_id;

SELECT employee_id, first_name, last_name
    ,department_id, salary
    , SUM(salary) OVER (PARTITION BY department_id) sum_
FROM hr.employees
ORDER BY employee_id;

-------------------------------------
--RATIO_TO_REPORT() �Լ�
--�׷캰 ������ ������ִ� �Լ�

SELECT employee_id, first_name, last_name
    ,department_id, salary
    , SUM(salary) OVER (PARTITION BY department_id) sum_
    , ROUND((salary/SUM(salary) OVER (PARTITION BY department_id))*100, 1) "ratio_%"
FROM hr.employees
ORDER BY employee_id;

SELECT employee_id, first_name, last_name
    ,department_id, salary
    , SUM(salary) OVER (PARTITION BY department_id) sum_
    , ROUND(RATIO_TO_REPORT(salary) OVER (PARTITION BY department_id)*100, 1) "ratio_%"
FROM hr.employees
ORDER BY employee_id;

