/*

SELECT 쿼리

- 기본 형식
SELECT select_list FROM source_list;
- SELECT 쿼리는 특정 테이블에 저장된 자료를 조회하는 쿼리.
- SELECT 구문은 출력 대상을 지정하는 부분. 예를 들어, 컬럼명 지정. 이름, 전화번호 등.
- FROM 구문은 자료가 저장되어 있는 특정 테이블을 지정한다. 예를 들어, hr.employees
- SELECT ~ FROM ~ 키워드는 생략 불가.

*/


--중복된 값을 제거하고 출력하기
--DISTINCT 키워드 필요
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


--연결 연산자(||)로 컬럼을 붙여서 출력하기
--두 개 이상의 컬럼이나, 표현식을 묶어서 하나의 컬럼으로 처리할 때 사용.
--주의) 별칭 사용 권장

SELECT first_name || ' ' || last_name full_name
FROM hr.employees;

SELECT first_name || ', ' || last_name full_name
FROM hr.employees;


--연습문제) hr.employees 테이블을 조회하여 모든 사원의 이름(first_name, last_name)과 급여(salary)를 아래와 같은 형태로 출력.
--출력예) Ellen, Abel's salary is $900
SELECT first_name, last_name, salary
FROM hr.employees;

SELECT first_name || ', ' || last_name || '''s salary is $' || salary "Name and Sal"
FROM hr.employees;



------------------------------------------------------
/*

WHERE 구문
--특정 조건을 지정하고, 조건을 만족하는 경우만 출력하도록 하는 구문.
--SELECT select_list FROM source_list WHERE 조건식;
--조건식은 참, 거짓 결과를 낼 수 있는 수식.
--관계연산자, 논리 연산자 등을 이용해서 조건식 작성.
--주의) 자료형을 정확하게 이해해야 정확한 결과를 얻을 수 있다.


오라클에서 제공하는 자료형
--숫자, 문자, 날짜 등의 자료를 자료형으로 구분한다.
--숫자는 NUMBER 키워드 사용. 정수, 실수 모두 취급 가능.
--문자는 고정길이 문자(CHAR)와 가변길이 문자(VARCHAR2)로 구분. 4000byte까지만 저장 가능.
--날짜는 DATE 키워드 사용. 시간 정보도 포함되어 있다. 기본값은 날짜만  출력된다.
--숫자 리터럴은 '(작은 따옴표) 없이 표기하지만, 문자 리터럴, 날짜 리터럴는 '(작은 따옴표)와 함께 표기해야 한다.
--날짜 리터럴은 '날짜형식'에 맞춰서 작성. 예를 들어, '2017-12-28' 또는 '20171228'


오라클에 사용하는 관계 연산자
--두 개의 항목을 비교해서 참, 거짓을 판단하는 연산자.
-- =(같음 비교), !=(같지않음 비교), >, <, >=, <=, ANY, SOME, ALL
--SELECT select_list FROM source_list WHERE 컬럼  관계연산자  비교값;



오라클에 사용하는 논리 연산자
--두 개 이상의 조건식을 비교해서 참, 거짓을 판단하는 연산자.
--AND(논리곱), OR(논리합), NOT(논리부정)
--SELECT select_list FROM source_list WHERE 조건식1 논리연산자 조건식2;

*/

-- =(같음 비교) 연산자를 이용해서 출력하기
-- 문자, 날짜 자료형을 취급하는 경우 '(작은 따옴표) 사용. 대소문자 구분한다.
-- 숫자 자료형을 취급하는 경우 '(작은 따옴표) 생략.

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


-- !=(같지않음 비교) 연산자를 이용해서 출력하기
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE first_name != 'Steven';
--105


-- >, <, >=, <= 연산자를 이용해서 출력하기
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


--연습문제) hr.employees 테이블에서 
--급여(salary)가 20000  이상이면서, 
--부서번호(department_id)가 90인 경우 출력.


---------------------------------------
/*

날짜 자료에 대한 형변환
-- TO_CHAR() 내장함수 사용
-- 외부에서 자료를 전달하면, 내부적으로 연산 수행 후, 결과를 반환한다.
-- TO_CHAR(날짜자료, '포맷')
-- 포맷은 년도(YYYY), 월(MM), 일(DD), 요일(DAY), 시간(HH, HH24), 분(MI), 초(SS)를 다루는 포맷이 존재한다.
-- 예를 들어, TO_CHAR(날짜자료, 'YYYY-MM-DD')

*/

-- hr.employees 테이블에서 입사일(hire_date) 정보 중에서 년도가 '2005'인 경우만 출력.
SELECT employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE TO_CHAR(hire_date, 'YYYY') = '2005';

-- 시간 정보 출력하기
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

--연습문제) 날짜 출력시 '23-JAN-76' 형태로 출력합니다. 


--연습문제) hr.employees 테이블에서 입사일(hire_date) 정보 중에서 12월 입사자만 출력.


--연습문제) hr.employees 테이블에서 입사일(hire_date) 정보 중에서 특정년도(2005), 특정월(6) 입사자만 출력.


--연습문제) hr.employees 테이블에서 입사일(hire_date) 정보 중에서 1, 2, 3월 입사자만 출력.


