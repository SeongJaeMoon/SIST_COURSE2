--------------------------------------------------
/*
함수(Function)
-- 내장 함수, 사용자 정의 함수
-- 매개변수에 어떤 값을 전달하면, 내부적인 처리를 진행하고, 결과를 반환하도록 만들어진 코드.
-- 단일행 함수(행당 결과 한 개)와 복수행 함수(여러개의 행을 투입하면 결과 한 개)로 구분된다.
-- 단일행 함수는 문자함수, 숫자함수, 날짜함수, 변환함수, 일반함수로 구분.
*/



-------------------------------------------------------
--정규식 함수
--정규식 표현을 이용해서 검색, 치환 등을 진행하는 함수.
--REGEXP_LIKE(), REGEXP_REPLACE(), REGEXP_SUBSTR(), REGEXP_COUNT()


-------------------------------------
--REGEXP_LIKE() 함수
--특정 패턴(정규표현식)과 매칭되는 결과를 반환하는 함수


-------------------------------------
--hr.employees 테이블에서 first_name에 대문자가 두 글자인 경우 출력.
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE REGEXP_LIKE(first_name, '[A-Z]{2}');


--hr.employees 테이블에서 부서번호(department_id)가 3자리로 구성된 경우를 출력.
SELECT employee_id, first_name, last_name, department_id
FROM hr.employees
WHERE REGEXP_LIKE(department_id, '[0-9]{3}');



----------------------------------
--hr.employees 테이블에서  first_name이 'A', 'B', 'C', 'M'를 포함하는 경우만 출력.
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE REGEXP_LIKE(first_name, '[A-C, M]');
--23


--hr.employees 테이블에서  first_name이 'A', 'B', 'C', 'M'로 시작하는 경우만 출력.
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE REGEXP_LIKE(first_name, '^[A-C, M]');
--22


--hr.employees 테이블에서 first_name이 'M'으로 시작하는 경우 출력
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE REGEXP_LIKE(first_name, '^M');
--6

--hr.employees 테이블에서 first_name이 'Ma' 또는 'Mo'로 시작하는 경우 출력
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE REGEXP_LIKE(first_name, '^M(a|o)');
--4


--hr.employees 테이블에서  first_name이 'a', 'b', 'c'로 끝나는 경우만 출력.
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE REGEXP_LIKE(first_name, '[a-c]$');
--16


--hr.employees 테이블에서  first_name이 'son'로 끝나는 경우만 출력.
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE REGEXP_LIKE(first_name, 'son$');


------------------------------
--hr.employees 테이블에서  first_name이 'A', 'B', 'C'를 제외한 나머지 문자로 시작하는 경우만 출력.
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE REGEXP_LIKE(first_name, '^[^A-C]');


---------------------------
--hr.employees 테이블에서  first_name이 'n'으로 끝나는 경우를 출력.
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE REGEXP_LIKE(first_name, 'n$');
--20

--hr.employees 테이블에서  first_name이 'n'으로 끝나지 않는 경우를 출력.
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE NOT REGEXP_LIKE(first_name, 'n$');
--87


--------------------------------
--hr.employees 테이블에서 전화번호(phone_number)가 XXX.XXX.XXXX 형태인 경우 출력
SELECT employee_id, first_name, last_name, phone_number
FROM hr.employees
WHERE REGEXP_LIKE(phone_number, '[0-9]{3}.[0-9]{3}.[0-9]{4}');
--72

--hr.employees 테이블에서 전화번호(phone_number)가 XXX.XXX.1234 형태인 경우 출력
SELECT employee_id, first_name, last_name, phone_number
FROM hr.employees
WHERE REGEXP_LIKE(phone_number, '[0-9]{3}.[0-9]{3}.1234');
--2


-------------------------------------
--REGEXP_REPLACE() 함수
--특정 패턴(정규표현식)과 매칭되는 결과를 치환하는 함수

