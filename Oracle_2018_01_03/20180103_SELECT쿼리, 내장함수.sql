--------------------------------------------------
/*
�Լ�(Function)
-- ���� �Լ�, ����� ���� �Լ�
-- �Ű������� � ���� �����ϸ�, �������� ó���� �����ϰ�, ����� ��ȯ�ϵ��� ������� �ڵ�.
-- ������ �Լ�(��� ��� �� ��)�� ������ �Լ�(�������� ���� �����ϸ� ��� �� ��)�� ���еȴ�.
-- ������ �Լ��� �����Լ�, �����Լ�, ��¥�Լ�, ��ȯ�Լ�, �Ϲ��Լ��� ����.
*/


-----------------------------
--SUBSTR() �Լ�
--���ڿ��� �Ϻ�(������ġ, ���ڼ�)�� �����ؼ� ��ȯ�ϴ� �Լ�.
--����) ���� ��ġ�� 1���� �����Ѵ�.
--����) ���� ��ġ�� -���� �ָ� ������ ���������� ����Ѵ�.
--������ �Լ��� SUBSTRB() �Լ��� �ִ�. ����Ʈ�� �������� �����Ѵ�.
SELECT 
    SUBSTR('ABCDE', 1, 2)
    ,SUBSTR('ABCDE', 2, 2)
    ,SUBSTR('ABCDE', 3, 2)
    ,SUBSTR('ABCDE', 4, 2)
    ,SUBSTR('ABCDE', -1, 2)
FROM dual;

--hr.employees ���̺��� ��ȭ��ȣ(phone_number)�� '515.XXX.XXXX'���� �����ϴ� ��� ���. SUBSTR() �Լ� ���.
SELECT employee_id, first_name, last_name, phone_number
FROM hr.employees
WHERE SUBSTR(phone_number, 1, 3) = '515';
--21


--hr.employees ���̺��� ��ȭ��ȣ(phone_number)�� 'XXX.XXX.4567'�� ������ ��� ���. SUBSTR() �Լ� ���.
SELECT employee_id, first_name, last_name, phone_number
FROM hr.employees
WHERE SUBSTR(phone_number, -4, 4) = '4567';
--3


-----------------------------
--SUBSTRB() �Լ�
--���ڿ��� �Ϻ�(������ġ, ����Ʈ��)�� �����ؼ� ��ȯ�ϴ� �Լ�.
--����) �����ڸ� ������� �ϴ� ��� SUBSTR() �Լ��� ����� �����ϴ�.


-----------------------------
--INSTR() �Լ�
--��� ���ڿ����� Ư�� ���ڿ��� �����ϴ��� ���θ� Ȯ���ϰ�, ��ġ�� ��ȯ�ϴ� �Լ�.
--INSTR(����ڿ�, ã�¹��ڿ�, ������ġ, Ư����°) �������� ���. Ư����°�� ���� ����.
--�˻� ����� �������� �ʴ� ��� ��ġ�� 0 ��ȯ�Ѵ�.
SELECT 'A-B-C-D'
    ,INSTR('A-B-C-D', '-', 1)
    ,INSTR('A-B-C-D', '-', 1, 2)
    ,INSTR('A-B-C-D', '*', 1)
FROM dual;

--hr.employees ���̺��� ��ȭ��ȣ(phone_number)�� '123'�� ���Ե� ��� ���. INSTR() �Լ� ���.
SELECT employee_id, first_name, last_name, phone_number
FROM hr.employees
WHERE INSTR(phone_number, '123', 1) > 0;
--16


------------------------------
--LPAD() �Լ�
--Ư�� ���ڷ� �� ������ ä��� �Լ�. ä��� ��ġ�� LEFT.
--LPAD(����ڿ�, ��ü�ڸ���, ä�﹮�ڿ�)
--������ �Լ��� RPAD() �Լ��� �ִ�. ä��� ��ġ�� RIGHT.

SELECT employee_id
    , first_name
    , LPAD(first_name, 11, '-')
    , RPAD(first_name, 11, '-')
    , RPAD(SUBSTR(phone_number, 1, 8), 12, '*') phone_number
FROM hr.employees;


