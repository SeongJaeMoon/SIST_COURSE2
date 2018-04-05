#---------------------------------
#MySQL Workbench
#---------------------------------
#classicmodels.employees 테이블 전체 컬럼 정보 출력
SELECT 
    *
FROM
    classicmodels.employees;


#classicmodels.employees 테이블 특정 컬럼 정보 출력
SELECT 
    lastname, firstname, jobtitle
FROM
    classicmodels.employees;
    
    
#---------------------------------
#classicmodels.employees 테이블 특정 컬럼의 중복 제거된 정보 출력 및 정렬 지원
SELECT DISTINCT
    lastname
FROM
    classicmodels.employees
ORDER BY lastname;


#classicmodels.employees 테이블 특정 컬럼의 중복 제거된 정보 출력 및 정렬 지원. state 컬럼 정보가 NULL인 경우 제외.
SELECT DISTINCT
    state, city
FROM
    classicmodels.customers
WHERE
    state IS NOT NULL
ORDER BY state , city;


#---------------------------------
#classicmodels.employees 테이블 특정 컬럼 정보 출력. 전체 ROWS 출력.
SELECT 
    lastname, firstname, jobtitle
FROM
    classicmodels.employees;
    
    
#classicmodels.employees 테이블 특정 컬럼 정보 출력. 5순위까지의 ROW만 출력.
SELECT 
    lastname, firstname, jobtitle
FROM
    classicmodels.employees
LIMIT 5;
