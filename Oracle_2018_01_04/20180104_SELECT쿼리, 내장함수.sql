--------------------------------------------------
/*
함수(Function)
-- 내장 함수, 사용자 정의 함수
-- 매개변수에 어떤 값을 전달하면, 내부적인 처리를 진행하고, 결과를 반환하도록 만들어진 코드.
-- 단일행 함수(행당 결과 한 개)와 복수행 함수(여러개의 행을 투입하면 결과 한 개)로 구분된다.
-- 단일행 함수는 문자함수, 숫자함수, 날짜함수, 변환함수, 일반함수로 구분.
*/



----------------------------------------------
--DECODE() 함수
--IF ~ ELSE IF ~ ELSE 문 역할을 하는 함수.
--특정 조건(일치하는 경우만 검사 가능)을 만족하는지에 따라서 다른 결과를 반환하는 함수.
--DECOCE(컬럼, 비교값1, 결과값1, 비교값2, 결과값2,....) 형식으로 사용.
--DECOCE(컬럼, 비교값1, 결과값1)
--DECOCE(컬럼, 비교값1, 결과값1, 비교값2, 결과값2)
--DECOCE(컬럼, 비교값1, 결과값1, 비교값2, 결과값2, 결과값3)
--유사한 기능으로 CASE ~ END 구문이 있다. 특정 조건에서 일치하는 경우만이 아니라, 크다, 작다 등도 검사 가능.

--hr.employees 테이블에서 부서번호(department_id)가 10 -> 'Administration', 20 -> 'Marketing', 30 -> 'Purchasing', 40번 이후는 '.etc' 출력.

SELECT department_id, department_name
FROM hr.departments;
/*
10	Administration
20	Marketing
30	Purchasing
40~110 .etc
*/

SELECT employee_id, first_name, last_name
    , department_id
    , DECODE(department_id
    , 10, 'Administration'
    , 20, 'Marketing'
    , 30, 'Purchasing', '.etc') department_name
FROM hr.employees
ORDER BY department_name;


-----------------------------
--CASE ~ END 구문
--IF ~ ELSE IF ~ ELSE 문 역할을 하는 구문.
--특정 조건을 만족하는지에 따라서 다른 결과를 반환하는 구문.
--기본 형식
/*
--연산자가 =인 경우
CASE 컬럼
    WHEN 값1 THEN 결과1
    WHEN 값2 THEN 결과2
    WHEN 값3 THEN 결과3
    ...
    ELSE 결과
END

--연산자가 =이 아닌 경우
CASE 
    WHEN 조건식1 THEN 결과1
    WHEN 조건식2 THEN 결과2
    WHEN 조건식3 THEN 결과3
    ...
    ELSE 결과
END
*/

 
--hr.employees 테이블에서 부서번호(department_id)가 10 -> 'Administration', 20 -> 'Marketing', 30 -> 'Purchasing', 40번 이후는 '.etc' 출력. CASE ~ END 구문 사용.
SELECT employee_id, first_name, last_name
    , department_id
    , CASE department_id
        WHEN 10 THEN 'Administration'
        WHEN 20 THEN 'Marketing'
        WHEN 30 THEN 'Purchasing'
        ELSE '.etc'
    END department_name
FROM hr.employees
ORDER BY department_name;


--hr.employees 테이블에서 부서번호(department_id)가 10 -> 'Administration', 20 -> 'Marketing', 30 -> 'Purchasing', 40번 이후는 '.etc' 출력. CASE ~ END 구문 사용.
SELECT employee_id, first_name, last_name
    , department_id
    , CASE 
        WHEN department_id=10 THEN 'Administration'
        WHEN department_id=20 THEN 'Marketing'
        WHEN department_id=30 THEN 'Purchasing'
        ELSE '.etc'
    END department_name
FROM hr.employees
ORDER BY department_name;