------------------------------
--RPAD() �Լ�
--Ư�� ���ڷ� �� ������ ä��� �Լ�. ä��� ��ġ�� RIGHT.
--RPAD(����ڿ�, ��ü�ڸ���, ä�﹮�ڿ�)
--������ �Լ��� LPAD() �Լ��� �ִ�. ä��� ��ġ�� LEFT.


------------------------------
--LTRIM() �Լ�
--Ư�� ������ �� ����(Ư�� ����)�� �����ϴ� �Լ�. �����ϴ� ��ġ�� LEFT.
--LTRIM(����ڿ�, Ư�����ڿ�) �������� ���. Ư�����ڿ� ���� ����.
--������ �Լ��� RTRIM() �Լ��� �ִ�. �����ϴ� ��ġ�� RIGHT.

SELECT '[  TEST  ]'
        , '[' || LTRIM('   TEST    ') || ']' LTRIM_
        , '[' || RTRIM('   TEST    ') || ']' RTRIM_
FROM dual;

SELECT 'A009'
        , LTRIM('A009', 'A') ltrim_
        , CONCAT('A',LPAD(TO_NUMBER(LTRIM('A009', 'A')) + 1, 3, '0')) newNum
FROM dual;


------------------------------
--RTRIM() �Լ�
--Ư�� ������ �� ����(Ư�� ����)�� �����ϴ� �Լ�. �����ϴ� ��ġ�� RIGHT;
--RTRIM(����ڿ�, Ư�����ڿ�) �������� ���. Ư�����ڿ� ���� ����.
--������ �Լ��� LTRIM() �Լ��� �ִ�. �����ϴ� ��ġ�� LEFT.



--------------------------------
--REPLACE() �Լ�
--��� ���ڿ����� Ư�� ���ڿ��� �ٸ� ���ڿ��� ġȯ�ϴ� �Լ�.
--REPLACE(����ڿ�, ã�¹��ڿ�, ġȯ���ڿ�) �������� ���.
--����) ã�� ���ڿ��� ���� ��� ġȯ�� �Ͼ�� �ʴ´�.

SELECT employee_id, first_name, last_name
    , phone_number
    , REPLACE(phone_number, '.', '-') phone_number2
FROM hr.employees;




---------------------------------------------
--ROUND() �Լ�
--�ݿø� ó�� �Լ�
--ROUND(������, �ڸ���) �������� ���. �ڸ��� ���� ���� ����.
--������ �Լ��� TRUNC()�Լ��� �ִ�. ���� ���.
SELECT 1234.567
    , ROUND(1234.567)
    , ROUND(1234.567, 1)
    , ROUND(1234.567, 2)
    , ROUND(1234.567, -2)
FROM dual;


---------------------------------------------
--TRUNC() �Լ�
--���� ó�� �Լ�
--TRUNC(������, �ڸ���) �������� ���. �ڸ��� ���� ���� ����.
--������ �Լ��� ROUND()�Լ��� �ִ�. �ݿø� ���.
--�� ���꿡�� ��� ����.
SELECT 1234.567
    , TRUNC(1234.567)
    , TRUNC(1234.567, 1)
    , TRUNC(1234.567, 2)
    , TRUNC(1234.567, -2)
FROM dual;


-----------------------
--MOD() �Լ�
--������ ��� ��ȯ�ϴ� �Լ�
--������ �Լ��� TRUNC() �Լ�. �� ���� ��� ��ȯ.

SELECT  5/3
    , TRUNC(5/3, 0)
    , MOD(5, 3)
FROM dual;

-------------------------------
--SYSDATE �Լ�
--�ý����� ���� ��¥(�ð�)�� ��ȯ�ϴ� �Լ�
--����) �Ű����� ���ް��� ���� ������ ()�� ǥ������ �ʴ´�.
--��¥ �ڷḦ ������ ��� ���� ����. ��¥ ������ ���ȴ�.
SELECT SYSDATE
    , TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY HH24:MI:SS')
    , TO_CHAR(SYSDATE, 'YYYY-MM-DD')
    , TO_CHAR(SYSDATE, 'HH24:MI:SS')
    , TO_CHAR(SYSDATE, 'HH24:MI')
    , SYSDATE + 1
    , SYSDATE + 100
FROM dual;


