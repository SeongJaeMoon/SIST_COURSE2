#---------------------------------
#MySQL Workbench
#---------------------------------
#classicmodels.employees 테이블에서 jobtitle 컬럼의 정보가 'Sales Rep'인 경우 출력.
SELECT 
    lastname, firstname, jobtitle
FROM
    classicmodels.employees
WHERE
    jobtitle = 'Sales Rep';
    
 
#classicmodels.employees 테이블에서 jobtitle 컬럼의 정보가 'Sales Rep'이면서, officeCode 컬럼의 정보가 1인 경우 경우 출력.
SELECT 
    lastname, firstname, jobtitle, officeCode
FROM
    classicmodels.employees
WHERE
    jobtitle = 'Sales Rep' AND officeCode = 1; 
    
#classicmodels.employees 테이블에서 jobtitle 컬럼의 정보가 'Sales Rep'가 아닌 경우 출력.
SELECT 
    lastname, firstname, jobtitle
FROM
    classicmodels.employees
WHERE
    jobtitle <> 'Sales Rep';
    
#classicmodels.employees 테이블에서 officeCode 컬럼의 정보가 5보다 큰 경우 경우 출력.
SELECT 
    lastname, firstname, officeCode
FROM
   classicmodels.employees
WHERE officecode > 5;
    
    
#classicmodels.employees 테이블에서 officeCode 컬럼의 정보가 5보다 크거나 같은 경우 경우 출력.
SELECT 
    lastname, firstname, officeCode
FROM
   classicmodels.employees
WHERE officecode >= 5;

#------------------------------------
#classicmodels.customers 테이블에서 country 컬럼의 정보가 'USA'이면서, state 컬럼의 정보가 'CA'인 경우 출력.
SELECT 
    customername, 
    country, 
    state
FROM
    classicmodels.customers
WHERE
    country = 'USA' AND state = 'CA';
    
#classicmodels.customers 테이블에서 country 컬럼의 정보가 'USA'이면서, state 컬럼의 정보가 'CA'이고, creditlimit 컬럼의 정보가 100000 보다 큰 경우 출력.
SELECT   customername,
         country,
         state,
         creditlimit
FROM classicmodels.customers
WHERE country = 'USA'
        AND state = 'CA'
        AND creditlimit > 100000;    
    
    
#------------------------------------------
#classicmodels.customers 테이블에서 country 컬럼의 정보가 'USA'이거나, 'France'인 경우 출력.
SELECT 
    customername, country
FROM
    classicmodels.customers
WHERE
    country = 'USA' OR country = 'France';
    

#classicmodels.customers 테이블에서 country 컬럼의 정보가 'USA'이거나, 'France'이면서, creditlimit 컬럼의 정보가 100000 보다 큰 경우 출력.
#주의) 연산자 우선 순위를 위해서 ( ) 표기 필요.
SELECT 
    customername, country, creditLimit
FROM
    classicmodels.customers
WHERE
    (country = 'USA' OR country = 'France')
        AND creditlimit > 100000;    

#-----------------------------------------
#classicmodels.offices 테이블에서 country 컬럼의 정보가 'USA'이거나, 'France'인 경우 출력.
SELECT 
    officeCode, city, phone, country
FROM
    classicmodels.offices
WHERE
    country IN ('USA' , 'France');
    
#classicmodels.offices 테이블에서 country 컬럼의 정보가 'USA'이거나, 'France'인 경우를 제외한 나머지 출력.
SELECT 
    officeCode, city, phone, country
FROM
    classicmodels.offices
WHERE
    country NOT IN ('USA' , 'France');    
 

#서브쿼리를 이용한 고객의 주문 내역 확인 쿼리 

#서브쿼리 : orderNumber를 기준으로 그룹핑하고, 결제금액(SUM(quantityOrdered * priceEach))이 60000보다 큰 경우 출력.
SELECT 
    orderNumber, SUM(quantityOrdered * priceEach)
FROM
    classicmodels.orderDetails
GROUP BY orderNumber
HAVING SUM(quantityOrdered * priceEach) > 60000;
        
#결제금액이 일정액 이상인 경우의 고객 정보 출력.        
SELECT 
    orderNumber, customerNumber, status, shippedDate
FROM
    classicmodels.orders
WHERE
    orderNumber IN (SELECT 
            orderNumber
        FROM
            classicmodels.orderDetails
        GROUP BY orderNumber
        HAVING SUM(quantityOrdered * priceEach) > 60000); 
        
#--------------------------------------------
      
#classicmodels.products 테이블에서 buyPrice 컬럼의 정보가 90부터 100까지의 값을 가지는 경우 출력.
SELECT 
    productCode, productName, buyPrice