--hr.employees 테이블에서 급여(salary) 수준에 따라서 'A', 'B', 'C' 등급으로 출력.
--급여가 20000 이상인 경우 'A'
--급여가 10000 이상인 경우 'B'
--급여가 10000 미만인 경우 'C'

SELECT employee_id, first_name, last_name
    , salary
    , CASE 
        WHEN salary>=20000 THEN 'A'
        WHEN salary>=10000 AND salary<20000 THEN 'B'
        ELSE 'C'
    END salaryGrade
FROM hr.employees;


--hr.employees 테이블에서 급여(salary) 수준에 따라서 'A', 'B', 'C' 등급으로 출력.
--급여가 20000 이상(30000 미만)인 경우 'A'
--급여가 10000 이상(20000 미만)인 경우 'B'
--급여가 10000 미만인 경우 'C'
--> = 연산자로 문제 해결 가능. DECODE() 함수 사용 가능.
SELECT TRUNC(20000/10000)
    , TRUNC(29999/10000)
    , TRUNC(10000/10000)
    , TRUNC(19999/10000)
    , TRUNC(9999/10000)
FROM dual;

SELECT employee_id, first_name, last_name
    , salary
    , DECODE(TRUNC(salary/10000)
        , 0, 'C'
        , 1, 'B'
        , 2, 'A') salaryGrade
FROM hr.employees;



--------------------------------------------------
INSA 테이블 관련 문제 풀이
 
 
-- 1. INSA 테이블 전체자료 출력
SELECT * FROM insa;
 
SELECT num AS "NUM", name AS "NAME", ssn, ibsadate, city, tel
    , buseo, jikwi, basicpay, sudang
  FROM insa;  
 
 
-- 2. 일반 사용자 사용자 소유 테이블(객체) 목록 확인
-- user_tables 딕셔너리 사용
-- user_XXX, all_XXX, dba_XXX 딕셔너리
SELECT * FROM user_tables;
 
 
 
-- 3. INSA 테이블 구조 확인
DESC insa;
 
/*
이름       널        유형           
-------- -------- ------------ 
NUM      NOT NULL NUMBER(5)    --직원번호
NAME     NOT NULL VARCHAR2(20)  --이름
SSN      NOT NULL VARCHAR2(14)   --주민번호
IBSADATE NOT NULL DATE           --입사일
TEL               VARCHAR2(15)   --전화번호
CITY              VARCHAR2(10)   --지역
BUSEO    NOT NULL VARCHAR2(15)   --부서
JIKWI    NOT NULL VARCHAR2(15)   --직위
BASICPAY NOT NULL NUMBER(10)     --기본급
SUDANG   NOT NULL NUMBER(10)     --수당
*/
 
-- 4. 이름(name), 주민번호(ssn), 입사일(ibsadate), 전화번호(tel) 출력
SELECT name, ssn, ibsadate, tel 
    FROM insa;
 
 
-- 5. 이름(name), 기본급(basicpay), 수당(sudang), 기본급+수당(->급여) 출력
SELECT name, basicpay, sudang
    , (basicpay+sudang) pay
  FROM insa;
 
 
 
-- 6. 이름(name), 지역명(city), 부서명(buseo) 출력. 별명(Alias) 사용.
SELECT name AS 이름, city AS 지역, buseo AS 부서명
  FROM insa;
SELECT name 이름, city 지역, buseo 부서명
  FROM insa;                                -- 가장 권장하는 방법
SELECT name "이름", city "지역", buseo "부서명"
  FROM insa;
 
 
 
-- 7. 지역명(city)이 '서울'인 직원의 
-- 이름(name), 지역명(city), 부서명(buseo), 직위명(jikwi) 출력. WHERE 구문 추가.
 
SELECT name, city, buseo, jikwi
    FROM insa
    WHERE city='서울';
