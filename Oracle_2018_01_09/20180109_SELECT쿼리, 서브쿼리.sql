--------------------------------
--서브쿼리(SubQuery)
--메인 쿼리 내에 SELECT 쿼리가 포함된 상태인 쿼리.
--주의) 서브쿼리는 ( 와 )로 감싸야 한다.
--기본 형식
/*
SELECT select_list
FROM table_list
WHERE 컬럼 연산자 (서브쿼리);
*/
--서브쿼리가 먼저 실행되고, 결과가 나오면 메인쿼리가 실행된다.


-----------------------------------
--단일 행 서브쿼리
--서브쿼리 결과가 1개의 행만 나오는 경우
--연산자는 비교 연산자(=, !=, >, <, >=, <=) 중에 하나 사용 가능.
/*
SELECT select_list
FROM table_list
WHERE 컬럼 = (결과값);
*/

--hr.employees 테이블에서 employee_id가 150인 사원과 같은 급여를 받는 사원 출력.
SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary = (SELECT salary
FROM hr.employees
WHERE employee_id=150);
--10000
--4


--문제) hr.employees 테이블에서 department_id가 100인 사원들의 평균급여(????)보다 많은 급여를 받는 사원 출력.

--문제) hr.employees 테이블에서 department_id가 100인 사원들의 최고급여(????)보다 많은 급여를 받는 사원 출력.

--문제) hr.employees 테이블에서 department_id가 100인 사원들의 최저급여(????)보다 적은 급여를 받는 사원 출력.
SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary < (SELECT MIN(salary)
FROM hr.employees
WHERE department_id=100);
--6900
--59

-----------------------------------
--다중 행 서브쿼리
--서브쿼리 결과가 여러개의 행이 나오는 경우
--연산자는 IN, EXISTS, >ALL, >ANY, <ALL, <ANY 사용 가능.
/*
SELECT select_list
FROM table_list
WHERE 컬럼 IN (결과값1, 결과값2, ...);
*/
/*
SELECT select_list
FROM table_list
WHERE EXISTS (결과값1, 결과값2, ...);
*/

--hr.employees 테이블에서 department_id가 100인 사원들과 같은 급여를 받는 사원 출력.
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


--문제) hr.employees 테이블에서 department_id가 100인 사원들의 입사년도(YYYY)와 같은 년도 입사자 출력.


--hr.employees 테이블에서 department_id가 100인 사원들의 급여 정보(결과)가 존재하면 메인 쿼리 실행.
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
--hr.employees 테이블에서 department_id가 100인 사원들의 최저급여(????)보다 적은 급여를 받는 사원 출력.
--ALL, ANY 연산자 사용
SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary <ALL (SELECT salary
FROM hr.employees
WHERE department_id=100);
--12008, 9000, 8200, 7700, 7800, 6900
--59


--hr.employees 테이블에서 department_id가 100인 사원들의 최고급여(????)보다 적은 급여를 받는 사원 출력.
SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary <ANY (SELECT salary
FROM hr.employees
WHERE department_id=100);
--12008, 9000, 8200, 7700, 7800, 6900
--99



--hr.employees 테이블에서 department_id가 100인 사원들의 최고급여(????)보다 많은 급여를 받는 사원 출력.
--ALL, ANY 연산자 사용
SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary >ALL (SELECT salary
FROM hr.employees
WHERE department_id=100);
--12008, 9000, 8200, 7700, 7800, 6900
--6


--hr.employees 테이블에서 department_id가 100인 사원들의 최저급여(????)보다 많은 급여를 받는 사원 출력.
SELECT employee_id, first_name, last_name, salary
FROM hr.employees
WHERE salary >ANY (SELECT salary
FROM hr.employees
WHERE department_id=100);




-------------------------------
--다중 컬럼 서브쿼리
--결과가 여러 컬럼으로 구성된 경우
--기본 형식
/*
SELECT select_list
FROM table_list
WHERE (컬럼1, 컬럼2, ...) IN (컬럼1_결과값, 컬럼2_결과값, ...);
*/

--hr.employees 테이블에서 department_id가 100인 사원 정보 중에서 job_id, salary가 일치하는 사원 출력.
SELECT employee_id, first_name, last_name
    , job_id, salary, department_id
FROM hr.employees
WHERE (job_id, salary) IN (SELECT job_id, salary
FROM hr.employees
WHERE department_id=100);


--hr.jobs, hr.employees 테이블에서 직급(job_id)별 최대 급여(max_salary)를 받는 사원 정보 출력.
SELECT employee_id, first_name, last_name
    , job_id, salary
FROM hr.employees
WHERE (job_id, salary) IN (SELECT job_id, max_salary
FROM hr.jobs);


--문제) hr.jobs, hr.employees 테이블에서 직급(job_id)별 최소 급여(min_salary)를 받는 사원 정보 출력.


--문제) hr.employees 테이블에서 부서번호(department_id)별로 입사일(hire_date) 정보가 가장 빠른 사원들 출력.
--다중 컬럼 서브쿼리에서 GROUP BY, MIN() 함수 사용.



-------------------------------
--상호 연관 서브쿼리
--메인 쿼리의 결과를 가지고, 서브쿼리에 참여하고, 서브쿼리의 결과가 메인 쿼리에 참여하는 경우.
--메인 쿼리의 테이블에 대해서 반드시 별칭 사용.
--기본 형식
/*
SELECT select_list
FROM table_list 별칭
WHERE 컬럼 연산자 (서브쿼리의 조건식에 메인쿼리 컬럼 정보 참여);
*/

SELECT employee_id, first_name, last_name
    , salary
    , department_id
FROM hr.employees emp
WHERE salary >= (SELECT AVG(salary) FROM hr.employees
        WHERE department_id=emp.department_id);
--현재 출력하고자 하는 사원의 부서번호(emp.department_id)별 평균급여
--41


-------------------------------
--스칼라 서브쿼리
--메인 쿼리의 결과를 가지고, 서브쿼리에 참여하고, 서브쿼리의 결과가 메인 쿼리에 참여하는 경우.
--메인 쿼리의 테이블에 대해서 반드시 별칭 사용.
--OUTER JOIN과 같은 결과. JOIN 쿼리 권장.
--기본 형식
/*
SELECT select_list
    , (서브쿼리의 조건식에 메인쿼리 컬럼 정보 참여)
FROM table_list 별칭;
*/

--hr.employees 테이블에서 사원 정보 출력시, 부서명(hr.departments 테이블의 department_name)을 같이 출력.
SELECT employee_id, first_name, last_name
    , department_id
    , (SELECT department_name
        FROM hr.departments
        WHERE department_id=emp.department_id) department_name
FROM hr.employees emp;


--hr.employees 테이블에서 사원 정보 출력시
--, 부서명(hr.departments 테이블의 department_name)와
-- 직위명(hr.jobs 테이블에서 job_title)을 같이 출력.
SELECT employee_id, first_name, last_name
    , department_id
    , (SELECT department_name
        FROM hr.departments
        WHERE department_id=emp.department_id) department_name
    , job_id
    , (스칼라 서브 쿼리) job_title
FROM hr.employees emp;