--hr.employees 테이블에서 전화번호(phone_number)의 숫자를 '*'문자로 치환.
SELECT employee_id, first_name, last_name
, phone_number
, REGEXP_REPLACE(phone_number, '[0-9]', '*')
FROM hr.employees;

--hr.employees 테이블에서 전화번호(phone_number)의 숫자를 '*'문자로 치환.
SELECT employee_id, first_name, last_name
, phone_number
, REGEXP_REPLACE(phone_number, '[[:digit:]]', '*')
FROM hr.employees;

--hr.employees 테이블에서 전화번호(phone_number)의 '.'를 제거한 상태로 출력.
SELECT employee_id, first_name, last_name
, phone_number
, REGEXP_REPLACE(phone_number, '\.', '')
FROM hr.employees;


--hr.employees 테이블에서 전화번호(phone_number)의 첫 번째 '.'를 ')'로 변경한 상태로 출력.
SELECT employee_id, first_name, last_name
, phone_number
, REGEXP_REPLACE(phone_number, '\.', ')', 1, 1)
FROM hr.employees;


--hr.employees 테이블에서 이름(first_name)에서 공백 문자 제거한 상태로 출력.
--예를 들어, 'Jose Manuel'를 'JoseManuel' 상태로 출력.
SELECT employee_id, first_name, last_name
, REGEXP_REPLACE(first_name, '( ){1,}', '')
FROM hr.employees;


-------------------------------------
--REGEXP_SUBSTR() 함수
--특정 패턴(정규표현식)과 매칭되는 결과에서 부분 문자열을 반환하는 함수

SELECT employee_id, first_name, last_name, job_id
, REGEXP_SUBSTR(job_id, '[A-C]')
, REGEXP_SUBSTR(job_id, 'MAN')
FROM hr.employees;


SELECT employee_id, first_name, last_name, job_id
FROM hr.employees
WHERE REGEXP_SUBSTR(job_id, 'MAN') = 'MAN';



----------------------------------------------
--복수행 함수
--여러개의 행을 투입해서 한 개의 결과를 반환하는 함수
--주의) NULL 값을 가진 자료는 복수행 함수 연산시 제외된다. 예를 들어, SUM() 함수 사용시 NULL 값이 들어오면 자동으로 제외된다.
--COUNT(), SUM(), AVG(), MAX(), MIN() 등이 있다.
--주의) 함수 사용시 단일행 함수, 일반 컬럼과 복수행 함수를 혼용할 수 없다.

-------------------------------------------
--COUNT() 함수
--투입된 행의 갯수 반환하는 함수

SELECT COUNT(employee_id) --107
FROM hr.employees;
--NULL값을 허용하지 않는 컬럼(PK)을 대상으로 카운팅 액션을 하는 것이 좋다.

SELECT COUNT(department_id) --106
FROM hr.employees;
--NULL값이 있는 행은 카운팅 액션에서 제외된다.

SELECT COUNT(*) --107
FROM hr.employees;
-- * 사용시 NULL값을 카운팅 액션에 포함시킨다.

--hr.employees 테이블에서 부서번호(department_id)가 100인 사원의 수를 출력.
SELECT COUNT(*) --6
FROM hr.employees
WHERE department_id = 100;


----------------------------
--SUM() 함수
--투입된 행의 값(숫자 자료형)들을 모두 합산한 결과 반환.

--hr.employees 테이블에서 모든 직원의 급여 합 출력.
SELECT SUM(salary) --691416
FROM hr.employees;


----------------------------
--AVG() 함수
--투입된 행의 값(숫자 자료형)들의 평균 결과 반환.
--주의) NULL 값은 제외되기 때문에 평균 계산 결과가 다르게 나올 수 있다.
SELECT SUM(salary)/COUNT(*) --????
FROM hr.employees;

SELECT AVG(salary) --????
FROM hr.employees;

--NULL값을 가진 자료를 평균 계산이 가능한 숫자로 변환. NVL() 함수.
SELECT AVG(NVL(salary, 0)) --????
FROM hr.employees;