-- 20
 
 
-- 8.지역명(city)이 '서울'이면서 -->WHERE 구문
-- 기본급이 150만원 이상인 사람 -->WHERE 구문
-- 출력 (name, city, basicpay, ssn)
SELECT name, city, basicpay, ssn
FROM insa
WHERE city = '서울' AND basicpay >= 1500000;
 
 
-- 9.지역명(city)이 '인천'이면서, 기본급이 100만원~200만원인 경우만 출력.
SELECT num, name, city, basicpay, ssn
FROM insa
WHERE city = '인천' AND  basicpay BETWEEN 1000000 AND 2000000;
 
 
-- 10.지역명이 '서울'이거나 부서명이 '개발부'인 자료 출력 (name, city, buseo)
SELECT name, city, buseo
FROM insa
WHERE city = '서울' OR buseo = '개발부';
 
 
-- 11.지역명(city)이 '서울', '경기'인 사람만 출력 (name, city, buseo). IN 연산자 사용.
SELECT name, city, buseo
FROM insa
WHERE city IN ('서울', '경기');
 
-- 12.부서명(buseo)이 '개발부', '영업부'인 사람만 출력. IN 연산자 사용.
SELECT num, name, city, buseo
FROM insa
WHERE buseo IN ('개발부', '영업부');
 
 
-- 13. 급여(basicpay + sudang)가 250만원 이상인 사람. --> WHERE 구문
-- (name, basicpay, sudang, basicpay+sudang)
SELECT name, basicpay, sudang, basicpay+sudang
FROM insa
WHERE (basicpay+sudang) >= 2500000;
 
 
-- 14. 주민번호(ssn)를 기준으로 남자 직원만 출력. (이름, 지역명, 성별, 주민번호). 
-- SUBSTR() 함수 이용.
SELECT 
    name 이름
    , city 지역명
    , DECODE(SUBSTR(ssn, 8, 1), '1' ,'남자', '2', '여자', '3', '남자', '4', '여자') 성별
    , ssn 주민번호
FROM insa
WHERE SUBSTR(ssn, 8, 1) = 1 or SUBSTR(ssn, 8, 1) = 3 ;
 
-- 15. 주민번호(ssn)를 기준으로 80년대(1980~1989) 태어난 사람만 출력. 
-- (이름, 지역명, 성별, 주민번호). 
-- SUBSTR() 함수 이용.
SELECT 
    name 이름
    , city 지역명
    , DECODE(SUBSTR(ssn, 8, 1), '1' ,'남자', '2', '여자', '3', '남자', '4', '여자') 성별
    , ssn 주민번호
FROM insa
WHERE AND TO_NUMBER(SUBSTR(ssn, 1, 2)) + 1900 BETWEEN 1980 AND 1989 ;
 
-- 16. 지역명이 '서울' 중에서 70년대(1970~1979) 태어난 직원 출력. SUBSTR() 함수 이용.  
-- (이름, 지역명, 성별, 주민번호). 
SELECT 
    name 이름
    , city 지역명
    , DECODE(SUBSTR(ssn, 8, 1), '1' ,'남자', '2', '여자', '3', '남자', '4', '여자') 성별
    , ssn 주민번호
FROM insa
WHERE city = '서울' 
    AND TO_NUMBER(SUBSTR(ssn, 1, 2)) + 1900 BETWEEN 1970 AND 1979 ;
 
 
-- 17. 지역명(city)이 '서울' 중에서 70년대(1970~1979) 태어난 남자 직원만 출력. SUBSTR() 함수 이용.
-- (이름, 지역명, 성별, 주민번호). 
SELECT 
    name 이름
    , city 지역명
    , DECODE(SUBSTR(ssn, 8, 1), '1' ,'남자', '2', '여자', '3', '남자', '4', '여자') 성별
    , ssn 주민번호
FROM insa
WHERE city = '서울' 
    AND TO_NUMBER(SUBSTR(ssn, 1, 2)) + 1900 BETWEEN 1970 AND 1979 
    AND SUBSTR(ssn, 8, 1) = 1 or SUBSTR(ssn, 8, 1) = 3;
 
    
 
