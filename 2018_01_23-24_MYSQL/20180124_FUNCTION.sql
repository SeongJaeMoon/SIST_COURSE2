#---------------------------------
#MySQL Workbench
#---------------------------------

#---------------------------------
#CONCAT() 함수는 두 개 이상의 문자열을 하나로 합치는 함수
#CONCAT(string1,string2, ... );
SELECT CONCAT('TEST', '/', 'SAMPLE', '/', 'OTHER') AS result;

SELECT 
    CONCAT(contactFirstName,' ',contactLastName) Fullname
FROM
    classicmodels.customers;
    

#--------------------------------
#CONCAT_WS() 함수는 두 개 이상의 문자열을 하나로 합치는 함수. 구분자 문자열 지정 가능.
#CONCAT_WS(seperator,string1,string2, ... );
SELECT CONCAT_WS('/','TEST', 'SAMPLE', 'OTHER') AS result;



#---------------------------------
#CHAR_LENGTH() 함수는 글자수를 반환한다.
#CHAR_LENGTH(str);

SELECT LENGTH('TEST'), LENGTH('홍길동');
SELECT CHAR_LENGTH('TEST'), CHAR_LENGTH('홍길동');


CREATE TABLE posts(
  postid int auto_increment primary key,
  title varchar(255) NOT NULL,
  excerpt varchar(255) NOT NULL,
  content text,
  pubdate datetime
);

INSERT INTO posts(title,excerpt,content)
VALUES('MySQL Length','MySQL string length function tutorial','dummy'),
      ('Second blog post','Second blog post','dummy');

SELECT 
    *
FROM
    posts;      
      
#IF() 함수는 조건에 따라서 다른 액션을 처리하는 함수      
#CHAR_LENGTH() 함수는 글자수 반환 함수.
#CONCAT() 함수는 두 개 이상의 문자열 결합 함수.
#LEFT() 함수는 일부 문자열 추출 함수.
SELECT 
    postid,
    title,
    IF(CHAR_LENGTH(excerpt) > 20,
        CONCAT(LEFT(excerpt, 20), '...'),
        excerpt) summary
FROM
    posts;

#---------------------------------
#LEFT() 함수는 일부 문자열 추출하는 함수.
#LEFT(str,length);

SELECT LEFT('Introduction to MySQL LEFT function', 12) AS result;


#-------------------------------------
#SUBSTRING() 함수는 일부 문자열 추출하는 함수
#SUBSTRING(string,position);
#SUBSTRING(string,position,length);
#주의) position은 양수, 음수 가능.

SELECT SUBSTRING('MySQL SUBSTRING with position and length', 7, 9) AS result;


#------------------------------------
#TRIM() 함수는 문자열의 일부를 제거하는 함수
#TRIM([{BOTH|LEADING|TRAILING} [removed_str]] FROM str);
#유사 함수로 LTRIM(), RTRIM() 함수가 있다.

SELECT TRIM(LEADING 'A-' FROM 'A-001') AS result;


#---------------------------------------
#REPLACE() 함수는 특정 문자열을 새로운 문자열로 대체하는 함수.
#REPLACE(str,old_string,new_string);

SELECT REPLACE('A-001', '-', '_') AS result;


#-------------------------------------
#FORMAT() 함수는 숫자 자료에 대한 서식('#,###,###.##') 지정하는 함수.
#FOMRAT(N,D,locale);

SELECT FORMAT(12345.6789, 2) AS result;
SELECT FORMAT(12345.6789, 2, 'de_DE') AS result1, FORMAT(12345.6789, 2, 'ko_KR') AS result2;


#------------------------------------
#INSTR() 함수는 문자열 내에 특정 문자열이 존재하는 위치 반환하는 함수.
#INSTR(str,substr);
#주의) 검색되면 1 이상의 위치값 반환, 검색되지 않으면 0 반환.
SELECT INSTR('010-1234-1234', '1234') AS result1
	, INSTR('010-5678-5678', '1234') AS result2;


#------------------------------------
#NOW() 함수는 시스템의 오늘 날짜 및 시간 반환하는 함수
#주의) 매개변수에 대응하는 값이 없어도 () 생략 불가.
SELECT NOW();