--------------------------
--MAX(), MIN() 함수
--최대값, 최소값을 반환하는 함수

--hr.employees 테이블에서 employee_id를 번호를 자동으로 +1 증가하는 액션.
SELECT MAX(employee_id)
, MAX(employee_id) + 1 
FROM hr.employees;

--NULL값을 가진 자료를 MAX() 함수 적용시 NULL 반환. -> 자동 +1 증가 액션 불가.
SELECT MAX(NVL(employee_id, 0))
, MAX(NVL(employee_id, 0)) + 1 
FROM hr.employees;


--------------------------------
--일반 컬럼(단일행 함수)과 복수행 함수를 혼용할 수 없다.
SELECT department_id, COUNT(*)
FROM hr.employees
WHERE department_id = 100;
--ORA-00937: not a single-group group function
--GROUP BY 구문을 이용하면 가능

-------------------------------
--GROUP BY 구문
--복수행 함수에 투입되는 행들을 일정 기준으로 그룹핑한다.
--예를 들어, 부서별, 지역별, 성별, ... 등.
--기본 형식
/*
SELECT 그룹기준컬럼, 복수행함수
FROM table_list
WHERE 조건식
GROUP BY 그룹기준컬럼, ...
ORDER BY 정렬기준컬럼, ...;
*/

--hr.employees 테이블에서 부서번호(department_id)별로 인원수 출력. COUNT() 함수.
SELECT department_id, COUNT(*)
FROM hr.employees
GROUP BY department_id
ORDER BY department_id;

--hr.employees 테이블에서 부서번호(department_id)별, 직위아이디(job_id)별로 인원수 출력. COUNT() 함수.
SELECT department_id, job_id, COUNT(*)
FROM hr.employees
GROUP BY department_id, job_id
ORDER BY department_id, job_id;


--hr.employees 테이블에서 입사일(hire_date) 정보 중에서 년도별로 인원수 출력. COUNT() 함수.
SELECT TO_CHAR(hire_date, 'YYYY') hire_date, COUNT(*)
FROM hr.employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
ORDER BY hire_date;


-------------------------------
--HAVING 구문
--복수행 함수의 결과에 대한 조건식 지정하는 구문.
--기본 형식
/*
SELECT 그룹기준컬럼, 복수행함수
FROM table_list
WHERE 조건식
GROUP BY 그룹기준컬럼, ...
HAVING (복수행 함수의 결과에 대한)조건식
ORDER BY 정렬기준컬럼, ...;
*/


--hr.employees 테이블에서 입사일(hire_date) 정보 중에서 년도별로 인원수 출력. COUNT() 함수.
--단, 인원수가 10명 이상인 경우만 출력 대상으로 지정.
SELECT TO_CHAR(hire_date, 'YYYY') hire_date, COUNT(*)
FROM hr.employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
HAVING COUNT(*)>=10
ORDER BY hire_date;


--hr.employees 테이블에서 입사일(hire_date) 정보 중에서 년도별로 인원수 출력. COUNT() 함수.
--단, 입사년도가 2005년 이상이면서, 인원수가 10명 이상인 경우만 출력 대상으로 지정.
SELECT TO_CHAR(hire_date, 'YYYY') hire_date, COUNT(*)
FROM hr.employees
WHERE TO_CHAR(hire_date, 'YYYY')>=2005
GROUP BY TO_CHAR(hire_date, 'YYYY')
HAVING COUNT(*)>=10
ORDER BY hire_date;




--------------------------------------------------------------

33. 급여(basicpay+sudang)가 100만원 미만
, 100만원 이상~200만원 미만, 200만원 이상인 직원들의 수 출력.
--GROUP BY 구문

SELECT TRUNC((basicpay+sudang)/1000000) pay
  FROM insa;

SELECT DECODE(TRUNC((basicpay+sudang)/1000000)
      , 0, '100만 미만'
      , 1, '100만 이상~200만 미만'
      , 2, '200만 이상') AS title
  , COUNT(*) AS 직원수
  FROM insa
  GROUP BY TRUNC((basicpay+sudang)/1000000);