FROM
    classicmodels.products
WHERE
    buyPrice BETWEEN 90 AND 100;
    
#classicmodels.products 테이블에서 buyPrice 컬럼의 정보가 20부터 100까지의 값이 아닌 경우 출력.
SELECT 
    productCode, productName, buyPrice
FROM
    classicmodels.products
WHERE
    buyPrice NOT BETWEEN 20 AND 100;    
    
#classicmodels.orders 테이블에서 requireddate 컬럼의 정보가 '2003-01-01'부터 '2003-01-31'까지의 경우 출력.
#주의) CAST() 함수는 형변환 함수이다.
SELECT 
    orderNumber, requiredDate, status
FROM
    classicmodels.orders
WHERE
    requireddate BETWEEN CAST('2003-01-01' AS DATE) AND CAST('2003-01-31' AS DATE);
    
#-----------------------------------------
#classicmodels.employees 테이블에서 firstName 컬럼의 정보가 'a'로 시작하는 경우 출력.    
#주의) 문자 비교시 대소문자를 구분하지 않는다.
SELECT 
    employeeNumber, lastName, firstName
FROM
    classicmodels.employees
WHERE
    firstName LIKE 'a%';
    
  
#classicmodels.employees 테이블에서 lastName 컬럼의 정보가 'on'로 끝나는 경우 출력.    
#주의) 문자 비교시 대소문자를 구분하지 않는다.
SELECT 
    employeeNumber, lastName, firstName
FROM
    classicmodels.employees
WHERE
    lastName LIKE '%on';
    
    
#classicmodels.employees 테이블에서 lastName 컬럼의 정보에 'on'이 포함된 경우 출력.    
#주의) 문자 비교시 대소문자를 구분하지 않는다.
SELECT 
    employeeNumber, lastName, firstName
FROM
    classicmodels.employees
WHERE
    lastname LIKE '%on%';
    
    
#classicmodels.employees 테이블에서 lastName 컬럼의 정보가 'B'로 시작하지 않는 경우 출력.    
#주의) 문자 비교시 대소문자를 구분하지 않는다.
SELECT 
    employeeNumber, lastName, firstName
FROM
    classicmodels.employees
WHERE
    lastName NOT LIKE 'B%';


#특수문자가 포함된 경우 와일드 카드 문자와의 충돌을 피하는 방법    
SELECT 
    productCode, productName
FROM
    classicmodels.products
WHERE
    productCode LIKE '%$_20%' ESCAPE '$';
    

#--------------------------------------
#classicmodels.customers 테이블 정보 출력시 특정 번째까지만 출력.
#주의) LIMIT 구문은 쿼리 마지막 위치에만 표기.
SELECT 
    customernumber, customername, creditlimit
FROM
    classicmodels.customers
LIMIT 10;


#classicmodels.customers 테이블 정보 출력시 creditlimit 컬럼을 기준으로 내림차순 정렬하고, 특정 번째까지만 출력.
#주의) LIMIT 구문은 쿼리 마지막 위치에만 표기.
SELECT 
    customernumber, customername, creditlimit
FROM
    classicmodels.customers
ORDER BY creditlimit DESC
LIMIT 5;


#classicmodels.products 테이블에서 buyPrice 컬럼의 정보를 내림차순 정렬하고, 1번째 ROW만 출력.
#주의) LIMIT 구문은 쿼리 마지막 위치에만 표기.
#주의) LIMIT 구문에서 offset 생략시 0으로 지정된 상태.
SELECT
 productName,
 buyprice
FROM
 classicmodels.products
ORDER BY
 buyprice DESC
LIMIT 1;


#classicmodels.products 테이블에서 buyPrice 컬럼의 정보를 내림차순 정렬하고, 2번째 ROW만 출력.
#주의) LIMIT 구문은 쿼리 마지막 위치에만 표기.
#주의) LIMIT 구문에서 offset 지정시 해당 ROW를 건너뛴다.
#주의) 웹 페이지 출력시 페이지 액션에서 사용하는 쿼리.
SELECT 
    productName, buyprice
FROM
    classicmodels.products
ORDER BY buyprice DESC
LIMIT 1 , 1;


#------------------------------------
#classicmodels.customers 테이블의 정보에서 salesrepemployeenumber 컬럼의 정보가 NULL인 경우만 출력. customerName 컬럼 기준으로 오름차순 정렬 지원.`
#MySql에서는 자료형(숫자, 문자, 날짜) 구분 없이 NULL 값 저장 가능.
SELECT 
    customerName, country, salesrepemployeenumber
FROM
    classicmodels.customers
WHERE
    salesrepemployeenumber IS NULL
ORDER BY customerName; 


