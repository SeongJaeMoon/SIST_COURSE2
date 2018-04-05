--------------------------------------------------
/*
함수(Function)
-- 내장 함수, 사용자 정의 함수
-- 매개변수에 어떤 값을 전달하면, 내부적인 처리를 진행하고, 결과를 반환하도록 만들어진 코드.
-- 단일행 함수(행당 결과 한 개)와 복수행 함수(여러개의 행을 투입하면 결과 한 개)로 구분된다.
-- 단일행 함수는 문자함수, 숫자함수, 날짜함수, 변환함수, 일반함수로 구분.
*/


-----------------------------
--SUBSTR() 함수
--문자열의 일부(시작위치, 글자수)만 추출해서 반환하는 함수.
--주의) 시작 위치는 1부터 시작한다.
--주의) 시작 위치에 -값를 주면 오른쪽 끝에서부터 출발한다.
--유사한 함수로 SUBSTRB() 함수가 있다. 바이트수 기준으로 추출한다.
SELECT 
    SUBSTR('ABCDE', 1, 2)
    ,SUBSTR('ABCDE', 2, 2)
    ,SUBSTR('ABCDE', 3, 2)
    ,SUBSTR('ABCDE', 4, 2)
    ,SUBSTR('ABCDE', -1, 2)
FROM dual;

--hr.employees 테이블에서 전화번호(phone_number)가 '515.XXX.XXXX'으로 시작하는 경우 출력. SUBSTR() 함수 사용.
SELECT employee_id, first_name, last_name, phone_number
FROM hr.employees
WHERE SUBSTR(phone_number, 1, 3) = '515';
--21


--hr.employees 테이블에서 전화번호(phone_number)가 'XXX.XXX.4567'로 끝나는 경우 출력. SUBSTR() 함수 사용.
SELECT employee_id, first_name, last_name, phone_number
FROM hr.employees
WHERE SUBSTR(phone_number, -4, 4) = '4567';
--3


-----------------------------
--SUBSTRB() 함수
--문자열의 일부(시작위치, 바이트수)만 추출해서 반환하는 함수.
--주의) 영숫자를 대상으로 하는 경우 SUBSTR() 함수와 결과가 동일하다.


-----------------------------
--INSTR() 함수
--대상 문자열에서 특정 문자열이 존재하는지 여부를 확인하고, 위치를 반환하는 함수.
--INSTR(대상문자열, 찾는문자열, 시작위치, 특정번째) 형식으로 사용. 특정번째는 생략 가능.
--검색 결과가 존재하지 않는 경우 위치값 0 반환한다.
SELECT 'A-B-C-D'
    ,INSTR('A-B-C-D', '-', 1)
    ,INSTR('A-B-C-D', '-', 1, 2)
    ,INSTR('A-B-C-D', '*', 1)
FROM dual;

--hr.employees 테이블에서 전화번호(phone_number)에 '123'이 포함된 경우 출력. INSTR() 함수 사용.
SELECT employee_id, first_name, last_name, phone_number
FROM hr.employees
WHERE INSTR(phone_number, '123', 1) > 0;
--16


------------------------------
--LPAD() 함수
--특정 문자로 빈 공간을 채우는 함수. 채우는 위치는 LEFT.
--LPAD(대상문자열, 전체자릿수, 채울문자열)
--유사한 함수로 RPAD() 함수가 있다. 채우는 위치는 RIGHT.

SELECT employee_id
    , first_name
    , LPAD(first_name, 11, '-')
    , RPAD(first_name, 11, '-')
    , RPAD(SUBSTR(phone_number, 1, 8), 12, '*') phone_number
FROM hr.employees;


------------------------------
--RPAD() 함수
--특정 문자로 빈 공간을 채우는 함수. 채우는 위치는 RIGHT.
--RPAD(대상문자열, 전체자릿수, 채울문자열)
--유사한 함수로 LPAD() 함수가 있다. 채우는 위치는 LEFT.


------------------------------
--LTRIM() 함수
--특정 문자의 빈 공간(특정 문자)을 제거하는 함수. 제거하는 위치는 LEFT.
--LTRIM(대상문자열, 특정문자열) 형식으로 사용. 특정문자열 생략 가능.
--유사한 함수로 RTRIM() 함수가 있다. 제거하는 위치는 RIGHT.

SELECT '[  TEST  ]'
        , '[' || LTRIM('   TEST    ') || ']' LTRIM_
        , '[' || RTRIM('   TEST    ') || ']' RTRIM_
FROM dual;

SELECT 'A009'
        , LTRIM('A009', 'A') ltrim_
        , CONCAT('A',LPAD(TO_NUMBER(LTRIM('A009', 'A')) + 1, 3, '0')) newNum
FROM dual;


------------------------------
--RTRIM() 함수
--특정 문자의 빈 공간(특정 문자)을 제거하는 함수. 제거하는 위치는 RIGHT;
--RTRIM(대상문자열, 특정문자열) 형식으로 사용. 특정문자열 생략 가능.
--유사한 함수로 LTRIM() 함수가 있다. 제거하는 위치는 LEFT.