출력예)
title   직원수
--------------------------------
100만 이상~200만 미만 30
200만 이상  26
100만 미만  4



34. 주민번호(ssn)를 가지고 생년월일의 년도별 직원수 출력. 
   SUBSTR(), COUNT(), GROUP BY 이용.
   SELECT SUBSTR(SSN,0,2) || '년생',COUNT(*) AS 인원
   FROM insa
   GROUP BY SUBSTR(SSN,0,2)
   ORDER BY SUBSTR(SSN,0,2);
/*   
35. 주민번호(ssn)를 기준으로 월별 오름차순, 월이 같으면 년도 내림차순 출력. 
(이름, 주민번호) . 
SUBSTR(), ORDER BY  이용.
*/
SELECT SUBSTR(SSN,0,2) AS 년도, SUBSTR(SSN,3,2) AS 월
FROM insa
ORDER BY SUBSTR(SSN,3,2) ASC
        ,SUBSTR(SSN,0,2) DESC;




36. 입사일(ibsaDate)을 기준으로  월별 오름차순, 월이 같으면 년도 내림차순 출력. 
주의. 입사일은 자료형이 DATE입니다.
주의. 2000년도 이후 입사자는 내림차순 지정시 뒤로 갈수 있으므로 주의할 것.
TO_CHAR(입사일, 'YYYY')
TO_CHAR(입사일, 'MM')

SELECT *
FROM insa
ORDER BY SUBSTR(ibsadate,6,2) ASC
        ,SUBSTR(ibsadate,0,4) DESC;


37. 전체인원수, 남자인원수, 여자인원수를 동시 출력.
출력 예)

전체인원수   남자인원수   여자인원수
   60      31           29

SELECT COUNT(*) 전체인원수
  , COUNT(DECODE(SUBSTR(ssn, 8, 1), 2, null, 1)) 남자인원수
  , COUNT(DECODE(SUBSTR(ssn, 8, 1), 1, null, 2)) 여자인원수
  FROM insa;


인원수 구분  인원수
남자인원수   31
여자인원수   29
전체인원수   60


SELECT DECODE(SUBSTR(ssn, 8, 1)
        , 1, '남자인원수'
        , 2, '여자인원수'
        , '전체인원수') "인원수 구분"
        , COUNT(*) 인원수
  FROM insa
  GROUP BY ROLLUP(SUBSTR(ssn, 8, 1));




38. '개발부', '영업부', '총무부' 인원수 출력. COUNT(), DECODE() 함수 이용.
개발부->14
영업부->16
총무부->7

SELECT COUNT(DECODE(buseo,'개발부',1)) AS 개발부
    ,COUNT(DECODE(buseo,'영업부',1)) AS 영업부
    ,COUNT(DECODE(buseo,'총무부',1)) AS 총무부
FROM insa;


39. 지역명(city)이 '서울'이면서, 성별이 남자인 직원수 출력.
COUNT(), WHERE 이용

SELECT COUNT(*) AS 서울남자직원수
FROM insa
WHERE city = '서울' AND SUBSTR(ssn,8,1) = 1;

40. 부서(buseo)가 '영업부'이고, 남자인 경우, 여자인 경우 인원수 출력.  
COUNT(), DECODE() , WHERE 이용.
출력 예)
영업부인원수   남자인원수   여자인원수
   XX           XX        XX

SELECT COUNT(*) AS 영업부인원수
  , COUNT(DECODE(SUBSTR(ssn, 8, 1), 2, null, 1)) 남자인원수
  , COUNT(DECODE(SUBSTR(ssn, 8, 1), 1, null, 2)) 여자인원수
FROM insa
WHERE BUSEO = '영업부';



41. '개발부', '영업부', '총무부' 인원수 출력. 단, 지역명(city)은 '서울'로 한정.
출력 예)
영업부인원수   개발부인원수   총무부인원수
   XX           XX        XX
   
