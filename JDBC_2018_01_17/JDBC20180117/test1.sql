SELECT * FROM employees;

--JDBC 연습용 테이블 생성
CREATE TABLE sample01(
    id_ NUMBER NOT NULL, --PK
    age NUMBER NOT NULL,
    first_ VARCHAR2(255),
    last_ VARCHAR2(255)
);

--샘플 자료 입력
INSERT INTO sample01 VALUES (100, 18, 'Zara', 'Ali');
INSERT INTO sample01 VALUES (101, 25, 'Mahnaz', 'Fatma');
INSERT INTO sample01 VALUES (102, 30, 'Zaid', 'Khan');
INSERT INTO sample01 VALUES (103, 28, 'Sumit', 'Mittal');

ALTER TABLE sample01
    ADD CONSTRAINTS SAMPE01_ID_PK PRIMARY KEY(id_);
     
SELECT * FROM sample01;

INSERT INTO sample01 VALUES (104, 32, 'Seongjae', 'Moon');


SELECT id_, age, first_, last_ FROM sample01 WHERE age >= 30;

COMMIT;  

@C:\emp_table.sql