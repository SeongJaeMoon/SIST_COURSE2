/*

SELECT ����

- �⺻ ����
SELECT select_list FROM source_list;
- SELECT ������ Ư�� ���̺� ����� �ڷḦ ��ȸ�ϴ� ����.
- SELECT ������ ��� ����� �����ϴ� �κ�. ���� ���, �÷��� ����. �̸�, ��ȭ��ȣ ��.
- FROM ������ �ڷᰡ ����Ǿ� �ִ� Ư�� ���̺��� �����Ѵ�. ���� ���, hr.employees
- SELECT ~ FROM ~ Ű����� ���� �Ұ�.

*/


--�ߺ��� ���� �����ϰ� ����ϱ�
--DISTINCT Ű���� �ʿ�
--SELECT DISTINCT column1, column2,...  FROM source_list;

SELECT first_name 
FROM hr.employees 
ORDER BY first_name;
--107

SELECT DISTINCT first_name 
FROM hr.employees 
ORDER BY first_name;
--91

SELECT DISTINCT first_name , last_name
FROM hr.employees 
ORDER BY first_name;
--107


--���� ������(||)�� �÷��� �ٿ��� ����ϱ�
--�� �� �̻��� �÷��̳�, ǥ������ ��� �ϳ��� �÷����� ó���� �� ���.
--����) ��Ī ��� ����

SELECT first_name || ' ' || last_name full_name
FROM hr.employees;

SELECT first_name || ', ' || last_name full_name
FROM hr.employees;


--��������) hr.employees ���̺��� ��ȸ�Ͽ� ��� ����� �̸�(first_name, last_name)�� �޿�(salary)�� �Ʒ��� ���� ���·� ���.
--��¿�) Ellen, Abel's salary is $900
SELECT first_name, last_name, salary
FROM hr.employees;

SELECT first_name || ', ' || last_name || '''s salary is $' || salary "Name and Sal"
FROM hr.employees;



------------------------------------------------------
/*

WHERE ����
--Ư�� ������ �����ϰ�, ������ �����ϴ� ��츸 ����ϵ��� �ϴ� ����.
--SELECT select_list FROM source_list WHERE ���ǽ�;
--���ǽ��� ��, ���� ����� �� �� �ִ� ����.
--���迬����, �� ������ ���� �̿��ؼ� ���ǽ� �ۼ�.
--����) �ڷ����� ��Ȯ�ϰ� �����ؾ� ��Ȯ�� ����� ���� �� �ִ�.


����Ŭ���� �����ϴ� �ڷ���
--����, ����, ��¥ ���� �ڷḦ �ڷ������� �����Ѵ�.
--���ڴ� NUMBER Ű���� ���. ����, �Ǽ� ��� ��� ����.
--���ڴ� �������� ����(CHAR)�� �������� ����(VARCHAR2)�� ����. 4000byte������ ���� ����.
--��¥�� DATE Ű���� ���. �ð� ������ ���ԵǾ� �ִ�. �⺻���� ��¥��  ��µȴ�.
--���� ���ͷ��� '(���� ����ǥ) ���� ǥ��������, ���� ���ͷ�, ��¥ ���ͷ��� '(���� ����ǥ)�� �Բ� ǥ���ؾ� �Ѵ�.
--��¥ ���ͷ��� '��¥����'�� ���缭 �ۼ�. ���� ���, '2017-12-28' �Ǵ� '20171228'


����Ŭ�� ����ϴ� ���� ������
--�� ���� �׸��� ���ؼ� ��, ������ �Ǵ��ϴ� ������.
-- =(���� ��), !=(�������� ��), >, <, >=, <=, ANY, SOME, ALL
--SELECT select_list FROM source_list WHERE �÷�  ���迬����  �񱳰�;



����Ŭ�� ����ϴ� �� ������
--�� �� �̻��� ���ǽ��� ���ؼ� ��, ������ �Ǵ��ϴ� ������.
--AND(����), OR(����), NOT(������)
--SELECT select_list FROM source_list WHERE ���ǽ�1 �������� ���ǽ�2;

*/

-- =(���� ��) �����ڸ� �̿��ؼ� ����ϱ�
-- ����, ��¥ �ڷ����� ����ϴ� ��� '(���� ����ǥ) ���. ��ҹ��� �����Ѵ�.
-- ���� �ڷ����� ����ϴ� ��� '(���� ����ǥ) ����.

SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE first_name = 'Steven';
--2

SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary = 10000;

SELECT employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE hire_date = '2005-10-30';

SELECT employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE hire_date = '20051030';

SELECT employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE hire_date = '2005/10/30';


-- !=(�������� ��) �����ڸ� �̿��ؼ� ����ϱ�
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE first_name != 'Steven';
--105


-- >, <, >=, <= �����ڸ� �̿��ؼ� ����ϱ�
SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary >= 10000;
--19

SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE first_name >= 'S';

SELECT employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE hire_date >= '2005-10-30';

SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary >= ALL (10000, 15000);
  
SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary = ANY (10000, 12000);


SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE first_name = 'Steven' AND salary >= 10000;

SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE first_name = 'Steven' OR first_name = 'John';

SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE  NOT (first_name = 'Steven' OR first_name = 'John');


--��������) hr.employees ���̺��� 
--�޿�(salary)�� 20000  �̻��̸鼭, 
--�μ���ȣ(department_id)�� 90�� ��� ���.


---------------------------------------
/*

��¥ �ڷῡ ���� ����ȯ
-- TO_CHAR() �����Լ� ���
-- �ܺο��� �ڷḦ �����ϸ�, ���������� ���� ���� ��, ����� ��ȯ�Ѵ�.
-- TO_CHAR(��¥�ڷ�, '����')
-- ������ �⵵(YYYY), ��(MM), ��(DD), ����(DAY), �ð�(HH, HH24), ��(MI), ��(SS)�� �ٷ�� ������ �����Ѵ�.
-- ���� ���, TO_CHAR(��¥�ڷ�, 'YYYY-MM-DD')

*/

-- hr.employees ���̺��� �Ի���(hire_date) ���� �߿��� �⵵�� '2005'�� ��츸 ���.
SELECT employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE TO_CHAR(hire_date, 'YYYY') = '2005';

-- �ð� ���� ����ϱ�
SELECT employee_id, first_name, last_name
    , hire_date hire_date1
    , TO_CHAR(hire_date, 'YYYY-MM-DD HH24:MI:SS') hire_date2
    , TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') hire_date3
FROM hr.employees;

SELECT 
TO_CHAR(SYSDATE, 'YYYY-MM-DD') date1
,TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') date2
,TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY HH24:MI:SS') date3
FROM dual;

SELECT 
TO_CHAR(SYSDATE, 'YY') date1
,TO_CHAR(SYSDATE, 'YYYY') date2
FROM dual;

--��������) ��¥ ��½� '23-JAN-76' ���·� ����մϴ�. 


--��������) hr.employees ���̺��� �Ի���(hire_date) ���� �߿��� 12�� �Ի��ڸ� ���.


--��������) hr.employees ���̺��� �Ի���(hire_date) ���� �߿��� Ư���⵵(2005), Ư����(6) �Ի��ڸ� ���.


--��������) hr.employees ���̺��� �Ի���(hire_date) ���� �߿��� 1, 2, 3�� �Ի��ڸ� ���.