SELECT COUNT(DECODE(buseo,'개발부',1)) AS 개발부인원수
    ,COUNT(DECODE(buseo,'영업부',1)) AS 영업부인원수
    ,COUNT(DECODE(buseo,'총무부',1)) AS 총무부인원수
FROM insa
WHERE city = '서울';

42. 지역명(city)이 '서울'인 남자와 여자의 기본급(basicpay) 합 출력.
WHERE, DECODE(), SUM()

SELECT 
    SUM( DECODE(SUBSTR(ssn, 8, 1), 1, basicpay) )  남자기본급합
  , SUM( DECODE(SUBSTR(ssn, 8, 1), 2, basicpay) ) 여자기본급합
  FROM insa
  WHERE city='서울';


43. 남자와 여자의 기본급(basicpay) 평균값 출력. AVG(), DECODE() 함수 이용.

남자 평균->1676168
여자 평균->1428634

SELECT ROUND(AVG(DECODE(SUBSTR(ssn,8,1),'1',basicpay))) AS 서울남자기본급평균
    ,ROUND(AVG(DECODE(SUBSTR(ssn,8,1),'2',basicpay))) AS 서울여자기본급평균
FROM insa;


44. '개발부' 남자와 '개발부' 여자의 기본급(basicpay) 평균값 출력. AVG(), DECODE() 함수 이용.

개발부 남자 평균->1392500
개발부 여자 평균->1384375

SELECT ROUND(AVG(DECODE(SUBSTR(ssn,8,1),'1',basicpay))) AS 개발부남자기본급평균
    ,ROUND(AVG(DECODE(SUBSTR(ssn,8,1),'2',basicpay))) AS 개발부여자기본급평균
FROM insa
WHERE buseo = '개발부';


45. 부서(buseo)별 남자와 여자 인원수 구하기

--남자, 여자 출력. 

SELECT '771212-1022432'
    , SUBSTR('771212-1022432', 8, 1) AS 성별
    , DECODE(SUBSTR('771212-1022432', 8, 1)
            , 1, '남자'
            , 2, '여자') AS 성별
  FROM dual;

SELECT name, ssn
    , SUBSTR(ssn, 8, 1) AS 성별
    , DECODE(SUBSTR(ssn, 8, 1)
            , 1, '남자'
            , 2, '여자') AS 성별
  FROM insa;

--남자 인원수 출력
SELECT COUNT(*) AS "남자인원수"
  FROM insa
  WHERE SUBSTR(ssn, 8, 1)=1;

--여자 인원수 출력
SELECT COUNT(*) AS "여자인원수"
  FROM insa
  WHERE SUBSTR(ssn, 8, 1)=2;

--남자, 여자 인원수 출력
SELECT COUNT(DECODE(SUBSTR(ssn, 8, 1), 1, 1)) AS "남자인원수"
  , COUNT(DECODE(SUBSTR(ssn, 8, 1), 2, 1)) AS "여자인원수"
      FROM insa;


--부서별 총원, 남자, 여자 인원수 출력
SELECT buseo
    , COUNT(*) AS "인원수"
   , COUNT(DECODE(SUBSTR(ssn, 8, 1), 1, 1)) AS "남자인원수"
  , COUNT(DECODE(SUBSTR(ssn, 8, 1), 2, 1)) AS "여자인원수"
    FROM insa
    GROUP BY buseo;

총무부 7 4 3
개발부 14 6 8
영업부 16 8 8
기획부 7 4 3
인사부 4 4 0
자재부 6 2 4
홍보부 6 3 3



46. 지역(city)별 남자와 여자 인원수 구하기
SELECT city
    ,COUNT((DECODE(SUBSTR(ssn,8,1),'1',1))) AS 남자
    ,COUNT((DECODE(SUBSTR(ssn,8,1),'2',1))) AS 여자
FROM insa
GROUP BY city;



47. 입사년도(ibsaDate)별 남자와 여자 인원수 구하기

