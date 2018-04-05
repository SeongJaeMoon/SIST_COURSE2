------------------------
--JOIN
/*

1. 조인을 사용하면 테이블 간의 논리적 관계를 기준으로 둘 이상의 테이블에서 데이터를 검색할 수 있다.

INNER JOIN - 공통 값을 가지는 조건을 만족하는 ROW만 출력
OUTER JOIN - 공통 값을 가지는 조건을 만족하는 경우 외에도 출력

EQUI JOIN - =(equal) 연산자를 이용한 조건을 사용한 JOIN
NON-EQUI JOIN - =(equal) 연산자 외의 연산자를 이용한 조건을 사용한 JOIN

SELF JOIN - 자기 자신을 두 개의 가상 테이블로 만들어서 JOIN하는 방법. 별칭 사용.

ANSI JOIN - JOIN 구문을 오라클 방법이 아니라 표준적인 방법으로 작성한 것.



2. employees, departments, job_history, jobs, locations, countries, regions 테이블에서 관계 분석

*/


-------------------------------
--3.EQUI JOIN

/*
두 개 이상의 테이블에 관계되는 컬럼들의 값들이 일치하는 경우에 사용하는 가장 일반적인 join 형태로 WHERE 절에 '='(등호)를 사용한다. 흔히 PRIMARY KEY, FOREIGN KEY 관계를 이용하며 오라클에서는 NATURAL JOIN이 EQUI JOIN과 동일하다. 또는 USING 절을 사용하여 EQUI JOIN과 동일한 결과를 출력 한다.
PRIMARY KEY, FOREIGN KEY 제약이 걸려있는 컬럼은 값들이 일치하도록 되어 있다.


형식-1
SELECT *
	FROM 테이블_명1, 테이블_명2
	WHERE 테이블_명1.컬럼_명1=테이블_명2.컬럼_명1;

SELECT 테이블_명1.컬럼_명, 테이블_명2.컬럼_명 
	FROM 테이블_명1, 테이블_명2
	WHERE 테이블_명1.컬럼_명1=테이블_명2.컬럼_명1;

SELECT 별칭1.컬럼_명, 별칭2.컬럼_명 
	FROM 테이블_명1 별칭1, 테이블_명2 별칭2
	WHERE 별칭1.컬럼_명1=별칭2.컬럼_명1
    AND 조건식
    GROUP BY 컬럼, ...
    ...;

형식-ANSI SQL
SELECT 테이블_명1.컬럼_명, 테이블_명2.컬럼_명 
	FROM 테이블_명1 JOIN 테이블_명2 
	ON 테이블_명1.컬럼_명1=테이블_명2.컬럼_명1
    WHERE 조건식
    GROUP BY 컬럼, ...
    ...;
*/



--PK, FK 제약이 있는 테이블 및 컬럼을 확인하면 JOIN 지정이 쉽게 이루어진다.
--예를들어, hr.employees, hr.departments 테이블이다. 공통 컬럼은 department_id
--JOIN이 이루어지면 hr.employees, hr.departments 테이블이 한 개의 가상 테이블이 된다.
--단, 양쪽 테이블에 모두 존재하는 컬럼인 경우 테이블명 표시 필수.
/*
SELECT *
	FROM 테이블_명1, 테이블_명2
	WHERE 테이블_명1.컬럼_명1=테이블_명2.컬럼_명1;
*/

SELECT *
FROM hr.departments;
--27

SELECT *
FROM hr.employees;
--107

SELECT *
FROM hr.employees, hr.departments
WHERE hr.employees.department_id = hr.departments.department_id;
--106


SELECT employee_id, first_name, last_name
    , department_name
    , hr.employees.department_id
FROM hr.employees, hr.departments
WHERE hr.employees.department_id = hr.departments.department_id;
--106


--Oracle JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id;
--106


--ANSI JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e INNER JOIN hr.departments d
ON e.department_id = d.department_id;
--106



-------------------------------------
--JOIN(조인 조건) + 일반 조건


SELECT employee_id, first_name, last_name
    , department_id
FROM hr.employees
WHERE department_id = 100;


--Oracle JOIN
SELECT employee_id, first_name, last_name
    , e.department_id
    , department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id  
AND e.department_id = 100;


--ANSI JOIN
SELECT employee_id, first_name, last_name
    , e.department_id
    , department_name
FROM hr.employees e INNER JOIN hr.departments d
ON e.department_id = d.department_id  
WHERE e.department_id = 100;





