/*

SELECT ����

- �⺻ ����
SELECT select_list FROM source_list;
- SELECT ������ Ư�� ���̺� ����� �ڷḦ ��ȸ�ϴ� ����.
- SELECT ������ ��� ����� �����ϴ� �κ�. ���� ���, �÷��� ����. �̸�, ��ȭ��ȣ ��.
- FROM ������ �ڷᰡ ����Ǿ� �ִ� Ư�� ���̺��� �����Ѵ�. ���� ���, hr.employees
- SELECT ~ FROM ~ Ű����� ���� �Ұ�.

*/


------------------------------------------------------
/*

WHERE ����
--Ư�� ������ �����ϰ�, ������ �����ϴ� ��츸 ����ϵ��� �ϴ� ����.
--SELECT select_list FROM source_list WHERE ���ǽ�;
--���ǽ��� ��, ���� ����� �� �� �ִ� ����.
--���迬����, �� ������ ���� �̿��ؼ� ���ǽ� �ۼ�.
--����) �ڷ����� ��Ȯ�ϰ� �����ؾ� ��Ȯ�� ����� ���� �� �ִ�.

*/


------------------------------------------------------

--BETWEEN �����ڷ� ���� ������ ��ȸ�ϱ�
--SELECT select_list FROM source_list WHERE �÷� BETWEEN ��1 AND ��2;
--��1���� ��2 ������ �����ϴ� ��츦 ����Ѵ�.

--���� ���, hr.employees ���̺��� �޿�(salary)�� 0���� 10000�� ��� ���
SELECT  employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary BETWEEN 0 AND 10000;
--92

--���� ���, hr.employees ���̺��� �޿�(salary)�� 5000���� 10000�� ��� ���
SELECT  employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary BETWEEN 5000 AND 10000;
--43

--BETWEEN �����ڸ� �Ϲ� ���� �����ڷ� ǥ���ϸ� ������ ����.
SELECT  employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary >= 5000 AND salary <= 10000;
--43

--hr.employees ���̺��� �Ի���(hire_date) �������� 2000�⵵~2005�⵵ �Ի��� ���.
SELECT  employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE TO_CHAR(hire_date, 'YYYY') BETWEEN '2000' AND '2005';
--53


--hr.employees ���̺��� first_name �������� 'A'~'B'�� �����ϴ� �̸��� ���� ��� ���.
SELECT  employee_id, first_name, last_name
FROM hr.employees
WHERE first_name BETWEEN 'A' AND 'C';
--12




------------------------------------------------------

--IN �����ڷ� ���� ������ �����ϰ� �˻��ϱ�
--SELECT select_list FROM source_list WHERE �÷� IN (��1, ��2, ��3, ...);
--��1, ��2, ��3 ��� ������ �� �߿� �ϳ��� �����ϸ� ����Ѵ�.
--���� ���,  hr.employees ���̺��� �Ի���(hire_date) ���� �߿��� 1, 2, 3�� �Ի��ڸ� ���.
SELECT  employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE TO_CHAR(hire_date, 'MM') IN ('01', '02', '03');

SELECT  employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE TO_CHAR(hire_date, 'MM') IN (1, 2, 3); --�Ͻ��� ����ȯ ����

--IN �����ڸ� �Ϲ� ���� �����ڷ� ǥ���ϸ� ������ ����.
SELECT  employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE TO_CHAR(hire_date, 'MM') = '01'
        OR TO_CHAR(hire_date, 'MM') = '02'
        OR TO_CHAR(hire_date, 'MM') = '03';


--hr.employees ���̺��� job_id�� Manager�� ��� ���
--'SA_MAN', 'ST_MAN', 'PU_MAN', 'AC_MGR'
SELECT  employee_id, first_name, last_name, job_id
FROM hr.employees
WHERE job_id IN ('SA_MAN', 'ST_MAN', 'PU_MAN', 'AC_MGR');
--12


------------------------------------------------------

--LIKE �����ڷ� ����� �͵� ��� ã��
--SELECT select_list FROM source_list WHERE �÷� LIKE '���ϵ�ī�� ���� ��';
--���ϵ�ī��� %(���� ���� ��ü ����), _(�� ���� ��ü ����) �߿� �ϳ��� ǥ��
--���� ���, '%��', '��%', '%��%' ���·� ���.

--hr.employees ���̺��� first_name�� 'A'�� �����ϴ� ��� ���.
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE first_name LIKE 'A%';
--10

--hr.employees ���̺��� first_name�� 'A'~'B'�� �����ϴ� ��� ���.
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE first_name LIKE 'A%' OR first_name LIKE 'B%';
--12


--hr.employees ���̺��� first_name�� 'An'�� �����ϴ� ��� ���.
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE first_name LIKE 'An%';
--1

--hr.employees ���̺��� phone_number�� '123'�� �����ϴ� ��� ���.
SELECT employee_id, first_name, last_name, phone_number
FROM hr.employees
WHERE phone_number LIKE '%123%';
--16
--����) ���ϵ�ī�带 LIKE ������ ���ǽ��� �տ� ǥ��Ǵ� ���� �������� �ʴ´�. �ӵ� ����.


