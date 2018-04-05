--------------------------------
--��������(SubQuery)
--���� ���� ���� SELECT ������ ���Ե� ������ ����.
--����) ���������� ( �� )�� ���ξ� �Ѵ�.
--�⺻ ����
/*
SELECT select_list
FROM table_list
WHERE �÷� ������ (��������);
*/
--���������� ���� ����ǰ�, ����� ������ ���������� ����ȴ�.


-----------------------------------
--���� �� ��������
--�������� ����� 1���� �ุ ������ ���
--�����ڴ� �� ������(=, !=, >, <, >=, <=) �߿� �ϳ� ��� ����.
/*
SELECT select_list
FROM table_list
WHERE �÷� = (�����);
*/

--hr.employees ���̺��� employee_id�� 150�� ����� ���� �޿��� �޴� ��� ���.
SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary = (SELECT salary
FROM hr.employees
WHERE employee_id=150);
--10000
--4


--����) hr.employees ���̺��� department_id�� 100�� ������� ��ձ޿�(????)���� ���� �޿��� �޴� ��� ���.

--����) hr.employees ���̺��� department_id�� 100�� ������� �ְ�޿�(????)���� ���� �޿��� �޴� ��� ���.

--����) hr.employees ���̺��� department_id�� 100�� ������� �����޿�(????)���� ���� �޿��� �޴� ��� ���.
SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary < (SELECT MIN(salary)
FROM hr.employees
WHERE department_id=100);
--6900
--59

-----------------------------------
--���� �� ��������
--�������� ����� �������� ���� ������ ���
--�����ڴ� IN, EXISTS, >ALL, >ANY, <ALL, <ANY ��� ����.
/*
SELECT select_list
FROM table_list
WHERE �÷� IN (�����1, �����2, ...);
*/
/*
SELECT select_list
FROM table_list
WHERE EXISTS (�����1, �����2, ...);
*/

--hr.employees ���̺��� department_id�� 100�� ������ ���� �޿��� �޴� ��� ���.
SELECT employee_id, first_name, last_name, salary
    , department_id
FROM hr.employees
WHERE salary IN (SELECT salary
FROM hr.employees
WHERE department_id=100);


SELECT employee_id, first_name, last_name, salary
    , department_id
FROM hr.employees
WHERE salary IN (SELECT salary
FROM hr.employees
WHERE department_id=300);


--����) hr.employees ���̺��� department_id�� 100�� ������� �Ի�⵵(YYYY)�� ���� �⵵ �Ի��� ���.


--hr.employees ���̺��� department_id�� 100�� ������� �޿� ����(���)�� �����ϸ� ���� ���� ����.
SELECT employee_id, first_name, last_name, salary
    , department_id
FROM hr.employees
WHERE EXISTS (SELECT salary
FROM hr.employees
WHERE department_id=100);


SELECT employee_id, first_name, last_name, salary
    , department_id
FROM hr.employees
WHERE EXISTS (SELECT salary
FROM hr.employees
WHERE department_id=300);



-----------------------------------
--hr.employees ���̺��� department_id�� 100�� ������� �����޿�(????)���� ���� �޿��� �޴� ��� ���.
--ALL, ANY ������ ���
SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary <ALL (SELECT salary
FROM hr.employees
WHERE department_id=100);
--12008, 9000, 8200, 7700, 7800, 6900
--59


--hr.employees ���̺��� department_id�� 100�� ������� �ְ�޿�(????)���� ���� �޿��� �޴� ��� ���.
SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary <ANY (SELECT salary
FROM hr.employees
WHERE department_id=100);
--12008, 9000, 8200, 7700, 7800, 6900
--99



--hr.employees ���̺��� department_id�� 100�� ������� �ְ�޿�(????)���� ���� �޿��� �޴� ��� ���.
--ALL, ANY ������ ���
SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary >ALL (SELECT salary
FROM hr.employees
WHERE department_id=100);
--12008, 9000, 8200, 7700, 7800, 6900
--6


--hr.employees ���̺��� department_id�� 100�� ������� �����޿�(????)���� ���� �޿��� �޴� ��� ���.
SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary >ANY (SELECT salary
FROM hr.employees
WHERE department_id=100);




-------------------------------
--���� �÷� ��������
--����� ���� �÷����� ������ ���
--�⺻ ����
/*
SELECT select_list
FROM table_list
WHERE (�÷�1, �÷�2, ...) IN (�÷�1_�����, �÷�2_�����, ...);
*/

--hr.employees ���̺��� department_id�� 100�� ��� ���� �߿��� job_id, salary�� ��ġ�ϴ� ��� ���.
SELECT employee_id, first_name, last_name
    , job_id, salary, department_id
FROM hr.employees
WHERE (job_id, salary) IN (SELECT job_id, salary
FROM hr.employees
WHERE department_id=100);


--hr.jobs, hr.employees ���̺��� ����(job_id)�� �ִ� �޿�(max_salary)�� �޴� ��� ���� ���.
SELECT employee_id, first_name, last_name
    , job_id, salary
FROM hr.employees
WHERE (job_id, salary) IN (SELECT job_id, max_salary
FROM hr.jobs);


--����) hr.jobs, hr.employees ���̺��� ����(job_id)�� �ּ� �޿�(min_salary)�� �޴� ��� ���� ���.


--����) hr.employees ���̺��� �μ���ȣ(department_id)���� �Ի���(hire_date) ������ ���� ���� ����� ���.
--���� �÷� ������������ GROUP BY, MIN() �Լ� ���.



-------------------------------
--��ȣ ���� ��������
--���� ������ ����� ������, ���������� �����ϰ�, ���������� ����� ���� ������ �����ϴ� ���.
--���� ������ ���̺� ���ؼ� �ݵ�� ��Ī ���.
--�⺻ ����
/*
SELECT select_list
FROM table_list ��Ī
WHERE �÷� ������ (���������� ���ǽĿ� �������� �÷� ���� ����);
*/

SELECT employee_id, first_name, last_name
    , salary
    , department_id
FROM hr.employees emp
WHERE salary >= (SELECT AVG(salary) FROM hr.employees
        WHERE department_id=emp.department_id);
--���� ����ϰ��� �ϴ� ����� �μ���ȣ(emp.department_id)�� ��ձ޿�
--41


-------------------------------
--��Į�� ��������
--���� ������ ����� ������, ���������� �����ϰ�, ���������� ����� ���� ������ �����ϴ� ���.
--���� ������ ���̺� ���ؼ� �ݵ�� ��Ī ���.
--OUTER JOIN�� ���� ���. JOIN ���� ����.
--�⺻ ����
/*
SELECT select_list
    , (���������� ���ǽĿ� �������� �÷� ���� ����)
FROM table_list ��Ī;
*/

--hr.employees ���̺��� ��� ���� ��½�, �μ���(hr.departments ���̺��� department_name)�� ���� ���.
SELECT employee_id, first_name, last_name
    , department_id
    , (SELECT department_name
        FROM hr.departments
        WHERE department_id=emp.department_id) department_name
FROM hr.employees emp;


--hr.employees ���̺��� ��� ���� ��½�
--, �μ���(hr.departments ���̺��� department_name)��
-- ������(hr.jobs ���̺��� job_title)�� ���� ���.
SELECT employee_id, first_name, last_name
    , department_id
    , (SELECT department_name
        FROM hr.departments
        WHERE department_id=emp.department_id) department_name
    , job_id
    , (��Į�� ���� ����) job_title
FROM hr.employees emp;