--문제) hr.employees, hr.jobs 테이블을 조인 지정하고
--, 양쪽 테이블 컬럼 정보를 모두 출력.

--Oracle JOIN

--ANSI JOIN




--문제) hr.employees, hr.jobs 테이블을 조인 지정하고
--job_title이 'Stock Manager'인 직원 정보 출력.

--Oracle JOIN

--ANSI JOIN



------------------------------------

--job_title이 'Stock Manager', 'Stock Clerk'인 직원 정보 출력
SELECT *
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id
AND j.job_title = 'Stock Manager' OR j.job_title = 'Stock Clerk';

--job_title이 'Stock Manager', 'Stock Clerk'인 직원 정보 출력
SELECT employee_id, first_name, last_name
    , job_title
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id 
AND job_title IN ('Stock Manager', 'Stock Clerk');




--------------------------------------------
--4. Non-Equi Join
/*
- Join 조건에서 = 연산이 아닌 모든 경우를 말한다.
- 비교 대상인 컬럼 간에 연관성이 없어도 가능하다.

SELECT 컬럼리스트(별칭 사용 필요)
	FROM 테이블1 별칭1, 테이블2 별칭2
	WHERE 별칭1.컬럼 <= 별칭2.컬럼;

SELECT 컬럼리스트(별칭 사용 필요)
	FROM 테이블1 별칭1, 테이블2 별칭2
	WHERE 별칭1.컬럼 >= 별칭2.컬럼;
*/






-------------------------------------------------------
--5. Outer Join

/*
- 양쪽 테이블에 동일한 값이 존재하는 경우만 출력되는 경우는 Equi Join(Inner Join)이고,
동일한 값이 없어도 한 쪽 테이블의 자료는 모두 출력되는 경우는 Outer Join입니다.

--LEFT OUTER JOIN(테이블2가 NULL이 출력되는 상태)
--테이블1은 전체 출력, 테이블2는 부분 출력(Equi Join 조건 만족하는 경우만 출력)
--짝이 없는 경우 NULL로 출력된다.
--(+)는 NULL 출력 대상쪽에 붙인다.
SELECT 컬럼리스트
	FROM 테이블1 별칭1, 테이블2 별칭2
	WHERE 별칭1.컬럼 = 별칭2.컬럼(+);

--RIGHT OUTER JOIN(테이블1이 NULL이 출력되는 상태)
SELECT 컬럼리스트
	FROM 테이블1 별칭1, 테이블2 별칭2
	WHERE 별칭1.컬럼(+) = 별칭2.컬럼;

--ANSI LEFT OUTER JOIN(테이블1의 자료는 모두 출력)
SELECT 컬럼리스트
	FROM 테이블1 별칭1 LEFT OUTER JOIN 테이블2 별칭2
	ON 별칭1.컬럼 = 별칭2.컬럼;
*/


--Oracle JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id(+);
--107


--ANSI JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e LEFT OUTER JOIN hr.departments d
ON e.department_id = d.department_id;
--107


--Oracle JOIN
SELECT d.department_id, d.department_name
    , e.employee_id, e.first_name, e.last_name
FROM hr.departments d, hr.employees e
WHERE d.department_id = e.department_id(+);
--122


--ANSI JOIN
SELECT d.department_id, d.department_name
    , e.employee_id, e.first_name, e.last_name
FROM hr.departments d LEFT OUTER JOIN hr.employees e
ON d.department_id = e.department_id;
--122



--------------------------
--주의) OUTER JOIN에 사용한 컬럼은 일반 조건식에서도 (+)를 모두 붙여야 한다.
--Oracle JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id(+)
AND d.department_id(+) = 50;
--107



--문제) hr.employees, hr.jobs(job_title) 테이블에서 (LEFT) OUTER JOIN 결과 출력.

--hr.employees 전체 출력 기준. Oracle JOIN.
--107


--hr.jobs 전체 출력 기준. Oracle JOIN.



--hr.departments 테이블에서 직원이 없는 부서 정보 출력.
SELECT d.department_id, d.department_name
    , e.employee_id
FROM hr.departments d, hr.employees e
WHERE d.department_id = e.department_id(+)
AND employee_id IS NULL;
--16


--문제) hr.employees 테이블에서 말단 직원(부하 직원이 없는 직원) 정보 출력.
--자기 자신의 employee_id가 다른 직원의 manager_id에 없는 직원.
--예를 들어, employee_id가 150, 200인 직원은 말단 직원이다.
--SELF JOIN + OUTER JOIN 사용