--------------------------------
--REPLACE() 함수
--대상 문자열에서 특정 문자열을 다른 문자열로 치환하는 함수.
--REPLACE(대상문자열, 찾는문자열, 치환문자열) 형식으로 사용.
--주의) 찾는 문자열이 없는 경우 치환이 일어나지 않는다.

SELECT employee_id, first_name, last_name
    , phone_number
    , REPLACE(phone_number, '.', '-') phone_number2
FROM hr.employees;




---------------------------------------------
--ROUND() 함수
--반올림 처리 함수
--ROUND(대상숫자, 자릿수) 형식으로 사용. 자릿수 지정 생략 가능.
--유사한 함수로 TRUNC()함수가 있다. 절삭 기능.
SELECT 1234.567
    , ROUND(1234.567)
    , ROUND(1234.567, 1)
    , ROUND(1234.567, 2)
    , ROUND(1234.567, -2)
FROM dual;


---------------------------------------------
--TRUNC() 함수
--절삭 처리 함수
--TRUNC(대상숫자, 자릿수) 형식으로 사용. 자릿수 지정 생략 가능.
--유사한 함수로 ROUND()함수가 있다. 반올림 기능.
--몫 연산에도 사용 가능.
SELECT 1234.567
    , TRUNC(1234.567)
    , TRUNC(1234.567, 1)
    , TRUNC(1234.567, 2)
    , TRUNC(1234.567, -2)
FROM dual;


-----------------------
--MOD() 함수
--나머지 결과 반환하는 함수
--유사한 함수로 TRUNC() 함수. 몫 연산 결과 반환.

SELECT  5/3
    , TRUNC(5/3, 0)
    , MOD(5, 3)
FROM dual;

-------------------------------
--SYSDATE 함수
--시스템의 오늘 날짜(시간)를 반환하는 함수
--주의) 매개변수 전달값이 없기 때문에 ()를 표기하지 않는다.
--날짜 자료를 가지고 산술 연산 가능. 날짜 단위로 계산된다.
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
--MONTHS_BETWEEN() 함수
--날짜 자료를 가지고 산술 연산(빼기 연산) 가능. 월(개월) 단위로 계산된다.
--유사한 함수로 ADD_MONTHS() 함수가 있다. 더하기 연산.

SELECT employee_id, first_name, last_name, hire_date
    , TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date))
FROM hr.employees;


-------------------------------
--ADD_MONTHS() 함수
--날짜 자료를 가지고 산술 연산(더하기 연산) 가능. 월(개월) 단위로 계산된다.
--유사한 함수로 MONTHS_BETWEEN() 함수가 있다. 빼기 연산.


--날짜 출력 서식 변경
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';

SELECT employee_id, first_name, last_name, hire_date
FROM hr.employees;



------------------------------------------
--날짜 계산시 주의사항
SELECT
    MONTHS_BETWEEN(SYSDATE, '2018-01-02')
    ,MONTHS_BETWEEN('2018-01-03', '2018-01-02')
    , SYSDATE - TO_DATE('2018-01-02')
    , TO_DATE('2018-01-03') - TO_DATE('2018-01-02')
    , TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD')) - TO_DATE('2018-01-02')
FROM dual;



------------------------------------------
--TO_CHAR() 함수
--날짜, 숫자 자료를 문자 자료로 형변환하는 함수.
--서식 지정 내용에 따라서 여러가지 형태의 문자열로 변환할 수 있다.
--날짜 서식은 YYYY, MM, DD, DAY, HH24, MI, SS 등이 있다.
--숫자 서식은 9, 0, .(dot), ,(comma) 등의 서식 사용.

SELECT SYSDATE
    , TO_CHAR(SYSDATE, 'YYYY-MM-DD')
    , TO_CHAR(SYSDATE, 'YYYY')
    , TO_CHAR(SYSDATE, 'MM')
    , TO_CHAR(SYSDATE, 'DD')
FROM dual;    

--hr.employees 테이블에서 입사일(hire_date) 정보에서 12월달 입사자만 출력.
SELECT employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE TO_CHAR(hire_date, 'MM') = '12';
--7
SELECT employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE TO_CHAR(hire_date, 'MM') = 12; --암시적 형변환 지원
--7


------------------------
--년도 출력시 2자리 사용하는 경우
--YY, RR
SELECT '2060-01-01'
        , '1905-01-01'
        , TO_CHAR(TO_DATE('2060-01-01'), 'YY/MM/DD')
        , TO_CHAR(TO_DATE('1905-01-01'), 'YY/MM/DD')
        , TO_DATE(TO_CHAR(TO_DATE('1905-01-01'), 'YY/MM/DD'))
        , TO_DATE(TO_CHAR(TO_DATE('1905-01-01'), 'YYYY/MM/DD'))