------------------------------------------------------

--IS NULL, IS NOT NULL �����ڷ� NULL �˻��ϱ�
--SELECT select_list FROM source_list WHERE �÷� IS NULL;
--NULL �� =(���� ��) �����ڷ� �˻� �Ұ�.
--�÷��� ���� ��������� �������� �ʴ� ���¸� NULL�̶�� �Ѵ�. ����, ����, ��¥ �ڷ��� ��� NULL ���.
--NULL ������� �ʴ� ���� Primary key�� ���� ������ ������ ����̴�.

--hr.employees ���̺��� �μ���ȣ(department_id)�� �Ҵ���� ���� ��� ���
SELECT employee_id, first_name, last_name, department_id
FROM hr.employees
WHERE department_id IS NULL;
--1

SELECT employee_id, first_name, last_name, department_id
FROM hr.employees
WHERE department_id IS NOT NULL;
--106



------------------------------------------------------

--�˻� ������ �� �� �̻��� ��� ��ȸ�ϱ�
--AND(����), OR(����) ������
--SELECT select_list FROM source_list WHERE ����1 AND ����2 AND ����3 ...;
--SELECT select_list FROM source_list WHERE ����1 OR ����2 OR ����3 ...;
--OR ������ ��� IN �����ڸ� ����� �� �ִ�.

--hr.employees ���̺��� �޿�(salary)�� 10000 �̻��̸鼭, �μ���ȣ(department_id)�� 100�� ��� ���.
SELECT employee_id, first_name, last_name
        , salary, department_id
FROM hr.employees
WHERE salary >= 10000 AND department_id = 100;
--1


--hr.employees ���̺��� �޿�(salary)�� 10000 �̻��̸鼭, Ŀ�̼�(commission_pct)�� ���� ��� ���.
SELECT employee_id, first_name, last_name
        , salary, department_id
FROM hr.employees
WHERE salary >= 10000 AND commission_pct IS NULL;
--8



---------------------------------------------------
--���� ����� �ܺο��� �ڷ� �Է¹ޱ�
--���� ������ &�ĺ��ڸ� ����ϸ� ���� ����� �ܺ� �Է� ó�� ����.
--���� ���, ������ȣ(employee_id)�� �ܺ� �Է¹��� �� �˻� ����.
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE employee_id = &employee_id;





-------------------------------------------------------------
/*

ORDER BY ����
--���� ����
--SELECT select_list FROM source_list ORDER BY �÷�;
--���� ����� ��������(ASC), ��������(DESC) ����
--ASC�� ���� ����, DESC�� ���� �Ұ�.
--���� ���, �̸� ���� �������� �����Ѵٸ�
SELECT employee_id, first_name, last_name
FROM hr.employees
ORDER BY first_name ASC
--���� �÷��� �� �� �̻� �����ϸ� 1��, 2�� ���� ����.
--SELECT select_list FROM source_list ORDER BY �÷�1 ASC, �÷�2 DESC;
--ORDER BY �������� select_list���� ����� ��Ī(Alias) ��� ����.
--WHERE ������ �Բ� ���� SELECT ~ FROM ~ WHERE ~ ORDER BY ������ �ۼ�.

*/

--hr.employees ���̺� �ڷ� ��½� �̸�(first_name) ���� �������� ���� ����Ѵ�.
SELECT employee_id, first_name, last_name
FROM hr.employees
ORDER BY first_name ASC;

--hr.employees ���̺� �ڷ� ��½� �޿�(salary) ���� �������� ���� ����Ѵ�.
SELECT employee_id, first_name, last_name, salary
FROM hr.employees
ORDER BY salary DESC;

--hr.employees ���̺� �ڷ� ��½� �μ���ȣ(department_id) ��������, �޿�(salary) �������� ���� ����Ѵ�.
SELECT employee_id, first_name, last_name, department_id, salary
FROM hr.employees
ORDER BY department_id, salary DESC;

--hr.employees ���̺� �ڷ� ��½� �μ���ȣ(department_id) ��������, �޿�(salary) �������� ���� ����Ѵ�.
--��, �޿�(salary)�� 10000 �̻��� ��츸 ���.
SELECT employee_id, first_name, last_name, department_id, salary
FROM hr.employees
WHERE salary >= 10000
ORDER BY department_id, salary DESC;


--hr.employees ���̺� �ڷ� ���� ��½� ��Ī ���.
SELECT employee_id, first_name, last_name, TO_CHAR(hire_date, 'YYYY') year_
FROM hr.employees
ORDER BY year_;
--����) ORDER BY ���� ���� ��ҿ��� ��Ī ��� �Ұ�. ��ǥ������ WHERE ����.
SELECT employee_id, first_name, last_name, TO_CHAR(hire_date, 'YYYY') year_
FROM hr.employees
WHERE year_ IN ('2002', '2003') --X
ORDER BY year_;
SELECT employee_id, first_name, last_name, TO_CHAR(hire_date, 'YYYY') year_
FROM hr.employees
WHERE TO_CHAR(hire_date, 'YYYY') IN ('2002', '2003') --O
ORDER BY year_;