-------------------------------
--6. Self Join

/*
- 일반적인 Join은 두 개의 서로 다른 테이블을 대상으로 Join을 하지만,
Self Join은 자기 자신을 가상의 테이블(테이블1, 테이블2가 모두 자기 자신인 상태)로 생각하고 Join을 진행하는 것.
- 별칭 사용 필수

SELECT 컬럼리스트
	FROM 테이블 별칭1, 테이블 별칭2
	WHERE 별칭1.컬럼 = 별칭2.컬럼;

SELECT 컬럼리스트
	FROM 테이블 별칭1, 테이블 별칭2
	WHERE 별칭1.컬럼 <= 별칭2.컬럼;

SELECT 컬럼리스트
	FROM 테이블 별칭1, 테이블 별칭2
	WHERE 별칭1.컬럼 >= 별칭2.컬럼;
*/


SELECT e1.employee_id, e1.first_name, e1.last_name
, e2.employee_id, e2.first_name, e2.last_name
FROM hr.employees e1, hr.employees e2
WHERE e1.salary = e2.salary;


--hr.employees 테이블에서 employee_id가 150인 직원의 급여와 같은 급여를 받는 직원 정보 출력.
SELECT e1.employee_id, e1.first_name, e1.last_name
    , e1.salary
, e2.employee_id, e2.first_name, e2.last_name
, e2.job_id, e2.department_id
FROM hr.employees e1, hr.employees e2
WHERE e1.salary = e2.salary
AND e1.employee_id = 150;



--hr.employees 테이블에서 employee_id가 150인 직원의 급여보다 더 많은 급여를 받는 직원 정보 출력.
SELECT e1.employee_id, e1.first_name, e1.last_name
    , e1.salary
, e2.employee_id, e2.first_name, e2.last_name
, e2.job_id, e2.department_id
, e2.salary
FROM hr.employees e1, hr.employees e2
WHERE e1.salary <= e2.salary
AND e1.employee_id = 150;
--19



--hr.employees 테이블에서 특정인(employee_id가 150인 직원)의 매니저 정보 출력.
SELECT employee_id, first_name, last_name
    , manager_id
FROM hr.employees
WHERE employee_id=150;

SELECT employee_id, first_name, last_name
    , manager_id
FROM hr.employees
WHERE employee_id=100;


SELECT employee_id, first_name, last_name
    , manager_id
FROM hr.employees
WHERE manager_id IS NULL;


SELECT e1.employee_id, e1.first_name, e1.last_name
    , e1.manager_id
    , e1.department_id
    , e2.employee_id, e2.first_name, e2.last_name
    , e2.department_id
FROM hr.employees e1, hr.employees e2
WHERE e1.manager_id = e2.employee_id
AND e1.employee_id=150;


SELECT e1.employee_id, e1.first_name, e1.last_name
    , e1.manager_id
    , e1.department_id
    , e2.employee_id, e2.first_name, e2.last_name
    , e2.department_id
FROM hr.employees e1, hr.employees e2
WHERE e1.manager_id = e2.employee_id
AND e1.employee_id=100;


--문제) hr.employees 테이블에서 말단 직원(부하 직원이 없는 직원) 정보 출력.
--자기 자신의 employee_id가 다른 직원의 manager_id에 없는 직원.
--예를 들어, employee_id가 150, 200인 직원은 말단 직원이다.
--89



SELECT employee_id, first_name, last_name, job_id, manager_id, department_id
FROM hr.employees 
WHERE employee_id NOT IN (SELECT manager_id
FROM hr.employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id)
ORDER BY employee_id;



SELECT employee_id, first_name,last_name,job_id, manager_id
FROM hr.employees
WHERE employee_id NOT IN (SELECT DISTINCT manager_id
FROM hr.employees
WHERE manager_id IS NOT NULL)
ORDER BY employee_id;



SELECT employee_id, first_name,last_name,job_id, manager_id
FROM hr.employees e
WHERE NOT EXISTS (SELECT * FROM hr.employees 
                WHERE manager_id=e.employee_id);






-------------------------------------------
--테이블 3개 이상 JOIN

/*
SELECT 컬럼리스트
    FROM 테이블1, 테이블2, 테이블3, ...
    WHERE 테이블1.컬럼명 = 테이블2.컬럼명
            AND 테이블2.컬럼명 = 테이블3.컬럼명
            AND ... ;
*/