FROM dual;


----------------------------------
--숫자 출력시 서식 지정
SELECT 12345.67
    , TO_CHAR(12345.67, '99999')
    , TO_CHAR(12345.67, '99999.99')
    , TO_CHAR(12345.67, '99,999.99')
    , CONCAT('A',LTRIM(TO_CHAR(1, '0000'))) newNum
FROM dual;



------------------------------------
--TO_NUMBER() 함수
--(숫자 형태의)문자 자료를 숫자 자료로 형변환하는 함수

SELECT
    '12' + '34'  --암시적 형변환 지원
    , 12 + 34
    ,'12' - '34'  --암시적 형변환 지원
    , 12 - 34
    , TO_NUMBER('12') + TO_NUMBER('34')
    , TO_NUMBER('12') - TO_NUMBER('34')
FROM dual;


------------------------------------
--TO_DATE() 함수
--(날짜 형태의)문자 자료를 날짜 자료로 형변환하는 함수
SELECT TO_DATE('900101')
    , TO_DATE('19900101')
    , TO_DATE('1990-01-01')
    , TO_DATE('1990/01/01')
    , TO_CHAR(TO_DATE('050101'), 'YYYY-MM-DD')
FROM dual;

--hr.employees 테이블에서 입사일(hire_date) 정보를 기준으로 입사년차 계산 및 출력.
SELECT employee_id, first_name, last_name
    , hire_date
    , '2010' - TO_CHAR(hire_date, 'YYYY') --암시적 형변환 지원
    , TO_CHAR(TO_DATE('2010-01-01'), 'YYYY') - TO_CHAR(hire_date, 'YYYY') --암시적 형변환 지원
FROM hr.employees;

--주민번호('800110-1234567') 기준으로 나이 계산
SELECT '800110-1234567'
    , SUBSTR('800110-1234567', 1, 6)
    , TO_DATE(SUBSTR('800110-1234567', 1, 6))
    , TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(TO_DATE(SUBSTR('800110-1234567', 1, 6)), 'YYYY') + 1
FROM dual;



---------------------------------------------
--NVL() 함수
--NULL 값을 다른 값으로 대체해서 반환하는 함수
--NULL 값을 가진 컬럼을 연산에 참여하는 경우 최종 결과 전체가 NULL이 된다. NULL 대신 연산 가능한 값으로 대체해야하는 경우가 있다.
--유사한 함수로 NVL2() 함수가 있다. NULL일때의 대체값과 NULL이 아닐때의 대체값이 별도 존재.


--보너스 계산 액션
SELECT employee_id, first_name, last_name, salary, commission_pct
    , salary * NVL(commission_pct, 0) bonus
FROM hr.employees;


---------------------------------------------
--NVL2() 함수
--NULL 값을 다른 값으로 대체해서 반환하는 함수. NULL이 아닌 경우에 대한 대체값도 있다.
--NULL 값을 가진 컬럼을 연산에 참여하는 경우 최종 결과 전체가 NULL이 된다. NULL 대신 연산 가능한 값으로 대체해야하는 경우가 있다.
--유사한 함수로 NVL() 함수가 있다. NULL일때의 대체값만 존재.

--보너스 받는 경우와 못받는 경우 구분
SELECT employee_id, first_name, last_name, salary, commission_pct
    , NVL2(commission_pct, '보너스 받는 경우', '보너스 못 받는 경우')
FROM hr.employees;



----------------------------------------------
--DECODE() 함수
--IF ~ ELSE IF ~ ELSE 문 역할을 하는 함수.
--특정 조건(일치하는 경우만 검사 가능)을 만족하는지에 따라서 다른 결과를 반환하는 함수.
--DECOCE(컬럼, 비교값1, 결과값1, 비교값2, 결과값2,....) 형식으로 사용.
--DECOCE(컬럼, 비교값1, 결과값1)
--DECOCE(컬럼, 비교값1, 결과값1, 비교값2, 결과값2)
--DECOCE(컬럼, 비교값1, 결과값1, 비교값2, 결과값2, 결과값3)

--주민번호('800110-1234567') 기준으로 성별 출력
-->'남자'(1 또는 3) 또는 '여자'(2 또는 4)
SELECT '800110-2234567'
    , SUBSTR('800110-2234567', 8, 1)
    , DECODE(SUBSTR('800110-2234567', 8, 1), '1', '남자')
    , DECODE(SUBSTR('800110-2234567', 8, 1), '2', '여자')
    , DECODE(SUBSTR('800110-2234567', 8, 1), '1', '남자', '2', '여자', '3', '남자', '4', '여자')
FROM dual;


--hr.employees에서 특정 부서(department_id 100)를 제외한 나머지를 NULL로 출력한다.
SELECT employee_id, first_name, last_name
    , department_id
    , DECODE(department_id, 100, department_id)
    , DECODE(department_id, 100, department_id, 0)
FROM hr.employees;