#-------------------------------------
#YEAR() 함수는 날짜 자료형의 자료에서 년도만 추출하는 함수
#YEAR(date);
#유사한 함수로 MONTH(), DAY() 함수가 있다.

SELECT YEAR(NOW()), MONTH(NOW()), DAY(NOW());


#-------------------------------------
#DATE_FORMAT() 함수는 날짜 자료형의 자료에 대한 서식 지정하는 함수
#DATE_FORMAT(date,format)
#서식 지정에 사용하는 문자열은 %Y, %m, %d 등을 사용한다.

SELECT NOW(), DATE_FORMAT(NOW(), '%Y-%m-%d'), DATE_FORMAT(NOW(), '%H:%i');


#---------------------------------------
#CAST() 함수는 특정 자료형으로 변환하는 함수.
#CAST(expression AS TYPE);

#암시적 형변환 지원
SELECT CONCAT('TEST', 100, 200);

#명시적 형변환 지원
SELECT CONCAT('TEST', CAST(100 AS CHAR), CAST(200 AS CHAR));

#암시적 형변환 지원
SELECT 100 + '200';
SELECT '100' + 200;
SELECT '100' + '200';

#명시적 형변환 지원
SELECT CAST('100' AS UNSIGNED) +  CAST('200' AS UNSIGNED);



#-----------------------------------
#IF() 함수는 조건식의 결과에 따라서 다른 결과를 반환하는 함수
#IF(expr,if_true_expr,if_false_expr)

SELECT 
    customerNumber,
    customerName,
    IF(state IS NULL, 'N/A', state) state,
    country
FROM
    classicmodels.customers;
    
    
SELECT 
    COUNT(IF(status = 'Cancelled', 1, NULL)) Cancelled,
    COUNT(IF(status = 'Disputed', 1, NULL)) Disputed,
    COUNT(IF(status = 'In Process', 1, NULL)) 'In Process',
    COUNT(IF(status = 'On Hold', 1, NULL)) 'On Hold',
    COUNT(IF(status = 'Resolved', 1, NULL)) 'Resolved',
    COUNT(IF(status = 'Shipped', 1, NULL)) 'Shipped'
FROM
    classicmodels.orders;


SELECT status, COUNT(STATUS)
FROM classicmodels.orders
GROUP BY status;

#-------------------------------------
#IFNULL() 함수는 NULL 값에 대한 검사 함수
#IFNULL(expression_1,expression_2);
#유사한 함수 NULLIF() 함수가 있다.

SELECT IFNULL(NULL, 'NULL 확인');
SELECT IFNULL(0, 'NULL 확인');
SELECT IFNULL('', 'NULL 확인');

CREATE TABLE IF NOT EXISTS contacts (
    contactid INT AUTO_INCREMENT PRIMARY KEY,
    contactname VARCHAR(20) NOT NULL,
    bizphone VARCHAR(15),
    homephone VARCHAR(15)
);

INSERT INTO contacts(contactname,bizphone,homephone)
VALUES('John Doe','(541) 754-3009',NULL),
      ('Cindy Smith',NULL,'(541) 754-3110'),
      ('Sue Greenspan','(541) 754-3010','(541) 754-3011'),
      ('Lily Bush',NULL,'(541) 754-3111');
      
SELECT 
    *
FROM
    contacts;


SELECT 
    contactname, bizphone, homephone, IFNULL(bizphone, homephone) phone
FROM
    contacts;

      
#---------------------------------
#NULLIF() 함수는 두 개의 항목이 일치하면 NULL 반환, 일치하는 않으면 expression_1 반환.
#NULLIF(expression_1,expression_2);

SELECT NULLIF(1, 1), NULLIF(1, 2), NULLIF(2, 1);

SELECT 1/0;

#나누기 연산에서 0으로 나누기하는 경우 에러.
#0 대신 NULL값으로 대체하면 전체 결과가 NULL이 된다.
SELECT 1/NULLIF(0,0);



#-------------------------------------
#CASE ~ END 구문
#value 항목의 값이 비교값과 일치하는 경우 결과값 반환
#ELSE 키워드는 선택적 요소
/*
CASE value
WHEN compare_value_1 THEN result_1
WHEN compare_value_2 THEN result_2
…
ELSE result 
END
*/