SELECT employee_id, first_name, last_name, hire_date
    , TRUNC(SYSDATE - hire_date)
FROM hr.employees;


-------------------------------
--MONTHS_BETWEEN() �Լ�
--��¥ �ڷḦ ������ ��� ����(���� ����) ����. ��(����) ������ ���ȴ�.
--������ �Լ��� ADD_MONTHS() �Լ��� �ִ�. ���ϱ� ����.

SELECT employee_id, first_name, last_name, hire_date
    , TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date))
FROM hr.employees;


-------------------------------
--ADD_MONTHS() �Լ�
--��¥ �ڷḦ ������ ��� ����(���ϱ� ����) ����. ��(����) ������ ���ȴ�.
--������ �Լ��� MONTHS_BETWEEN() �Լ��� �ִ�. ���� ����.


--��¥ ��� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';

SELECT employee_id, first_name, last_name, hire_date
FROM hr.employees;



------------------------------------------
--��¥ ���� ���ǻ���
SELECT
    MONTHS_BETWEEN(SYSDATE, '2018-01-02')
    ,MONTHS_BETWEEN('2018-01-03', '2018-01-02')
    , SYSDATE - TO_DATE('2018-01-02')
    , TO_DATE('2018-01-03') - TO_DATE('2018-01-02')
    , TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD')) - TO_DATE('2018-01-02')
FROM dual;



------------------------------------------
--TO_CHAR() �Լ�
--��¥, ���� �ڷḦ ���� �ڷ�� ����ȯ�ϴ� �Լ�.
--���� ���� ���뿡 ���� �������� ������ ���ڿ��� ��ȯ�� �� �ִ�.
--��¥ ������ YYYY, MM, DD, DAY, HH24, MI, SS ���� �ִ�.
--���� ������ 9, 0, .(dot), ,(comma) ���� ���� ���.

SELECT SYSDATE
    , TO_CHAR(SYSDATE, 'YYYY-MM-DD')
    , TO_CHAR(SYSDATE, 'YYYY')
    , TO_CHAR(SYSDATE, 'MM')
    , TO_CHAR(SYSDATE, 'DD')
FROM dual;    

--hr.employees ���̺��� �Ի���(hire_date) �������� 12���� �Ի��ڸ� ���.
SELECT employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE TO_CHAR(hire_date, 'MM') = '12';
--7
SELECT employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE TO_CHAR(hire_date, 'MM') = 12; --�Ͻ��� ����ȯ ����
--7


------------------------
--�⵵ ��½� 2�ڸ� ����ϴ� ���
--YY, RR
SELECT '2060-01-01'
        , '1905-01-01'
        , TO_CHAR(TO_DATE('2060-01-01'), 'YY/MM/DD')
        , TO_CHAR(TO_DATE('1905-01-01'), 'YY/MM/DD')
        , TO_DATE(TO_CHAR(TO_DATE('1905-01-01'), 'YY/MM/DD'))
        , TO_DATE(TO_CHAR(TO_DATE('1905-01-01'), 'YYYY/MM/DD'))
FROM dual;


----------------------------------
--���� ��½� ���� ����
SELECT 12345.67
    , TO_CHAR(12345.67, '99999')
    , TO_CHAR(12345.67, '99999.99')
    , TO_CHAR(12345.67, '99,999.99')
    , CONCAT('A',LTRIM(TO_CHAR(1, '0000'))) newNum
FROM dual;



------------------------------------
--TO_NUMBER() �Լ�
--(���� ������)���� �ڷḦ ���� �ڷ�� ����ȯ�ϴ� �Լ�

SELECT
    '12' + '34'  --�Ͻ��� ����ȯ ����
    , 12 + 34
    ,'12' - '34'  --�Ͻ��� ����ȯ ����
    , 12 - 34
    , TO_NUMBER('12') + TO_NUMBER('34')
    , TO_NUMBER('12') - TO_NUMBER('34')
FROM dual;


------------------------------------
--TO_DATE() �Լ�
--(��¥ ������)���� �ڷḦ ��¥ �ڷ�� ����ȯ�ϴ� �Լ�
SELECT TO_DATE('900101')
    , TO_DATE('19900101')
    , TO_DATE('1990-01-01')
    , TO_DATE('1990/01/01')
    , TO_CHAR(TO_DATE('050101'), 'YYYY-MM-DD')
