--------------------------------------------------
/*
함수(Function)
-- 내장 함수, 사용자 정의 함수
-- 매개변수에 어떤 값을 전달하면, 내부적인 처리를 진행하고, 결과를 반환하도록 만들어진 코드.
-- 단일행 함수(행당 결과 한 개)와 복수행 함수(여러개의 행을 투입하면 결과 한 개)로 구분된다.
-- 단일행 함수는 문자함수, 숫자함수, 날짜함수, 변환함수, 일반함수로 구분.
*/



----------------------------
--분석 함수
--행끼리 연산이나 비교를 쉽게 지원해주기 위한 함수
--ROLLUP(), CUBE(), GROUPING SETS(), LISTAGG(), PIVOT(), LAG(), READ(), RANK(), DENSE_RANK(), ROW_NUMBER(), SUM() OVER()


------------------------------
--ROLLUP() 함수
--기준별(GROUP BY) 소계(COUNT, SUM)를 요약해서 보여주는 함수

--hr.employees 테이블에서 부서번호(department_id)별로 인원수 출력
SELECT NVL(department_id, -1) department_id, COUNT(*)
FROM hr.employees
GROUP BY NVL(department_id, -1)
ORDER BY department_id;

--hr.employees 테이블에서 부서번호(department_id)별로 인원수 및 인원수 총합 출력
SELECT NVL(department_id, -1)  department_id, COUNT(*)
FROM hr.employees
GROUP BY ROLLUP(NVL(department_id, -1))
ORDER BY department_id;


--hr.employees 테이블에서 직위아이디(job_id)별로 인원수 및 인원수 총합 출력
SELECT job_id, COUNT(*)
FROM hr.employees
GROUP BY ROLLUP(job_id)
ORDER BY job_id;


--hr.employees 테이블에서 부서번호(department_id) 및 직위아이디(job_id)별로 인원수 및 인원수 소계, 총합 출력
SELECT department_id, job_id, COUNT(*)
FROM hr.employees
GROUP BY ROLLUP(department_id, job_id)
ORDER BY department_id, job_id;


------------------------------
--CUBE() 함수
--기준별(GROUP BY) 소계(COUNT, SUM) 및 전체합계를 요약해서 보여주는 함수

--hr.employees 테이블에서 직위아이디(job_id)별로 인원수 및 인원수 총합 출력
SELECT job_id, COUNT(*)
FROM hr.employees
GROUP BY CUBE(job_id)
ORDER BY job_id;


--hr.employees 테이블에서 부서번호(department_id) 및 직위아이디(job_id)별로 인원수 및 인원수 소계, 총합 출력
SELECT department_id, job_id, COUNT(*)
FROM hr.employees
GROUP BY CUBE(department_id, job_id)
ORDER BY department_id, job_id;



---------------------------
--GROUPING SETS() 함수
--기준별(GROUP BY) 소계(COUNT, SUM) 및 전체합계를 요약해서 보여주는 함수


--hr.employees 테이블에서 부서번호(department_id) 및 직위아이디(job_id)별로 인원수 및 인원수 소계, 총합 출력
SELECT department_id, job_id, COUNT(*)
FROM hr.employees
GROUP BY GROUPING SETS(department_id, job_id)
ORDER BY department_id, job_id;


--------------------------
--LISTAGG() 함수
--출력시 자료를 하나의 문자열로 통합 출력.

--hr.employees 테이블에서 부서번호(department_id)별 인원수 및 명단(first_name) 출력.
SELECT department_id
    , COUNT(*)
    , LISTAGG(first_name, '/') WITHIN GROUP(ORDER BY first_name) first_names
FROM hr.employees
GROUP BY department_id;


--------------------------
--PIVOT() 함수
--출력시 가로(세로) 형태를 세로(가로) 형태로 바꿔주는 함수.

--hr.employees 테이블에서 부서번호 및 직위아이디별 인원수 출력
SELECT department_id
    , COUNT(*)
    , COUNT(DECODE(job_id, 'AD_ASST', 1)) AD_ASST
    , COUNT(DECODE(job_id, 'MK_MAN', 1)) MK_MAN
    , COUNT(DECODE(job_id, 'MK_REP', 1)) MK_REP
FROM hr.employees
GROUP BY department_id;

--hr.employees 테이블에서 부서번호 및 직위아이디별 인원수 출력
SELECT * 
FROM (SELECT employee_id, department_id, job_id FROM hr.employees)
PIVOT (
    COUNT(employee_id) FOR job_id IN ('AD_ASST', 'MK_MAN', 'MK_REP')
)
ORDER BY department_id;



----------------------------------
--LAG() 함수
--이전 행 값을 가져오는 함수

--hr.employees 테이블에서 급여(salary)를 출력하되, 이전 행의 급여(salary)를 같이 출력.
SELECT employee_id, first_name, last_name
    , salary
    , LAG(salary, 1, 0) OVER (ORDER BY salary DESC) LAG_
    , salary - LAG(salary, 1, 0) OVER (ORDER BY salary DESC) LAG2_
FROM hr.employees;


----------------------------------
--LEAD() 함수
--이후 행 값을 가져오는 함수

--hr.employees 테이블에서 급여(salary)를 출력하되, 이후 행의 급여(salary)를 같이 출력.
SELECT employee_id, first_name, last_name
    , salary
    , LEAD(salary, 1, 0) OVER (ORDER BY salary DESC) LEAD_
    , salary - LEAD(salary, 1, 0) OVER (ORDER BY salary DESC) LEAD2_
FROM hr.employees;


-------------------------------
--RANK() 함수
--전체 순위 부여 함수
--주의) 동점자 처리 확인. 예를 들어, 1, 2, 2, 4 형태로 처리.

SELECT employee_id, first_name, last_name
    , salary
    , RANK() OVER (ORDER BY salary DESC) rank_
FROM hr.employees;

--hr.employees 테이블에서 급여(salary)가 높은 순에서 5번째 까지만 출력.

SELECT * FROM (SELECT employee_id, first_name, last_name
    , salary
    , RANK() OVER (ORDER BY salary DESC) rank_
FROM hr.employees)
WHERE rank_ <= 5;



-------------------------------
--DENSE_RANK() 함수
--전체 순위 부여 함수
--주의) 동점자 처리 확인. 예를 들어, 1, 2, 2, 3 형태로 처리.

SELECT employee_id, first_name, last_name
    , salary
    , DENSE_RANK() OVER (ORDER BY salary DESC) rank_
FROM hr.employees;


-------------------------------
--ROW_NUMBER() 함수
--고유 번호를 순번대로 부여하는 함수
--예를 들어, 1, 2, 3, 4 형태로 번호 부여

SELECT employee_id, first_name, last_name
    , salary
    , ROW_NUMBER() OVER (ORDER BY salary DESC) rn_
FROM hr.employees;



-------------------------------------
--SUM() OVER() 함수
--그룹별 누계를 출력해주는 함수

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
--RATIO_TO_REPORT() 함수
--그룹별 비중을 출력해주는 함수

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