#classicmodels.customers 테이블의 정보에서 salesrepemployeenumber 컬럼의 정보가 NULL이 아닌 경우만 출력. customerName 컬럼 기준으로 오름차순 정렬 지원.`
#MySql에서는 자료형(숫자, 문자, 날짜) 구분 없이 NULL 값 저장 가능.
#주의) NOT IS NULL이 아니라 IS NOT NULL이다.
SELECT 
    customerName, country, salesrepemployeenumber
FROM
    classicmodels.customers
WHERE
    salesrepemployeenumber IS NOT NULL
ORDER BY customerName;


#테이블 생성
#AUTO_INCREMENT : 자동 번호 부여. 단, 1, 2, 3 형태로만 증가된다. 자료형은 INT만 지원.
CREATE TABLE IF NOT EXISTS projects (
    id INT AUTO_INCREMENT,
    title VARCHAR(255),
    begin_date DATE NOT NULL,
    complete_date DATE NOT NULL,
    PRIMARY KEY(id)
);
 
#다량의 ROW를 한 번에 입력하는 쿼리 
#주의) Auto Commit 상태
#주의) id 컬럼은 번호가 자동 증가된다.
#주의) complete_date 컬럼은 NOT NULL 제약이 지정된 상태이다.
INSERT INTO projects(title,begin_date, complete_date)
VALUES('New CRM','2020-01-01','0000-00-00'),
      ('ERP Future','2020-01-01','0000-00-00'),
      ('VR','2020-01-01','2030-01-01');

SELECT 
    *
FROM
    projects;
 

#projects 테이블에서 complete_date 컬럼의 정보가 NULL인 경우 출력.
#주의) 날짜 자료형 컬럼에 입력된 '0000-00-00' 자료는 NULL로 인정된다.
SELECT 
    *
FROM
    projects
WHERE
    complete_date IS NULL;
    
SELECT 
    *
FROM
    projects
WHERE
    complete_date = '0000-00-00';    
    


#------------------------------
#classicmodels.customers 테이블 정보 출력시 contactLastname 컬럼의 정보를 기준으로 오름차순 정렬 지원.
#주의) ASC 키워드는 생략 가능.
SELECT 
    contactLastname, contactFirstname
FROM
    classicmodels.customers
ORDER BY contactLastname;


#classicmodels.customers 테이블 정보 출력시 contactLastname 컬럼의 정보를 기준으로 내림차순 정렬 지원.
SELECT 
    contactLastname, contactFirstname
FROM
    classicmodels.customers
ORDER BY contactLastname DESC;



#classicmodels.customers 테이블 정보 출력시 contactLastname 컬럼의 정보를 1차 기준으로 내림차순 정렬, contactFirstname 컬럼의 정보를 2차 기준으로 오름차순 지원.
SELECT 
    contactLastname, contactFirstname
FROM
    classicmodels.customers
ORDER BY contactLastname DESC , contactFirstname ASC;


#ORDER BY 구문에서 컬럼 출력시 사용하는 별칭을 사용할 수 있다.
SELECT 
    ordernumber,
    orderlinenumber,
    quantityOrdered * priceEach AS subtotal
FROM
    classicmodels.orderdetails
ORDER BY ordernumber , orderLineNumber , subtotal;


#FILED() 함수를 이용한 사용자 정의 정렬 순서 지정
SELECT 
    orderNumber, status
FROM
    classicmodels.orders
ORDER BY FIELD(status,
        'In Process',
        'On Hold',
        'Cancelled',
        'Resolved',
        'Disputed',
        'Shipped');


#테이블 생성
#AUTO_INCREMENT : 자동 번호 부여. 단, 1, 2, 3 형태로만 증가된다. 자료형은 INT만 지원.
CREATE TABLE IF NOT EXISTS items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item_no VARCHAR(255) NOT NULL
);

#다량의 ROW를 한 번에 입력하는 쿼리 
#주의) Auto Commit 상태
#주의) id 컬럼은 번호가 자동 증가된다.
INSERT INTO items(item_no)
VALUES('A-1'),
      ('A-2'),
      ('A-3'),
      ('A-4'),
      ('A-5'),
      ('A-10'),
      ('A-11'),
      ('A-20'),
      ('A-30');
      
SELECT 
    item_no
FROM
    items
ORDER BY item_no;
#출력결과가 
#A-1, A-10, A-11, A-2, A-20
#형태로 정렬되어서 출력된다.

#LENGTH() 함수는 문자열의 글자수 반환하는 함수.
SELECT 
    item_no
FROM
    items
ORDER BY LENGTH(item_no) , item_no;
#출력결과가 
#A-1, A-2, A-10, A-11, A-20
#형태로 정렬되어서 출력된다.