SELECT TO_CHAR(ibsadate,'YYYY') AS 입사년도
    ,COUNT((DECODE(SUBSTR(ssn,8,1),'1',1))) AS 남자
    ,COUNT((DECODE(SUBSTR(ssn,8,1),'2',1))) AS 여자
FROM insa
GROUP BY TO_CHAR(ibsadate,'YYYY')
ORDER BY 입사년도 ASC;

48. '영업부', '총무부' 인원만을 가지고 입사년도(ibsaDate)별 남자와 여자 인원수 구하기

SELECT TO_CHAR(ibsadate,'YYYY') AS 입사년도
    ,COUNT((DECODE(SUBSTR(ssn,8,1),'1',1))) AS 남자
    ,COUNT((DECODE(SUBSTR(ssn,8,1),'2',1))) AS 여자
FROM insa
WHERE buseo IN('영업부','총무부')
GROUP BY TO_CHAR(ibsadate,'YYYY')
ORDER BY 입사년도 ASC;


49. 지역명(city)이 '서울'인 경우 부서(buseo)별 남자와 여자인원수, 남자와 여자 급여합 출력.
SELECT buseo
    ,COUNT(*) AS 부서별직원
    ,COUNT(DECODE(SUBSTR(ssn,8,1),'1',1)) AS 남자
    ,COUNT(DECODE(SUBSTR(ssn,8,1),'2',1)) AS 여자
    ,SUM(DECODE(SUBSTR(ssn,8,1),'1',basicpay)) AS 남자기본급합
    ,SUM(DECODE(SUBSTR(ssn,8,1),'2',basicpay)) AS 여자기본급합
FROM insa
WHERE city = '서울'
GROUP BY buseo;


50. 부서(buseo)별 인원수 출력. 인원수가 10 이상인 경우만. GROUP BY, COUNT(), HAVING 이용.
SELECT buseo
    ,COUNT(*) AS 부서별인원수
FROM insa
GROUP BY buseo
HAVING COUNT(*) >=10;

51. 부서(buseo)별 남,여 인원수 출력. 여자인원수가 5명 이상인 부서만 출력.
SELECT buseo
    ,COUNT(*) AS 부서별인원수
    ,COUNT(DECODE(SUBSTR(ssn,8,1),'1',1)) AS 남자
    ,COUNT(DECODE(SUBSTR(ssn,8,1),'2',1)) AS 여자
FROM insa
GROUP BY buseo
HAVING COUNT(DECODE(SUBSTR(ssn,8,1),'2',1)) >=5;



52. 부서(buseo)별 평균 급여를 출력하되, A, B, C 등급으로 나눠서 출력.
200만원 초과 - A등급
150~200만원 - B등급
150만원 미만 - C등급

DECODE 또는 CASE ~ END

SELECT buseo
    ,ROUND(AVG(basicpay+sudang))
    ,CASE
    WHEN ROUND(AVG(basicpay+sudang))>2000000 THEN 'A등급'
    WHEN ROUND(AVG(basicpay+sudang))BETWEEN 1500000 AND 2000000 THEN 'B등급'
    WHEN ROUND(AVG(basicpay+sudang))<1500000 THEN 'C등급'
    END AS 등급
FROM insa
GROUP BY buseo;


53. 이름, 성별, 나이 출력
       성별: 주민번호 1,3->남자, 2,4->여자 (DECODE 사용)
       나이: 주민번호 이용해서
SELECT name 이름
    , DECODE(SUBSTR(ssn, 8, 1), '1', '남자', '2', '여자', '3', '남자', '4', '여자') 성별
    , TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(TO_DATE(SUBSTR(ssn, 1, 6)), 'YYYY') + 1 나이
FROM insa;       
   

54. 지역명(city)이 '서울'이면서 기본급(basicpay)이 200만원 이상인 직원. (이름, 기본급)

