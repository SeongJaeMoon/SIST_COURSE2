/*

SELECT 쿼리

- 기본 형식
SELECT select_list FROM source_list;
- SELECT 쿼리는 특정 테이블에 저장된 자료를 조회하는 쿼리.
- SELECT 구문은 출력 대상을 지정하는 부분. 예를 들어, 컬럼명 지정. 이름, 전화번호 등.
- FROM 구문은 자료가 저장되어 있는 특정 테이블을 지정한다. 예를 들어, hr.employees
- SELECT ~ FROM ~ 키워드는 생략 불가.

*/


------------------------------------------------------
/*

WHERE 구문
--특정 조건을 지정하고, 조건을 만족하는 경우만 출력하도록 하는 구문.
--SELECT select_list FROM source_list WHERE 조건식;
--조건식은 참, 거짓 결과를 낼 수 있는 수식.
--관계연산자, 논리 연산자 등을 이용해서 조건식 작성.
--주의) 자료형을 정확하게 이해해야 정확한 결과를 얻을 수 있다.

*/


------------------------------------------------------

--BETWEEN 연산자로 구간 데이터 조회하기
--SELECT select_list FROM source_list WHERE 컬럼 BETWEEN 값1 AND 값2;
--값1에서 값2 범위에 존재하는 경우를 출력한다.

--예를 들어, hr.employees 테이블에서 급여(salary)가 0에서 10000인 경우 출력
SELECT  employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary BETWEEN 0 AND 10000;
--92

--예를 들어, hr.employees 테이블에서 급여(salary)가 5000에서 10000인 경우 출력
SELECT  employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary BETWEEN 5000 AND 10000;
--43

--BETWEEN 연산자를 일반 관계 연산자로 표현하면 다음과 같다.
SELECT  employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary >= 5000 AND salary <= 10000;
--43

--hr.employees 테이블에서 입사일(hire_date) 기준으로 2000년도~2005년도 입사자 출력.
SELECT  employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE TO_CHAR(hire_date, 'YYYY') BETWEEN '2000' AND '2005';
--53


--hr.employees 테이블에서 first_name 기준으로 'A'~'B'로 시작하는 이름을 가진 사원 출력.
SELECT  employee_id, first_name, last_name
FROM hr.employees
WHERE first_name BETWEEN 'A' AND 'C';
--12




------------------------------------------------------

--IN 연산자로 여러 조건을 간편하게 검색하기
--SELECT select_list FROM source_list WHERE 컬럼 IN (값1, 값2, 값3, ...);
--값1, 값2, 값3 등등 나열된 값 중에 하나를 만족하면 출력한다.
--예를 들어,  hr.employees 테이블에서 입사일(hire_date) 정보 중에서 1, 2, 3월 입사자만 출력.
SELECT  employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE TO_CHAR(hire_date, 'MM') IN ('01', '02', '03');

SELECT  employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE TO_CHAR(hire_date, 'MM') IN (1, 2, 3); --암시적 형변환 지원

--IN 연산자를 일반 관계 연산자로 표현하면 다음과 같다.
SELECT  employee_id, first_name, last_name, hire_date
FROM hr.employees
WHERE TO_CHAR(hire_date, 'MM') = '01'
        OR TO_CHAR(hire_date, 'MM') = '02'
        OR TO_CHAR(hire_date, 'MM') = '03';


--hr.employees 테이블에서 job_id가 Manager인 경우 출력
--'SA_MAN', 'ST_MAN', 'PU_MAN', 'AC_MGR'
SELECT  employee_id, first_name, last_name, job_id
FROM hr.employees
WHERE job_id IN ('SA_MAN', 'ST_MAN', 'PU_MAN', 'AC_MGR');
--12


------------------------------------------------------

--LIKE 연산자로 비슷한 것들 모두 찾기
--SELECT select_list FROM source_list WHERE 컬럼 LIKE '와일드카드 포함 값';
--와일드카드는 %(여러 문자 대체 가능), _(한 문자 대체 가능) 중에 하나로 표시
--예를 들어, '%값', '값%', '%값%' 형태로 사용.

--hr.employees 테이블에서 first_name이 'A'로 시작하는 경우 출력.
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE first_name LIKE 'A%';
--10

--hr.employees 테이블에서 first_name이 'A'~'B'로 시작하는 경우 출력.
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE first_name LIKE 'A%' OR first_name LIKE 'B%';
--12


--hr.employees 테이블에서 first_name이 'An'로 시작하는 경우 출력.
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE first_name LIKE 'An%';
--1