/*

1. 조인을 사용하면 테이블 간의 논리적 관계를 기준으로 둘 이상의 테이블에서 데이터를 검색할 수 있다.

INNER JOIN - 공통 값을 가지는 조건을 만족하는 ROW만 출력
OUTER JOIN - 공통 값을 가지는 조건을 만족하는 경우 외에도 출력

EQUI JOIN - =(equal) 연산자를 이용한 조건을 사용한 JOIN
NON-EQUI JOIN - =(equal) 연산자 외의 연산자를 이용한 조건을 사용한 JOIN
SELF JOIN - 자기 자신을 두 개의 가상 테이블로 만들어서 JOIN하는 방법. 별칭 사용.


ANSI JOIN - JOIN 구문을 오라클 방법이 아니라 표준적인 방법으로 작성한 것.



2. employees, departments, job_history, jobs, locations, countries, regions 테이블에서 관계 분석

*/


-------------------------------------------------------------------------------------------------------------------------------
--3.EQUI JOIN

/*
두 개 이상의 테이블에 관계되는 컬럼들의 값들이 일치하는 경우에 사용하는 가장 일반적인 join 형태로 WHERE 절에 '='(등호)를 사용한다. 
흔히 PRIMARY KEY, FOREIGN KEY 관계를 이용하며 오라클에서는 NATURAL JOIN이 EQUI JOIN과 동일하다. 
또는 USING 절을 사용하여 EQUI JOIN과 동일한 결과를 출력 한다.
PRIMARY KEY, FOREIGN KEY 제약이 걸려있는 컬럼은 값들이 일치하도록 되어 있다.


형식-Oracle SQL
/*
SELECT *
   FROM 테이블_명1, 테이블_명2
   WHERE 테이블_명1.컬럼_명1=테이블_명2.컬럼_명1;

SELECT 테이블_명1.컬럼_명, 테이블_명2.컬럼_명 
   FROM 테이블_명1, 테이블_명2
   WHERE 테이블_명1.컬럼_명1=테이블_명2.컬럼_명1;

SELECT 별칭1.컬럼_명, 별칭2.컬럼_명 
   FROM 테이블_명1 별칭1, 테이블_명2 별칭2
   WHERE 별칭1.컬럼_명1=별칭2.컬럼_명1
    AND 조건식
    GROUP BY 컬럼, ...
    ...;

형식-ANSI SQL
SELECT 테이블_명1.컬럼_명, 테이블_명2.컬럼_명 
   FROM 테이블_명1 JOIN 테이블_명2 
   ON 테이블_명1.컬럼_명1=테이블_명2.컬럼_명1
    WHERE 조건식
    GROUP BY 컬럼, ...
    ...;

--PK, FK 제약이 있는 테이블 및 컬럼을 확인하면 JOIN 지정이 쉽게 이루어진다.
--예를들어, hr.employees, hr.departments 테이블이다. 공통 컬럼은 department_id
--JOIN이 이루어지면 hr.employees, hr.departments 테이블이 한 개의 가상 테이블이 된다.
--단, 양쪽 테이블에 모두 존재하는 컬럼인 경우 테이블명 표시 필수.
/*
SELECT *
   FROM 테이블_명1, 테이블_명2
   WHERE 테이블_명1.컬럼_명1=테이블_명2.컬럼_명1;
*/


-------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM hr.departments;
--27

SELECT *
FROM hr.employees;
--107

SELECT *
FROM hr.employees, hr.departments
WHERE hr.employees.department_id = hr.departments.department_id;
--106 (hr.employees테이블에 department_id가 할당되지 않은 사원이 있다.)

SELECT employee_id, first_name, last_name
    , department_name
    , hr.employees.department_id
FROM hr.employees, hr.departments
WHERE hr.employees.department_id = hr.departments.department_id;
-- 106


-- ORACLE JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id;                        -- 테이블 별칭을 통해 코드 줄이기
-- 106 


-- AMSI JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e INNER JOIN hr.departments d
ON e.department_id = d.department_id;
-- 106 


-------------------------------------------------------------------------------------------------------------------------------
-- JOIN(조인 조건) + 일반 조건
SELECT employee_id, first_name, last_name
    , department_id
FROM hr.employees
WHERE department_id = 100;

-- ORACLE SQL
SELECT employee_id, first_name, last_name
    , e.department_id
    , department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id 
AND e.department_id = 100;