--NULL���� ���Ե� �÷� ���� ���� ���
SELECT employee_id, first_name, last_name, commission_pct
FROM hr.employees
ORDER BY commission_pct;



--------------------------------------------------
/*
�Լ�(Function)
-- ���� �Լ�, ����� ���� �Լ�
-- �Ű������� � ���� �����ϸ�, �������� ó���� �����ϰ�, ����� ��ȯ�ϵ��� ������� �ڵ�.
-- ������ �Լ�(��� ��� �� ��)�� ������ �Լ�(�������� ���� �����ϸ� ��� �� ��)�� ���еȴ�.
-- ������ �Լ��� �����Լ�, �����Լ�, ��¥�Լ�, ��ȯ�Լ�, �Ϲ��Լ��� ����.
*/

-------------------------------------
--INITCAP() �Լ�
--(����)���ڿ����� ù ���ڸ� �빮�ڷ� ǥ��.
--���� ���, 'steven'�� 'Steven'�� ǥ�����ش�.
--������ �Լ��� ��� �빮��(UPPER), ��� �ҹ���(LOWER)�� ǥ���ϴ� �Լ��� �ִ�.
SELECT employee_id
        , first_name
        , INITCAP(first_name)
        , UPPER(first_name)
        , LOWER(first_name)
FROM hr.employees;


-------------------------------------
--UPPER() �Լ�
--(����)���ڿ����� ��� �빮�ڷ� ǥ��.
--���� ���, 'Steven'�� 'STEVEN'�� ǥ�����ش�.
--������ �Լ��� ù���� �빮��(INITCAP), ��� �ҹ���(LOWER)�� ǥ���ϴ� �Լ��� �ִ�.
--�˻��� ��ҹ��ڸ� �����ϱ� ������ �ҹ���, �빮�ڷ� ��ȯ �ʿ�.

-------------------------------------
--LOWER() �Լ�
--(����)���ڿ����� ��� �ҹ��ڷ� ǥ��.
--���� ���, 'Steven'�� 'steven'�� ǥ�����ش�.
--������ �Լ��� ù���� �빮��(INITCAP), ��� �빮��(UPPER)�� ǥ���ϴ� �Լ��� �ִ�.
--�˻��� ��ҹ��ڸ� �����ϱ� ������ �ҹ���, �빮�ڷ� ��ȯ �ʿ�.

SELECT employee_id , first_name, last_name
FROM hr.employees
WHERE first_name='steven'; --��� ����. ��ҹ��� �����Ѵ�.

SELECT employee_id , first_name, last_name
FROM hr.employees
WHERE LOWER(first_name)=LOWER('steven'); --�ùٸ� ���


----------------------------
--LENGTH() �Լ�
--���ڿ��� ���ڼ� ��ȯ�ϴ� �Լ�. �ѱ�, ���� ������� ���ڼ� ��ȯ.
--������ �Լ��� LENGTHB() �Լ��� �ִ�. ����Ʈ ������ ��ȯ�Ѵ�.
SELECT employee_id
    , first_name
    , LENGTH(first_name)
FROM hr.employees;

SELECT LENGTH('TEST')
    , LENGTH('�׽�Ʈ')
    , LENGTHB('TEST')
    , LENGTHB('�׽�Ʈ')  --�ѱ� �� ���ڴ� 3byte
FROM dual;


----------------------------
--LENGTHB() �Լ�
--���ڿ��� ����Ʈ ��ȯ�ϴ� �Լ�. �ѱ�, ��� �ٸ� ��� ��µȴ�.
--�ѱ� �� ���ڴ� 3byte, ������ �� ���ڴ� 1byte
--������ �Լ��� LENGTH() �Լ��� �ִ�. ���ڼ� ������ ��ȯ�Ѵ�.


-----------------------------
--CONCAT() �Լ�
--���ڿ� �� ���� �ϳ��� ���ڿ��� ���ս����ִ� �Լ�.
--���ڿ� ���� ������(||)�� �̿��ϸ� �� �� �̻��� ���ڿ� ���� ����.
SELECT employee_id, first_name, last_name
        , CONCAT(first_name, last_name) fullname1
        , first_name || ' ' || last_name fullname2
FROM hr.employees;



-----------------------------
--SUBSTR() �Լ�
--���ڿ��� �Ϻ�(������ġ, ���ڼ�)�� �����ؼ� ��ȯ�ϴ� �Լ�.
--����) ���� ��ġ�� 1���� �����Ѵ�.
SELECT 
    SUBSTR('ABCDE', 1, 2)
    ,SUBSTR('ABCDE', 2, 2)
    ,SUBSTR('ABCDE', 3, 2)
    ,SUBSTR('ABCDE', 4, 2)
FROM dual;