--hr.employees 테이블에서 phone_number가 '123'를 포함하는 경우 출력.
SELECT employee_id, first_name, last_name, phone_number
FROM hr.employees
WHERE phone_number LIKE '%123%';
--16
--주의) 와일드카드를 LIKE 연산자 조건식의 앞에 표기되는 경우는 권장하지 않는다. 속도 저하.


------------------------------------------------------

--IS NULL, IS NOT NULL 연산자로 NULL 검색하기
--SELECT select_list FROM source_list WHERE 컬럼 IS NULL;
--NULL 은 =(같음 비교) 연산자로 검색 불가.
--컬럼의 값이 명시적으로 존재하지 않는 상태를 NULL이라고 한다. 숫자, 문자, 날짜 자료형 모두 NULL 허용.
--NULL 허용하지 않는 경우는 Primary key와 같은 제약이 지정된 경우이다.

--hr.employees 테이블에서 부서번호(department_id)가 할당되지 않은 사원 출력
SELECT employee_id, first_name, last_name, department_id
FROM hr.employees
WHERE department_id IS NULL;
--1

SELECT employee_id, first_name, last_name, department_id
FROM hr.employees
WHERE department_id IS NOT NULL;
--106



------------------------------------------------------

--검색 조건이 두 개 이상일 경우 조회하기
--AND(논리곱), OR(논리합) 연산자
--SELECT select_list FROM source_list WHERE 조건1 AND 조건2 AND 조건3 ...;
--SELECT select_list FROM source_list WHERE 조건1 OR 조건2 OR 조건3 ...;
--OR 연산자 대신 IN 연산자를 사용할 수 있다.

--hr.employees 테이블에서 급여(salary)가 10000 이상이면서, 부서번호(department_id)가 100인 경우 출력.
SELECT employee_id, first_name, last_name
        , salary, department_id
FROM hr.employees
WHERE salary >= 10000 AND department_id = 100;
--1


--hr.employees 테이블에서 급여(salary)가 10000 이상이면서, 커미션(commission_pct)이 없는 경우 출력.
SELECT employee_id, first_name, last_name
        , salary, department_id
FROM hr.employees
WHERE salary >= 10000 AND commission_pct IS NULL;
--8



---------------------------------------------------
--쿼리 실행시 외부에서 자료 입력받기
--쿼리 구문에 &식별자를 사용하면 쿼리 실행시 외부 입력 처리 가능.
--예를 들어, 직원번호(employee_id)를 외부 입력받은 후 검색 진행.
SELECT employee_id, first_name, last_name
FROM hr.employees
WHERE employee_id = &employee_id;





-------------------------------------------------------------
/*

ORDER BY 구문
--정렬 지원
--SELECT select_list FROM source_list ORDER BY 컬럼;
--정렬 방식은 오름차순(ASC), 내림차순(DESC) 지원
--ASC는 생략 가능, DESC는 생략 불가.
--예를 들어, 이름 기준 오름차순 정렬한다면
SELECT employee_id, first_name, last_name
FROM hr.employees
ORDER BY first_name ASC
--기준 컬럼을 두 개 이상 나열하면 1차, 2차 정렬 진행.
--SELECT select_list FROM source_list ORDER BY 컬럼1 ASC, 컬럼2 DESC;
--ORDER BY 구문에만 select_list에서 사용한 별칭(Alias) 사용 가능.
--WHERE 구문과 함께 사용시 SELECT ~ FROM ~ WHERE ~ ORDER BY 순으로 작성.

*/

--hr.employees 테이블 자료 출력시 이름(first_name) 기준 오름차순 정렬 출력한다.
SELECT employee_id, first_name, last_name
FROM hr.employees
ORDER BY first_name ASC;

--hr.employees 테이블 자료 출력시 급여(salary) 기준 내림차순 정렬 출력한다.
SELECT employee_id, first_name, last_name, salary
FROM hr.employees
ORDER BY salary DESC;

--hr.employees 테이블 자료 출력시 부서번호(department_id) 오름차순, 급여(salary) 내림차순 정렬 출력한다.
SELECT employee_id, first_name, last_name, department_id, salary
FROM hr.employees
ORDER BY department_id, salary DESC;

--hr.employees 테이블 자료 출력시 부서번호(department_id) 오름차순, 급여(salary) 내림차순 정렬 출력한다.
--단, 급여(salary)가 10000 이상인 경우만 출력.
SELECT employee_id, first_name, last_name, department_id, salary
FROM hr.employees
WHERE salary >= 10000
ORDER BY department_id, salary DESC;