SELECT name 이름,basicpay 기본급
FROM insa
WHERE city = '서울' AND basicpay >2000000;

 
55. 입사월별 인원수 구하기. (월, 인원수)   COUNT, GROUP BY, TO_CHAR 사용
        출력형태 ----------
        월      인원수
        1월    10명
        2월    25명


SELECT CONCAT(TO_NUMBER(TO_CHAR(ibsadate, 'MM')), '월') AS 월
      , CONCAT(COUNT(*),'명') AS 인원수
  FROM insa
  GROUP BY TO_CHAR(ibsadate, 'MM')
  ORDER BY TO_CHAR(ibsadate, 'MM');


56. 이름, 생년월일, 기본급, 수당을 출력.
       생년월일은 주민번호 기준 (2000-10-10 형식으로 출력)
       기본급은 \1,000,000 형식으로 출력
숫자 서식 지정 => TO_CHAR(숫자데이터, '999,999,999,999')

SELECT name 이름
    , TO_CHAR(TO_DATE(SUBSTR(ssn,1,6)),'YYYY-MM-DD') 생년월일
    , TO_CHAR(basicpay,'999,999,999,999') 기본급
    , sudang 수당
FROM insa;


57. 이름, 지역명, 기본급을 출력하되 지역명 오름차순 출력(1차 정렬 기준). 
지역명이 같으면 기본급 내림차순 출력(2차 정렬 기준).

SELECT name 이름, city 지역명, basicpay 기본급
FROM insa
ORDER BY  city ASC , basicpay DESC;

58. 전화번호(tel)가 NULL이 아닌것만 출력. (이름, 전화번호)
SELECT name 이름, tel 전화번호
FROM insa
WHERE tel IS NOT NULL;

59. 근무년수가 10년 이상인 사람 출력. (이름, 입사일)

SELECT name 이름, ibsadate 입사일
    ,FLOOR(MONTHS_BETWEEN(SYSDATE,ibsadate)) AS 근무개월수
FROM insa
WHERE FLOOR(MONTHS_BETWEEN(SYSDATE,ibsadate))>=120;
 
60. 주민번호(ssn)를 기준으로 75~82년생 출력. (이름, 주민번호, 지역명). 
SUBSTR() 함수, BEWTEEN AND 구문, TO_NUMBER() 함수 이용.

SELECT name 이름, ssn 주민번호, city 지역명
FROM insa
WHERE TO_NUMBER(SUBSTR(ssn,1,2))BETWEEN 75 AND 82;

61. 근무년수가 10~15년인 사람 출력. (이름, 입사일)

SELECT name 이름 , ibsadate 입사일
    ,FLOOR(MONTHS_BETWEEN(SYSDATE,ibsadate)) AS 근무개월수
FROM insa
WHERE FLOOR(MONTHS_BETWEEN(SYSDATE,ibsadate))BETWEEN 120 AND 180 ;
 
62. 김씨, 이씨, 박씨만 출력 (이름, 부서). SUBSTR() 함수 이용.
SELECT name 이름 , buseo 부서
FROM insa
WHERE SUBSTR(name,1,1)IN('김','이','박');

63. 입사일(ibsaDate)을 "년-월-일 요일" 형식으로 남자만 출력 (이름, 주민번호, 입사일)

SELECT name 이름, ssn 주민번호, TO_CHAR(ibsadate,'YYYY-MM-DD DAY') 입사일
FROM insa
WHERE SUBSTR(ssn,8,1) = '1';

64. 부서(buseo)별, 직위(jikwi)별 급여합 구하기. (부서, 직위, 급여합)

--부서별, 직위별 직원수
SELECT buseo, jikwi, COUNT(*) count_
  FROM insa
  GROUP BY buseo, jikwi
  ORDER BY buseo, jikwi;

개발부 과장 2
개발부 대리 2
개발부 부장 1
개발부 사원 9
기획부 대리 3
기획부 부장 2
기획부 사원 2
영업부 과장 1
영업부 대리 5
영업부 부장 2
영업부 사원 8
인사부 과장 1
...

 
65. 부서(buseo)별, 직위(jikwi)별 인원수를 구하되 인원수가 5명 이상인 경우만 출력.