-- ANSI SQL
-- (WHERE 와 ON은 동일한 역할을 한다, 그러나 FROM 부터 ON까지를 FROM이라 생각하고 WHERE 절에 조건을 쓴다.)
SELECT employee_id, first_name, last_name
    , e.department_id
    , department_name
FROM hr.employees e INNER JOIN hr.departments d
ON e.department_id = d.department_id 
WHERE e.department_id = 100;


--(문제) hr.employees, hr.jobs 테이블을 조인 지정하고
--, 양쪽테이블 컬럼 정보를 모두 출력

-- ORACLE JOIN
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, salary commission_pct, manager_id, department_id
    ,e.job_id, j.job_title, j.max_salary, j.min_salary 
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id; 

-- ANSI JOIN
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, salary commission_pct, manager_id, department_id
    ,e.job_id, j.job_title, j.max_salary, j.min_salary 
FROM hr.employees e INNER JOIN hr.jobs j
ON e.job_id = j.job_id; 


--(문제) hr.employees, hr.jobs 테이블을 조인 지정하고
-- job_title이 'Stock_Manager'인 직원 정보 출력.
-- ORACLE JOIN
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, salary commission_pct, manager_id, department_id
    ,e.job_id, j.job_title, j.max_salary, j.min_salary 
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id
AND j.job_title = 'Stock Manager';

-- ANSI JOIN
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, salary commission_pct, manager_id, department_id
    ,e.job_id, j.job_title, j.max_salary, j.min_salary 
FROM hr.employees e INNER JOIN hr.jobs j
ON e.job_id = j.job_id
WHERE j.job_title = 'Stock Manager'; 





-------------------------------------------------------------------------------------------------------------------------------
--4. Non-Equi Join(240p) 
/*
- Join 조건에서 = 연산이 아닌 모든 경우를 말한다.
- 비교 대상인 컬럼 간에 연관성이 없어도 가능하다.

SELECT 컬럼리스트(별칭 사용 필요)
   FROM 테이블1 별칭1, 테이블2 별칭2
   WHERE 별칭1.컬럼 <= 별칭2.컬럼;

SELECT 컬럼리스트(별칭 사용 필요)
   FROM 테이블1 별칭1, 테이블2 별칭2
   WHERE 별칭1.컬럼 >= 별칭2.컬럼;
*/


-------------------------------------------------------------------------------------------------------------------------------
-- job_title이 'Stock Manager', 'Stock Clerk'인 직원 정보 출력
SELECT *
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id
AND j.job_title = 'Stock Manager' OR j.job_title = 'Stock Clerk';


-- job_title이 'Stock Manager', 'Stock Clerk'인 직원 정보 출력
SELECT e.employee_id, e.first_name, e.last_name
    , job_title
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id
AND job_title IN ('Stock Manager', 'Stock Clerk');


-------------------------------------------------------------------------------------------------------------------------------
--5. Outer Join (244p)

/*
- 양쪽 테이블에 동일한 값이 존재하는 경우만 출력되는 경우는 Equi Join(Inner Join)이고,
동일한 값이 없어도 한 쪽 테이블의 자료는 모두 출력되는 경우는 Outer Join입니다.

--LEFT OUTER JOIN(테이블2가 NULL이 출력되는 상태)
--테이블1은 전체 출력, 테이블2는 부분 출력(Equi Join 조건 만족하는 경우만 출력)
--짝이 없는 경우 NULL로 출력된다.
--(+)는 NULL 출력 대상쪽에 붙인다.
SELECT 컬럼리스트
   FROM 테이블1 별칭1, 테이블2 별칭2
   WHERE 별칭1.컬럼 = 별칭2.컬럼(+);

--RIGHT OUTER JOIN(테이블1이 NULL이 출력되는 상태)
SELECT 컬럼리스트
   FROM 테이블1 별칭1, 테이블2 별칭2
   WHERE 별칭1.컬럼(+) = 별칭2.컬럼;

--ANSI LEFT OUTER JOIN(테이블1의 자료는 모두 출력)
SELECT 컬럼리스트
   FROM 테이블1 별칭1 LEFT OUTER JOIN 테이블2 별칭2
   ON 별칭1.컬럼 = 별칭2.컬럼;
    
    -- *****************FROM 메인테이블, 보조테이블이라고 기억하면 쉽다!!!!****************
*/

-- Oracle JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id(+);
--107 (NULL값도 출력된다.)

-- ANSI JOIN
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e LEFT OUTER JOIN hr.departments d
ON e.department_id = d.department_id;
-- 107