FROM dual;

--hr.employees ���̺��� �Ի���(hire_date) ������ �������� �Ի���� ��� �� ���.
SELECT employee_id, first_name, last_name
    , hire_date
    , '2010' - TO_CHAR(hire_date, 'YYYY') --�Ͻ��� ����ȯ ����
    , TO_CHAR(TO_DATE('2010-01-01'), 'YYYY') - TO_CHAR(hire_date, 'YYYY') --�Ͻ��� ����ȯ ����
FROM hr.employees;

--�ֹι�ȣ('800110-1234567') �������� ���� ���
SELECT '800110-1234567'
    , SUBSTR('800110-1234567', 1, 6)
    , TO_DATE(SUBSTR('800110-1234567', 1, 6))
    , TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(TO_DATE(SUBSTR('800110-1234567', 1, 6)), 'YYYY') + 1
FROM dual;



---------------------------------------------
--NVL() �Լ�
--NULL ���� �ٸ� ������ ��ü�ؼ� ��ȯ�ϴ� �Լ�
--NULL ���� ���� �÷��� ���꿡 �����ϴ� ��� ���� ��� ��ü�� NULL�� �ȴ�. NULL ��� ���� ������ ������ ��ü�ؾ��ϴ� ��찡 �ִ�.
--������ �Լ��� NVL2() �Լ��� �ִ�. NULL�϶��� ��ü���� NULL�� �ƴҶ��� ��ü���� ���� ����.


--���ʽ� ��� �׼�
SELECT employee_id, first_name, last_name, salary, commission_pct
    , salary * NVL(commission_pct, 0) bonus
FROM hr.employees;


---------------------------------------------
--NVL2() �Լ�
--NULL ���� �ٸ� ������ ��ü�ؼ� ��ȯ�ϴ� �Լ�. NULL�� �ƴ� ��쿡 ���� ��ü���� �ִ�.
--NULL ���� ���� �÷��� ���꿡 �����ϴ� ��� ���� ��� ��ü�� NULL�� �ȴ�. NULL ��� ���� ������ ������ ��ü�ؾ��ϴ� ��찡 �ִ�.
--������ �Լ��� NVL() �Լ��� �ִ�. NULL�϶��� ��ü���� ����.

--���ʽ� �޴� ���� ���޴� ��� ����
SELECT employee_id, first_name, last_name, salary, commission_pct
    , NVL2(commission_pct, '���ʽ� �޴� ���', '���ʽ� �� �޴� ���')
FROM hr.employees;



----------------------------------------------
--DECODE() �Լ�
--IF ~ ELSE IF ~ ELSE �� ������ �ϴ� �Լ�.
--Ư�� ����(��ġ�ϴ� ��츸 �˻� ����)�� �����ϴ����� ���� �ٸ� ����� ��ȯ�ϴ� �Լ�.
--DECOCE(�÷�, �񱳰�1, �����1, �񱳰�2, �����2,....) �������� ���.
--DECOCE(�÷�, �񱳰�1, �����1)
--DECOCE(�÷�, �񱳰�1, �����1, �񱳰�2, �����2)
--DECOCE(�÷�, �񱳰�1, �����1, �񱳰�2, �����2, �����3)

--�ֹι�ȣ('800110-1234567') �������� ���� ���
-->'����'(1 �Ǵ� 3) �Ǵ� '����'(2 �Ǵ� 4)
SELECT '800110-2234567'
    , SUBSTR('800110-2234567', 8, 1)
    , DECODE(SUBSTR('800110-2234567', 8, 1), '1', '����')
    , DECODE(SUBSTR('800110-2234567', 8, 1), '2', '����')
    , DECODE(SUBSTR('800110-2234567', 8, 1), '1', '����', '2', '����', '3', '����', '4', '����')
FROM dual;


--hr.employees���� Ư�� �μ�(department_id 100)�� ������ �������� NULL�� ����Ѵ�.
SELECT employee_id, first_name, last_name
    , department_id
    , DECODE(department_id, 100, department_id)
    , DECODE(department_id, 100, department_id, 0)
FROM hr.employees;