-- 18. 지역명(city)이 '서울' 이면서 김씨만 출력(성씨가 1자라는 가정). (이름, 지역명). 
-- SUBSTR() 함수 이용.
SELECT 
    name 이름
    , city 지역명
FROM insa
WHERE city = '서울' 
    AND SUBSTR(name, 1, 1) = '김';
 
 
 
-- 19. 2000년도에 입사한 사람 출력. (이름, 지역명, 입사일). 
-- SUBSTR() 또는 TO_CHAR() 함수 이용.
SELECT 
    name 이름
    , city 지역명
    ,ibsadate 입사일
FROM insa
WHERE TO_CHAR(ibsadate, 'YYYY') = 2000;
 
 
-- 20. 2000년 10월에 입사한 사람 출력. (이름, 지역명, 입사일). 
SELECT 
    name 이름
    , city 지역명
    ,ibsadate 입사일
FROM insa
WHERE TO_CHAR(ibsadate, 'YYYY-MM') = '2000-10';
 
 
-- 21. 주민번호(ssn)를 기준으로 직원의 나이 구하기. (이름, 성별, 주민번호, 나이)
-- 나이 계산은 (올해 년도 - 태어난 년도 + 1) 로 계산.
SELECT TO_CHAR(SYSDATE, 'YYYY') AS "현재년도"
    ,TO_CHAR(TO_DATE(SUBSTR(ssn, 1, 6)), 'YYYY') AS "기준년도"
    ,TO_CHAR(SYSDATE, 'YYYY') -
    ,TO_CHAR(TO_DATE(SUBSTR(ssn, 1, 6)), 'YYYY') + 1 AS "계산결과"
FROM insa;
 
 
 
 
-- 22. 주민번호(ssn) 기준으로 현재 나이대가 30대인 사람만 출력. (이름, 성별, 주민번호, 나이)
-- 나이 계산은 (올해 년도 - 태어난 년도 + 1) 로 계산.
SELECT 
    name 이름
    , DECODE(SUBSTR(ssn, 8, 1), '1' ,'남자', '2', '여자', '3', '남자', '4', '여자') 성별
    , ssn 주민번호
    , TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(TO_DATE(SUBSTR(ssn, 1, 6)), 'YYYY') + 1 나이
FROM insa
WHERE TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(TO_DATE(SUBSTR(ssn, 1, 6)), 'YYYY') + 1 BETWEEN 30 AND 39;
 
 
 
 
-- 23. 주민번호(ssn) 기준으로 5월달생만 출력. SUBSTR() 함수 이용. (이름, 성별, 주민번호, 나이)
SELECT 
    name 이름
    , DECODE(SUBSTR(ssn, 8, 1), '1' ,'남자', '2', '여자', '3', '남자', '4', '여자') 성별
    , ssn 주민번호
    , TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(TO_DATE(SUBSTR(ssn, 1, 6)), 'YYYY') + 1 나이
FROM insa
WHERE SUBSTR(ssn, 3, 2) = '05';
 
 
-- 24. 주민번호(ssn) 기준으로 5월달생만 출력. (이름, 성별, 주민번호, 나이)
-- 주민번호의 생년월일 부분만을 추출->날짜형 자료로 변환->월 부분만 추출.
SELECT 
    name 이름
    , DECODE(SUBSTR(ssn, 8, 1), '1' ,'남자', '2', '여자', '3', '남자', '4', '여자') 성별
    , TO_CHAR(TO_DATE(SUBSTR(ssn, 1, 6)), 'YYYYMM') 주민번호
    , TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(TO_DATE(SUBSTR(ssn, 1, 6)), 'YYYY') + 1 나이
FROM insa
WHERE TO_CHAR(TO_DATE(SUBSTR(ssn, 1, 6)), 'MM') = '05';
 
 
-- 25. 지역명(city) 오름차순으로 정렬하고, 지역명(city)이 같으면 기본급(basicpay) 내림차순
 