#items 테이블의 자료를 모두 삭제. 테이블 구조는 남아 있다.
TRUNCATE TABLE items;

INSERT INTO items(item_no)
VALUES('A-01'),
      ('A-02'),
      ('A-03'),
      ('A-04'),
      ('A-05'),
      ('A-10'),
      ('A-11'),
      ('A-20'),
      ('A-30');
      
      
SELECT 
    item_no
FROM
    items
ORDER BY item_no;
#출력결과가 
#A-01, A-02, A-10, A-11, A-20
#형태로 정렬되어서 출력된다.    
  
#----------------------------------

#classicmodels.orders 테이블에서 status 컬럼의 정보를 그룹핑(중복 제거)하고 출력.
#주의) 정렬된 상태로 출력된다.
SELECT 
    status
FROM
    classicmodels.orders
GROUP BY status;

#classicmodels.orders 테이블에서 status 컬럼의 정보를 중복 제거하고 출력.
SELECT DISTINCT
    status
FROM
    classicmodels.orders;
    
    
#classicmodels.orders 테이블에서 status 컬럼의 정보를 그룹핑하고, 복수행 함수(COUNT) 결과를 같이 출력.
#COUNT() 함수는 건수를 반환하는 함수.
#주의) 정렬된 상태로 출력된다.
#주의) 경우의 수별 건수 출력 액션이 된다.
SELECT 
    status, COUNT(*)
FROM
    classicmodels.orders
GROUP BY status;

 
#classicmodels.orders 테이블과 classicmodels.orderdetails 테이블을 INNER JOIN한 상태에서 그룹핑하고, 복수행 함수 결과를 같이 출력.
#SUM() 함수는 숫자 자료형의 총합을 반환하는 함수 
SELECT 
    status, COUNT(*), SUM(quantityOrdered * priceEach) AS amount
FROM
    classicmodels.orders
        INNER JOIN
    classicmodels.orderdetails USING (orderNumber)
GROUP BY status;
    

#classicmodels.orderdetails 테이블에서 orderNumber별로 그룹핑하고, 주문총액을 같이 출력.
SELECT 
    orderNumber,
    SUM(quantityOrdered * priceEach) AS total
FROM
    classicmodels.orderdetails
GROUP BY orderNumber;


#classicmodels.orders 테이블과 classicmodels.orderdetails 테이블을 INNER JOIN한 상태에서, status 컬럼의 정보가 'Shipped'인 ROW만 추출, 그룹핑하고, 복수행 함수 결과를 같이 출력.
#YEAR() 함수는 날짜 자료형 자료에서 년도만 추출하는 함수.
SELECT 
    YEAR(orderDate) AS year,
    SUM(quantityOrdered * priceEach) AS total
FROM
    classicmodels.orders
        INNER JOIN
    classicmodels.orderdetails USING (orderNumber)
WHERE
    status = 'Shipped'
GROUP BY YEAR(orderDate);


#classicmodels.orders 테이블과 classicmodels.orderdetails 테이블을 INNER JOIN한 상태에서, status 컬럼의 정보가 'Shipped'인 ROW만 추출, 그룹핑하고, 복수행 함수 결과를 같이 출력. 복수행 함수의 결과 2003 보다 큰 경우만 출력되도록 조건 추가.
#YEAR() 함수는 날짜 자료형 자료에서 년도만 추출하는 함수.
#주의) 컬럼 별칭을 GROUP BY, HAVING 구문에서 사용 가능
SELECT 
    YEAR(orderDate) AS year,
    SUM(quantityOrdered * priceEach) AS total
FROM
    classicmodels.orders
        INNER JOIN
    classicmodels.orderdetails USING (orderNumber)
WHERE
    status = 'Shipped'
GROUP BY year
HAVING year > 2003;


#INNER JOIN, 그룹핑(ordernumber , status), 복수행 함수, status = 'Shipped' AND total > 1500 조건 만족하는 경우만 출력.
#주의) status = 'Shipped' 조건은 WHERE 구문 사용이 더 효과적이다. 단, 출력 대상에 status 컬럼을 포함시키려면 GROUP BY 구문에 지정해야 한다.
SELECT 
    a.ordernumber,
    status,
    SUM(priceeach * quantityOrdered) total
FROM
    classicmodels.orderdetails a
        INNER JOIN
    classicmodels.orders b ON b.ordernumber = a.ordernumber
GROUP BY ordernumber , status
HAVING status = 'Shipped' AND total > 1500;


#GROUP BY 구문은 내부적으로 정렬을 지원하는데 내림차순 정렬을 지정할 수 있다.
SELECT 
    status, COUNT(*)
FROM
    classicmodels.orders
GROUP BY status DESC;


#---------------------------------------------
