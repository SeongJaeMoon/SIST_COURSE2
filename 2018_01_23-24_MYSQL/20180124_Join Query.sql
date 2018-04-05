#---------------------------------
#MySQL Workbench
#---------------------------------

#---------------------------------
CREATE TABLE t1 (
    id INT PRIMARY KEY,
    pattern VARCHAR(50) NOT NULL
);
 
CREATE TABLE t2 (
    id VARCHAR(50) PRIMARY KEY,
    pattern VARCHAR(50) NOT NULL
);

INSERT INTO t1(id, pattern)
VALUES(1,'Divot'),
      (2,'Brick'),
      (3,'Grid');
 
INSERT INTO t2(id, pattern)
VALUES('A','Brick'),
      ('B','Grid'),
      ('C','Diamond');
      
SELECT * FROM t1;
SELECT * FROM t2;


#---------------------------
SELECT 
    t1.id, t2.id
FROM
    t1
        CROSS JOIN
    t2;


#---------------------------
SELECT 
    t1.id, t2.id
FROM
    t1
        INNER JOIN
    t2 ON t1.pattern = t2.pattern;
    
    
SELECT 
    productCode, productName, textDescription
FROM
    classicmodels.products t1
        INNER JOIN
    classicmodels.productlines t2 ON t1.productline = t2.productline;    
    
    
#USING 키워드는 JOIN 구문에서 조인 조건 지정시 같은 컬럼이 사용되는 경우 USING(컬럼명)으로 대체 가능.    
#주의) 테이블 별칭 사용하지 않는다.
SELECT 
    productCode, productName, textDescription
FROM
    classicmodels.products
        INNER JOIN
    classicmodels.productlines USING (productline);    
    

#주의) 테이블 별칭 사용시 AS 키워드 생략 가능    
SELECT 
    T1.orderNumber,
    status,
    SUM(quantityOrdered * priceEach) total
FROM
    classicmodels.orders AS T1
        INNER JOIN
    classicmodels.orderdetails AS T2 ON T1.orderNumber = T2.orderNumber
GROUP BY orderNumber;


#USING 키워드는 JOIN 구문에서 조인 조건 지정시 같은 컬럼이 사용되는 경우 USING(컬럼명)으로 대체 가능.    
#주의) 테이블 별칭 사용하지 않는다.
SELECT 
    orderNumber, status, SUM(quantityOrdered * priceEach) total
FROM
    classicmodels.orders
        INNER JOIN
    classicmodels.orderdetails USING (orderNumber)
GROUP BY orderNumber;
    

#조인 조건 지정시 = 연산자만이 아니라 >, <, >=, <=, <>, != 등의 연산자도 사용 가능.    
SELECT 
    orderNumber, productName, msrp, priceEach
FROM
    classicmodels.products p
        INNER JOIN
    classicmodels.orderdetails o ON p.productcode = o.productcode
        AND p.msrp > o.priceEach;
        
SELECT 
    orderNumber, productName, msrp, priceEach
FROM
    classicmodels.products p
        INNER JOIN
    classicmodels.orderdetails o ON p.productcode = o.productcode
        AND p.msrp > o.priceEach
WHERE
    p.productcode = 'S10_1678';    
    
    
    
    
#---------------------------
SELECT 
    t1.id, t2.id
FROM
    t1
        LEFT JOIN
    t2 ON t1.pattern = t2.pattern
ORDER BY t1.id;



SELECT 
    c.customerNumber, c.customerName, orderNumber, o.status
FROM
    classicmodels.customers c
        LEFT JOIN
    classicmodels.orders o ON c.customerNumber = o.customerNumber;


#USING 키워드는 JOIN 구문에서 조인 조건 지정시 같은 컬럼이 사용되는 경우 USING(컬럼명)으로 대체 가능.    
#주의) 테이블 별칭 사용하지 않는다.
SELECT 
    customerNumber, customerName, orderNumber, status
FROM
    classicmodels.customers
        LEFT JOIN
    classicmodels.orders USING (customerNumber);


#주문 내역이 없는 고객 정보 출력하는 LEFT JOIN 쿼리
SELECT 
    c.customerNumber, c.customerName, orderNumber, o.status
FROM
    classicmodels.customers c
        LEFT JOIN
    classicmodels.orders o ON c.customerNumber = o.customerNumber
WHERE
    orderNumber IS NULL;




#------------------------------
SELECT 
    t1.id, t2.id
FROM
    t1
        RIGHT JOIN
    t2 ON t1.pattern = t2.pattern
ORDER BY t2.id;

    
    
    
#--------------------------------
#SELF JOIN인 경우 테이블 별칭 사용 필수.
#CONCAT() 함수는 두 개의 문자열을 하나의 문자열로 결합하는 함수. 중간에 삽입되는 문자열 추가 가능. 예를 들어 'HONG/GILDONG' 문자열에서 '/'가 중간 삽입된 문자열이다.
#컬럼 별칭 사용시 공백 등의 문자가 포함되는 경우 ''로 감싸야 한다. 예를 들어, 'Direct report' 형태로 표기.
#주의) 컬럼 별칭 사용시 AS 키워드 생략 가능.
SELECT 
    CONCAT(m.lastname, ', ', m.firstname) AS 'Manager',
    CONCAT(e.lastname, ', ', e.firstname) AS 'Direct report'
FROM
    classicmodels.employees e
        INNER JOIN
    classicmodels.employees m ON m.employeeNumber = e.reportsto
ORDER BY manager;
    

#LEFT JOIN인 경우 결과에서 Manager 항목에 NULL인 경우가 발생한다.
SELECT 
    CONCAT(m.lastname, ', ', m.firstname) AS 'Manager',
    CONCAT(e.lastname, ', ', e.firstname) AS 'Direct report'
FROM
    classicmodels.employees e
        LEFT JOIN
    classicmodels.employees m ON m.employeeNumber = e.reportsto
ORDER BY manager;


#IFNULL() 함수는 NULL 검사하는 함수. 만약 NULL인 경우 대체값 반환.
SELECT 
    IFNULL(CONCAT(m.lastname, ', ', m.firstname), 'Top Manager') AS 'Manager',
    CONCAT(e.lastname, ', ', e.firstname) AS 'Direct report'
FROM
    classicmodels.employees e
        LEFT JOIN
    classicmodels.employees m ON m.employeeNumber = e.reportsto
ORDER BY manager DESC;


#SELF JOIN 결과에서 자기 자신도 출력된다.
SELECT 
    c1.city, c1.customerName, c2.customerName
FROM
    classicmodels.customers c1
        INNER JOIN
    classicmodels.customers c2 ON c1.city = c2.city
ORDER BY c1.city;


#SELF JOIN 결과에서 자기 자신을 제외하고 출력하려면, 추가 조건 지정.
SELECT 
    c1.city, c1.customerName, c2.customerName
FROM
    classicmodels.customers c1
        INNER JOIN
    classicmodels.customers c2 ON c1.city = c2.city
        AND c1.customername > c2.customerName
ORDER BY c1.city;