#나열된 조건식이 참이면 결과값 반환
#ELSE 키워드는 선택적 요소
/*
CASE
WHEN condition_1 THEN result_1
WHEN condition_2 THEN result_2
…
ELSE result 
END
*/

SELECT 
    customerName, state, country
FROM
    classicmodels.customers
ORDER BY state;


SELECT 
    customerName, state, country
FROM
    classicmodels.customers
ORDER BY (CASE
    WHEN state IS NULL THEN country
    ELSE state
END);


SELECT 
    SUM(CASE
        WHEN status = 'Shipped' THEN 1
        ELSE 0
    END) AS 'Shipped',
    SUM(CASE
        WHEN status = 'On Hold' THEN 1
        ELSE 0
    END) AS 'On Hold',
    SUM(CASE
        WHEN status = 'In Process' THEN 1
        ELSE 0
    END) AS 'In Process',
    SUM(CASE
        WHEN status = 'Resolved' THEN 1
        ELSE 0
    END) AS 'Resolved',
    SUM(CASE
        WHEN status = 'Cancelled' THEN 1
        ELSE 0
    END) AS 'Cancelled',
    SUM(IF(status = 'Disputed', 1, 0)) AS 'Disputed',
    COUNT(*) AS Total
FROM
    classicmodels.orders;


#-----------------------------------------
#COUNT() 함수는 특정 ROWS의 갯수 반환하는 함수
#주의) COUNT(expression) 인 경우는 NULL은 카운팅에서 제외된다.
SELECT 
    COUNT(*)
FROM
    classicmodels.orders;
    
    
CREATE TABLE IF NOT EXISTS demos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    val INT
);

INSERT INTO demos(val)
VALUES(1),(1),(2),(2),(NULL),(3),(4),(NULL),(5);

SELECT *
FROM demos;

#주의) NULL도 카운팅 된다.
SELECT COUNT(*) 
FROM demos;

#val 컬럼의 자료에서 중복을 제거한 유일한 값의 갯수 반환
#주의) NULL은 카운팅 되지 않는다.
SELECT COUNT(DISTINCT val)
FROM demos;


#주의) 복수행 함수 결과 출력시 일반 컬럼 같이 출력 가능. 단, 일반 컬럼 결과와 복수행 함수의 결과는 서로 연결되지 않는다.
SELECT productline, count(*)
FROM classicmodels.products;


#GROUP BY 구문과 복수행 함수를 같이 사용하면 결과가 서로 연결된다.
SELECT productline, count(*)
FROM classicmodels.products
GROUP BY productline;

#COUNT() 함수와 IF() 함수를 같이 사용하면 조건에 맞는 ROWS의 갯수를 확인할 수 있다.
SELECT COUNT(IF(status='Cancelled',1, NULL)) 'Cancelled',
       COUNT(IF(status='On Hold',1, NULL)) 'On Hold',
       COUNT(IF(status='Disputed',1, NULL)) 'Disputed'
FROM classicmodels.orders;


#-------------------------------------
#SUM() 함수는 숫자 자료의 합 결과를 반환
#주의) NULL은 합 연산에서 제외된다.
SELECT orderNumber,
       FORMAT(SUM(quantityOrdered * priceEach),2) total
FROM classicmodels.orderdetails
GROUP BY orderNumber
ORDER BY total DESC;


SELECT 
    FORMAT(SUM(buyprice), 2)
FROM
    (SELECT 
        buyprice
    FROM
        classicmodels.products
    ORDER BY buyprice DESC
    LIMIT 10) price;
#958.71
    
    
SELECT 
    FORMAT(SUM(quantityOrdered * priceEach), 2) loss
FROM
    classicmodels.orderdetails
        INNER JOIN
    classicmodels.orders USING (orderNumber)
WHERE
    status = 'Cancelled';
    
    
#-------------------------------------
#AVG() 함수는 숫자 자료에 대해서 평균값 반환하는 함수
#주의) NULL은 평균 연산에서 제외된다.

SELECT 
    FORMAT(AVG(buyprice), 2) 'Avarage Classic Cars Price'
FROM
    classicmodels.products
WHERE
    productline = 'Classic Cars';


SELECT 
    productline, FORMAT(AVG(buyprice), 2) 'Avarage Price'
FROM
    classicmodels.products
GROUP BY productline;


#-------------------------------------------------

