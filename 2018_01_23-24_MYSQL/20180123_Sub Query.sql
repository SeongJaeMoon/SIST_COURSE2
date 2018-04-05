#---------------------------------
#MySQL Workbench
#---------------------------------

#--------------------------------
#classicmodels.offices 테이블에서 country 컬럼의 정보가 'USA'인 경우,  officeCode 컬럼 정보 출력.
SELECT 
    officeCode
FROM
    classicmodels.offices
WHERE
    country = 'USA';
#결과로 1, 2, 3이 나온다.    
    
    
#classicmodels.employees 테이블에서 officeCode 컬럼의 정보가 1, 2, 3인 경우 출력.
SELECT 
    lastName, firstName, officeCode
FROM
    classicmodels.employees
WHERE
    officeCode IN (1, 2, 3);    


#서브 쿼리를 이용해서 위의 쿼리 두 개를 한 번에 실행하는 쿼리
#주의) 서브 쿼리 결과가 여러개인 경우 IN 연산자 사용
SELECT 
    lastName, firstName, officeCode
FROM
    classicmodels.employees
WHERE
    officeCode IN (SELECT 
            officeCode
        FROM
            classicmodels.offices
        WHERE
            country = 'USA');
            

#classicmodels.payments 테이블에서 amount 컬럼의 값이 가장 큰 경우 출력.            
#MAX() 함수는 최대값 반환하는 함수
SELECT 
    customerNumber, checkNumber, amount
FROM
    classicmodels.payments
WHERE
    amount = (SELECT 
            MAX(amount)
        FROM
            classicmodels.payments);
            

#classicmodels.payments 테이블에서 amount 컬럼의 값이 amount 컬럼 평균값보다 큰 경우 출력.            
#AVG() 함수는 평균값 반환하는 함수
SELECT 
    customerNumber, checkNumber, amount
FROM
    classicmodels.payments
WHERE
    amount > (SELECT 
            AVG(amount)
        FROM
            classicmodels.payments);            
            

#classicmodels.customers, classicmodels.orders 테이블에서 orders 테이블에 주문 정보가 없는 고객 정보 출력.
SELECT 
    customerName
FROM
    classicmodels.customers
WHERE
    customerNumber NOT IN (SELECT DISTINCT
            customerNumber
        FROM
            classicmodels.orders);
            
#-------------------------------------
#서브쿼리 결과가 가상테이블로 사용될 수 있다. 서브쿼리를 FROM 구문에 배치한다.
SELECT 
    orderNumber, COUNT(orderNumber) AS items
FROM
    classicmodels.orderdetails
GROUP BY orderNumber;
    
    
#테이블 별칭 사용, 서브쿼리의 별칭을 메인쿼리에서 사용 가능
#주의) AS 키워드 생략 가능   
#MAX(), MIN(), AVG() 복수행 함수 
#FLOOR() 함수는 소수 이하 처리 함수
SELECT 
    MAX(items), MIN(items), FLOOR(AVG(items))
FROM
    (SELECT 
        orderNumber, COUNT(orderNumber) AS items
    FROM
        classicmodels.orderdetails
    GROUP BY orderNumber) AS lineitems;
    

#상호 연관 서브쿼리
#메인 쿼리의 자료가 서브쿼리에 참여하고, 서브쿼리의 결과가 메인쿼리의 조건식에 참여하는 구조.    
SELECT 
    productname, buyprice
FROM
    classicmodels.products p1
WHERE
    buyprice > (SELECT 
            AVG(buyprice)
        FROM
            classicmodels.products
        WHERE
            productline = p1.productline);
    

#주문 총액이 60000을 넘는 경우 출력
SELECT 
    orderNumber, SUM(priceEach * quantityOrdered)
FROM
    classicmodels.orderdetails
        INNER JOIN
    classicmodels.orders USING (orderNumber)
GROUP BY orderNumber
HAVING SUM(priceEach * quantityOrdered) > 60000;


#EXISTS 연산자 : 서브쿼리 결과가 존재하면 메인 쿼리 실행하는 경우.
#주문 총액이 60000을 넘는 고객 정보 출력하는 서브 쿼리.
SELECT 
    customerNumber, 
    customerName
FROM
    classicmodels.customers
WHERE
    EXISTS( SELECT 
            orderNumber, SUM(priceEach * quantityOrdered)
        FROM
            classicmodels.orderdetails
                INNER JOIN
            classicmodels.orders USING (orderNumber)
        WHERE
            classicmodels.orders.customerNumber = classicmodels.customers.customerNumber
        GROUP BY orderNumber
        HAVING SUM(priceEach * quantityOrdered) > 60000);
        
        