-- Oracle JOIN
SELECT d.department_id, d.department_name
    , e.employee_id, e.first_name, e.last_name
FROM hr.departments d, hr.employees e
WHERE d.department_id = e.department_id(+);
--122

-- ANSI JOIN
SELECT d.department_id, d.department_name
    , e.employee_id, e.first_name, e.last_name
FROM hr.departments d LEFT OUTER JOIN hr.employees e
ON d.department_id = e.department_id;
--122


-------------------------------------------------------------------------------------------------------------------------------

-- (주의) OUTER JOIN에 사용한 컬럼은 일반 조건식에서도 (+)를 모두 붙여야 한다.
-- Oracle join
SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id(+)
AND d.department_id(+) = 50; -- OUTER JOIN이 요구하는 employee 전체 출력
--107 

SELECT employee_id, first_name, last_name
    , department_name
    , e.department_id
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id(+)
AND d.department_id = 50;   -- INNER JOIN의 결과물로 출력..(department_id 가 50인 경우만.)
-- 45


-- (문제) hr.employees, hr.jobs(job_titel) 테이블에서 Outer JOIN 결과 출력
-- hr.employees 전체 출력 기준
SELECT employee_id, first_name, last_name
    , e.job_id, job_title
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id(+);

-- hr.jobs 전체 출력 기준
SELECT job_title
    , j.job_id, e.employee_id, e.first_name, e.last_name
FROM hr.jobs j, hr.employees e
WHERE e.job_id = j.job_id(+);


--(문제) 말단 직원(부하 직원이 없는 직원) 정보 출력
-- 자기 자신의 employee_id가 상대방 manager_id에 없는 직원
-- 예를 들어, employee_id가 150, 200인 직원은 말단 직원이다.
-- SELF JOIN + OUTER JOIN
select e1.employee_id, e1.first_name, e1.last_name, e2.manager_id
from hr.employees e1, hr.employees e2
where e1.employee_id = e2.manager_id(+)
and e2.manager_id is null;


-------------------------------------------------------------------------------------------------------------------------------
--6. Self Join (255p)

/*
- 일반적인 Join은 두 개의 서로 다른 테이블을 대상으로 Join을 하지만,
Self Join은 자기 자신을 가상의 테이블(테이블1, 테이블2가 모두 자기 자신인 상태)로 생각하고 Join을 진행하는 것.
- 별칭 사용 필수

SELECT 컬럼리스트
   FROM 테이블 별칭1, 테이블 별칭2
   WHERE 별칭1.컬럼 = 별칭2.컬럼;

SELECT 컬럼리스트
   FROM 테이블 별칭1, 테이블 별칭2
   WHERE 별칭1.컬럼 <= 별칭2.컬럼;

SELECT 컬럼리스트
   FROM 테이블 별칭1, 테이블 별칭2
   WHERE 별칭1.컬럼 >= 별칭2.컬럼;
*/


SELECT e1.employee_id, e1.first_name, e1.last_name
    , e2.employee_id, e2.first_name, e2.last_name
FROM hr.employees e1, hr.employees e2
WHERE e1.salary = e2.salary;


-- hr.employees 테이블에서 employee_id가 150인 직원의 급여와 같은 급여를 받는 직원 정보
SELECT e1.employee_id, e1.first_name, e1.last_name, e1.salary
    , e2.employee_id, e2.first_name, e2.last_name, e2.job_id, e2.department_id
FROM hr.employees e1, hr.employees e2
WHERE e1.salary = e2.salary
AND e1.employee_id = 150;                                                           -- 4명


-- Non-Equi Join
-- hr.employees 테이블에서 employee_id가 150인 직원의 급여보다 더 많은 급여를 받는 직원 정보
SELECT e1.employee_id, e1.first_name, e1.last_name, e1.salary
    , e2.employee_id, e2.first_name, e2.last_name, e2.job_id, e2.department_id, e2.salary
FROM hr.employees e1, hr.employees e2
WHERE e1.salary <= e2.salary
AND e1.employee_id = 150;                                                           -- 19명


-- hr.employees 테이블에서 특정인(employee_id가 150)의 매니저(직속 상사) 정보 출력.
SELECT employee_id, first_name, last_name
    , manager_id
FROM hr.employees
WHERE employee_id = 150;


SELECT e1.employee_id, e1.first_name, e1.last_name
    , e1.manager_id
    , e1.department_id
    , e2.employee_id, e2.first_name, e2.last_name
    , e2.department_id