SELECT name, city, buseo, jikwi, basicpay
FROM insa
ORDER BY city ASC, basicpay DESC;
 
SELECT name, city, buseo, jikwi, basicpay
FROM insa
ORDER BY city, basicpay DESC;
 
 
 
-- 26. 지역명(city)이 '서울' 중에서 기본급+수당(->급여) 내림차순으로 정렬. 
-- (이름, 지역명, 기본급+수당->급여)
SELECT name 이름
    , city 지역명
    , basicpay+sudang 급여
FROM insa
WHERE city = '서울'
ORDER BY 급여 DESC;
 
 
 
-- 27. 여자 중 부서(buseo) 오름차순으로 정렬하고, 부서가 같으면 기본급(basicpay) 내림차순 정렬. 
-- (이름, 주민번호, 부서, 기본급)
 
SELECT name 이름
    , ssn 주민번호
    , buseo 부서
    , basicpay 기본급
FROM insa
WHERE SUBSTR(ssn, 8, 1) = 2
ORDER BY 부서 ASC, 기본급 DESC;
 
 
 
-- 28. 남자 중에서 나이를 기준으로 오름차순 정렬해서 출력. (이름, 성별, 주민번호, 나이)
-- 나이 계산은 (올해 년도 - 태어난 년도 + 1) 로 계산.
SELECT name 이름
    , DECODE(SUBSTR(ssn, 8, 1), '1' ,'남자', '2', '여자', '3', '남자', '4', '여자') 성별
    , ssn 주민번호
    , TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(TO_DATE(SUBSTR(ssn, 1, 6)), 'YYYY') + 1 나이
FROM insa
WHERE SUBSTR(ssn, 8, 1) = 1 or SUBSTR(ssn, 8, 1) = 3;
ORDER BY 나이 ASC;
 
 
 
-- 29. 지역명(city)이 '서울' 중에서 입사일(ibsaDate)이 빠른 사람을 먼저 출력.
SELECT num 직원번호 
    , name 이름
    , ibsadate 입사일
FROM insa
WHERE city = '서울' 
ORDER BY 입사일 ASC;
 
 
 
-- 30. 성씨가 김씨가 아닌 사람 출력. (이름, 지역, 기본급). 
-- LIKE 연산자 또는 SUBSTR() 함수 이용.
/*
NOT LIKE
!=  <>
*/
SELECT num 직원번호 
    , name 이름
    , city 지역
    , basicpay
FROM insa
WHERE name NOT LIKE '김%';
 
 
/*
31. 지역명(city)이 '서울', '부산', '대구' 이면서 
전화번호(tel)에 5 또는 7이 포함된 자료 출력하되 
부서명(buseo)의 마지막 '부'는 출력되지 않도록함. 
(이름, 지역명, 부서명, 전화번호)
RTRIM(buseo, '부')
*/
SELECT  name 이름
    , city 지역명
    , RTRIM(buseo, '부') 부서명
    , tel 전화번호
FROM insa
WHERE (city IN ('서울', '부산', '대구'))  AND
    (INSTR(tel, '5', 1, 1) > 0  OR INSTR(tel, '7', 1, 1) > 0);
    
 
 
-- 32. 전화번호(tel)가 있으면 '-'을 제거하고 출력하고, 없으면 '전화번호없음'을 출력
 
SELECT name 이름
, tel 전화번호
, DECODE(tel , null, '전화번호 없음'
      , SUBSTR(tel, 1, 3) || SUBSTR(tel, 5, 4) || SUBSTR(tel, 10, 4)) 전화번호
FROM insa;
 
 
SELECT name 이름
, tel 전화번호
, DECODE(tel, null, '전화번호 없음'
      , REPLACE(tel, '-')) 전화번호
FROM insa;  