SELECT buseo 부서 , jikwi 직위 , COUNT(*) AS 인원수
FROM insa
GROUP BY buseo,jikwi
HAVING COUNT(*)>= 5;

 

66. 2000년도에 입사한 여직원. (이름, 주민번호, 입사일)

SELECT name 이름
, ssn 주민번호
, ibsadate 입사일
FROM insa
WHERE SUBSTR(ibsadate, 1, 2) = 00 AND SUBSTR(SSN, 8, 1) IN (2 , 4);  


67. 성씨가 한 글자(김, 이, 박 등)라는 가정하에 성씨별 인원수 (성씨, 인원수)
 SELECT SUBSTR(name,1,1) 성씨
    ,COUNT(SUBSTR(name,1,1)) 인원수
FROM insa
GROUP BY SUBSTR(name,1,1);

68. 지역(city)별, 성별 인원수.

SELECT city 
    ,COUNT(DECODE(SUBSTR(ssn,8,1),'1',1)) AS 남자
    ,COUNT(DECODE(SUBSTR(ssn,8,1),'2',1)) AS 여자
FROM insa
GROUP BY city;


69. 부서(buseo)별 남자인원수가 5명 이상인 부서와 남자인원수.

SELECT buseo 부서
    ,COUNT(DECODE(SUBSTR(ssn,8,1),'1',1)) AS 남자인원수
FROM insa
GROUP BY buseo
HAVING COUNT(DECODE(SUBSTR(ssn,8,1),'1',1)) >= 5;
 
70. 입사년도(ibsaDate)별 인원수.

SELECT TO_CHAR(ibsadate,'YYYY') 입사년도
    ,COUNT(*) 인원
FROM insa
GROUP BY  TO_CHAR(ibsadate,'YYYY')
ORDER BY 입사년도;


71. 전체인원수, 2000년, 1999년, 1998년도에 입사한 인원을 다음의 형식으로 출력.
        전체 2000 1999 1998
         60    x    x    x
         
     SELECT COUNT(*) 전체인원수
     ,COUNT( DECODE(TO_CHAR(ibsadate,'YYYY'), '2000', '1')) "2000년"
     ,COUNT( DECODE(TO_CHAR(ibsadate,'YYYY'), '1999', '1')) "1999년"
     ,COUNT( DECODE(TO_CHAR(ibsadate,'YYYY'), '1998', '1')) "1998년"
     FROM insa;
         
         
         


72. 아래 형식으로 지역(city)별 인원수 출력. ROLLUP 구문 이용.
        전체 서울  인천  경기
         60    x     x     x


 지역명 인원수
 서울   XX
 인천   XX
 경기   XX
 전체  XX

----------------
SELECT 
   COUNT(*) 전체
  ,COUNT(DECODE(city, '강원', 1)) 강원
  ,COUNT(DECODE(city, '경기', 1)) 경기
  ,COUNT(DECODE(city, '경남', 1)) 경남
  ,COUNT(DECODE(city, '경북', 1)) 경북
  ,COUNT(DECODE(city, '부산', 1)) 부산
  ,COUNT(DECODE(city, '서울', 1)) 서울
  ,COUNT(DECODE(city, '인천', 1)) 인천
  ,COUNT(DECODE(city, '전남', 1)) 전남
  ,COUNT(DECODE(city, '전북', 1)) 전북
  ,COUNT(DECODE(city, '제주', 1)) 제주
  ,COUNT(DECODE(city, '충남', 1)) 충남
  FROM insa;

전체   강원    경기    경남     ...
60 2 13 1 ...


---------------
SELECT DECODE(city, NULL, '전체', city) city, COUNT(*) count_
  FROM insa
  GROUP BY ROLLUP(city);

강원 2
경기 13
경남 1
경북 1
부산 3
서울 20
인천 9
전남 3
전북 5
제주 2
충남 1
전체 60

--------------------------------------------------------------