FROM hr.employees e1, hr.employees e2
WHERE e1.manager_id = e2.employee_id 
AND e1.employee_id = 150;                                            -- 150   Peter   Tucker   145   80   145   John   Russell   80


SELECT e1.employee_id, e1.first_name, e1.last_name
    , e1.manager_id
    , e1.department_id
    , e2.employee_id, e2.first_name, e2.last_name
    , e2.department_id
FROM hr.employees e1, hr.employees e2
WHERE e1.manager_id = e2.employee_id 
AND e1.employee_id = 100;                                            -- (결과 없음)가장 높음 = 사장

-- 최고 상급자 출력문
SELECT employee_id, first_name, last_name
    , manager_id
FROM hr.employees
WHERE manager_id IS NULL;


--(문제) 말단 직원(부하 직원이 없는 지원) 정보 출력
-- 자기 자신의 employee_id가 상대방 manager_id에 없는 직원
-- 예를 들어, employee_id가 150, 200인 직원은 말단 직원이다.

SELECT employee_id, first_name, last_name, manager_id
FROM hr.employees
WHERE employee_id NOT IN (SELECT manager_id
FROM hr.employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id)
ORDER BY employee_id;


SELECT employee_id, first_name, last_name, manager_id
FROM hr.employees
WHERE employee_id NOT IN (SELECT DISTINCT manager_id
FROM hr.employees
WHERE manager_id IS NOT NULL)
ORDER BY employee_id;


SELECT employee_id, first_name, last_name, manager_id
FROM hr.employees e
WHERE NOT EXISTS (SELECT * FROM hr.employees WHERE manager_id = e.employee_id);



-------------------------------------------------------------------------------------------------------------------------------
--테이블 3개 이상 JOIN (238p 아래)

/*
SELECT 컬럼리스트
    FROM 테이블1, 테이블2, 테이블3, ...
    WHERE 테이블1.컬럼명 = 테이블2.컬럼명
            AND 테이블2.컬럼명 = 테이블3.컬럼명
            AND ... ;
*/


SELECT e.employee_id, e.first_name, e.last_name
    , j.job_title
    , d.department_name
FROM hr.employees e, hr.jobs j, hr.departments d
WHERE e.job_id = j.job_id
AND e.department_id = d.department_id;


SELECT e.employee_id, e.first_name, e.last_name
    , j.job_title
    , d.department_name
    , l.city
FROM hr.employees e, hr.jobs j, hr.departments d, hr.locations l
WHERE e.job_id = j.job_id
AND e.department_id = d.department_id
AND d.location_id = l.location_id;






-------------------------------------------------------------------------------------------------------------------------------
--JOIN 문제 풀이 (HR 스키마 이용)


-1. hr.departments, hr.employees 테이블. 부서명(department_name), 부서장의 이름(first_name, last_name) 출력. 조인 쿼리 이용.
--JOIN 쿼리 이용한 경우
SELECT department_name
    , first_name, last_name
FROM hr.departments d, hr.employees e
WHERE d.department_id = e.department_id
AND d.manager_id = e.employee_id;


--서브 쿼리 이용한 경우
SELECT first_name, last_name
    , (SELECT department_name
        FROM hr.departments
        WHERE department_id = e.department_id) department_name
FROM hr.employees e
WHERE employee_id = (SELECT manager_id
                        FROM hr.departments
                        WHERE department_id = e.department_id);


--2. hr.employees, hr.jobs 테이블. 'Neena', 'Kochhar' 직원의 직무명(job_title)까지 출력. 조인 쿼리 이용.
--JOIN 쿼리 이용한 경우
SELECT employee_id, first_name, last_name 
    , job_title
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id
AND first_name = 'Neena';

--서브 쿼리 이용한 경우
SELECT employee_id, first_name, last_name 
    , (SELECT job_title
        FROM hr.jobs
        WHERE job_id = e.job_id) job_title
FROM hr.employees e
WHERE first_name = 'Neena';


--3. hr.employees, hr.jobs 테이블. 직위명(job_title)별 최소급여(min_salary)를 받는 직원 출력. 조인 쿼리 이용.
--JOIN 쿼리 이용한 경우
SELECT first_name, last_name, j.job_id, job_title, j.min_salary, salary
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id
AND e.salary = j.min_salary;

--서브 쿼리 이용한 경우
SELECT employee_id, first_name, last_name
    , job_id, salary
FROM hr.employees
WHERE (job_id, salary) IN (SELECT job_id, min_salary
FROM hr.jobs);