--hr.employees 테이블 자료 정렬 출력시 별칭 사용.
SELECT employee_id, first_name, last_name, TO_CHAR(hire_date, 'YYYY') year_
FROM hr.employees
ORDER BY year_;
--주의) ORDER BY 구문 외의 장소에서 별칭 사용 불가. 대표적으로 WHERE 구문.
SELECT employee_id, first_name, last_name, TO_CHAR(hire_date, 'YYYY') year_
FROM hr.employees
WHERE year_ IN ('2002', '2003') --X
ORDER BY year_;
SELECT employee_id, first_name, last_name, TO_CHAR(hire_date, 'YYYY') year_
FROM hr.employees
WHERE TO_CHAR(hire_date, 'YYYY') IN ('2002', '2003') --O
ORDER BY year_;


--NULL값이 포함된 컬럼 기준 정렬 출력
SELECT employee_id, first_name, last_name, commission_pct
FROM hr.employees
ORDER BY commission_pct;



--------------------------------------------------
/*
함수(Function)
-- 내장 함수, 사용자 정의 함수
-- 매개변수에 어떤 값을 전달하면, 내부적인 처리를 진행하고, 결과를 반환하도록 만들어진 코드.
-- 단일행 함수(행당 결과 한 개)와 복수행 함수(여러개의 행을 투입하면 결과 한 개)로 구분된다.
-- 단일행 함수는 문자함수, 숫자함수, 날짜함수, 변환함수, 일반함수로 구분.
*/

-------------------------------------
--INITCAP() 함수
--(영문)문자열에서 첫 글자만 대문자로 표시.
--예를 들어, 'steven'을 'Steven'로 표시해준다.
--유사한 함수로 모두 대문자(UPPER), 모두 소문자(LOWER)로 표시하는 함수가 있다.
SELECT employee_id
        , first_name
        , INITCAP(first_name)
        , UPPER(first_name)
        , LOWER(first_name)
FROM hr.employees;


-------------------------------------
--UPPER() 함수
--(영문)문자열에서 모두 대문자로 표시.
--예를 들어, 'Steven'을 'STEVEN'로 표시해준다.
--유사한 함수로 첫글자 대문자(INITCAP), 모두 소문자(LOWER)로 표시하는 함수가 있다.
--검색시 대소문자를 구분하기 때문에 소문자, 대문자로 변환 필요.

-------------------------------------
--LOWER() 함수
--(영문)문자열에서 모두 소문자로 표시.
--예를 들어, 'Steven'을 'steven'로 표시해준다.
--유사한 함수로 첫글자 대문자(INITCAP), 모두 대문자(UPPER)로 표시하는 함수가 있다.
--검색시 대소문자를 구분하기 때문에 소문자, 대문자로 변환 필요.

SELECT employee_id , first_name, last_name
FROM hr.employees
WHERE first_name='steven'; --결과 없음. 대소문자 구분한다.

SELECT employee_id , first_name, last_name
FROM hr.employees
WHERE LOWER(first_name)=LOWER('steven'); --올바른 결과


----------------------------
--LENGTH() 함수
--문자열의 글자수 반환하는 함수. 한글, 영어 관계없이 글자수 반환.
--유사한 함수로 LENGTHB() 함수가 있다. 바이트 단위로 반환한다.
SELECT employee_id
    , first_name
    , LENGTH(first_name)
FROM hr.employees;

SELECT LENGTH('TEST')
    , LENGTH('테스트')
    , LENGTHB('TEST')
    , LENGTHB('테스트')  --한글 한 글자는 3byte
FROM dual;


----------------------------
--LENGTHB() 함수
--문자열의 바이트 반환하는 함수. 한글, 영어가 다른 결과 출력된다.
--한글 한 문자는 3byte, 영숫자 한 문자는 1byte
--유사한 함수로 LENGTH() 함수가 있다. 글자수 단위로 반환한다.


-----------------------------
--CONCAT() 함수
--문자열 두 개를 하나의 문자열로 결합시켜주는 함수.
--문자열 결합 연산자(||)를 이용하면 두 개 이상의 문자열 결합 가능.
SELECT employee_id, first_name, last_name
        , CONCAT(first_name, last_name) fullname1
        , first_name || ' ' || last_name fullname2
FROM hr.employees;



-----------------------------
--SUBSTR() 함수
--문자열의 일부(시작위치, 글자수)만 추출해서 반환하는 함수.
--주의) 시작 위치는 1부터 시작한다.
SELECT 
    SUBSTR('ABCDE', 1, 2)
    ,SUBSTR('ABCDE', 2, 2)
    ,SUBSTR('ABCDE', 3, 2)
    ,SUBSTR('ABCDE', 4, 2)
FROM dual;