--4. hr.jobs, hr.employees 테이블. 직위명(job_title)별 직원의 수 출력. 조인 쿼리 이용.
--JOIN 쿼리 이용한 경우
SELECT job_title, COUNT(*) 직원의수
FROM hr.employees e, hr.jobs j
WHERE e.job_id = j.job_id
GROUP BY job_title;

--서브 쿼리 이용한 경우
SELECT (SELECT j.job_title FROM hr.jobs j WHERE e.job_id = j.job_id)
    , COUNT(*)
FROM hr.employees e
GROUP BY e.job_id;


--5. hr.employees, hr.departments 테이블에서 'David', 'Austin' 직원이 속한 부서명(department_name), 부서장(manager)이름(first_name, last_name) 출력. 조인 쿼리 이용.
--JOIN 쿼리 이용한 경우
SELECT department_name
    , e2.first_name, e2.last_name
FROM hr.employees e1, hr.employees e2, hr.departments d
WHERE e1.department_id = d.department_id
AND e2.department_id = d.department_id
AND e1.first_name = 'David'
AND e1.last_name = 'Austin'
AND d.manager_id = e2.employee_id;


--서브 쿼리 이용한 경우
SELECT (SELECT department_name
        FROM hr.departments
        WHERE department_id = e.department_id) department_name
    ,first_name, last_name
FROM hr.employees e
WHERE employee_id = (SELECT manager_id
                        FROM hr.departments d
                        WHERE department_id = (SELECT department_id
                                                FROM hr.employees
                                                WHERE department_id = d.department_id
                                                AND first_name = 'David'
                                                AND last_name = 'Austin'));




--6. hr.employees 테이블에서 'Steven', 'King' 직원의 부하 직원 출력. 셀프 조인.
--JOIN 쿼리 이용한 경우
SELECT e2.employee_id, e2.first_name, e2.last_name
FROM hr.employees e1, hr.employees e2
WHERE e1.employee_id = e2.manager_id
AND e1.first_name = 'Steven';


--서브 쿼리 이용한 경우
SELECT employee_id, first_name, last_name, e1.manager_id
FROM hr.employees e1
WHERE e1.manager_id IN (SELECT e2.employee_id
FROM hr.employees e2
WHERE e2.first_name = 'Steven');


--7. hr.employees, hr.jobs, hr.job_history 테이블. employee_id가 101인 직원의 잡히스토리(first_name, last_name, start_date, end_date, job_title) 출력.
--JOIN 쿼리 이용한 경우
SELECT first_name, last_name, start_date, end_date, job_title
FROM hr.employees e, hr.jobs j, hr.job_history h
WHERE e.job_id = j.job_id
AND e.employee_id = h.employee_id
AND e.employee_id = '101';



--서브 쿼리 이용한 경우
SELECT (SELECT first_name
        FROM hr.employees
        WHERE employee_id = h.employee_id) first_name
        , (SELECT last_name
        FROM hr.employees
        WHERE employee_id = h.employee_id) last_name
        , start_date, end_date
        , (SELECT job_title
        FROM hr.jobs
        WHERE job_id = h.job_id) job_title
FROM hr.job_history h
WHERE employee_id = '101';




--8. hr.employees 테이블에서 부하 직원이 없는 직원 출력.
--JOIN 쿼리 이용한 경우
SELECT e1.employee_id, e1.first_name, e1.last_name
FROM hr.employees e1, hr.employees e2
WHERE e1.employee_id = e2.manager_id(+)
AND e2.manager_id IS NULL;

--서브 쿼리 이용한 경우
SELECT employee_id, first_name, last_name, manager_id
FROM hr.employees e
WHERE NOT EXISTS (SELECT * FROM hr.employees WHERE manager_id = e.employee_id);



--9. hr.employees 테이블에서 특정 직원(first_name이 'Gerald', last_name이 'Cambrault'인 직원)의 salary보다 급여를 더 많이 받는 직원 정보 출력.
--JOIN 쿼리 이용한 경우
SELECT e2.employee_id, e2.first_name, e2.last_name, e2.salary
FROM hr.employees e1, hr.employees e2
WHERE e1.salary <= e2.salary
AND e1.first_name = 'Gerald';



--서브 쿼리 이용한 경우
SELECT employee_id, first_name, last_name, salary
FROM hr.employees e
WHERE salary >= (SELECT salary
                    FROM hr.employees
                    WHERE first_name = 'Gerald'
                    AND last_name = 'Cambrault');




