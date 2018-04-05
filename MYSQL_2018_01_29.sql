<MySQL>
 

#--------------------------------------------------------------------------
CREATE TABLE regions (
    reg_id VARCHAR(5)   #PK (REG01, REG02, ... )
    ,reg_name  VARCHAR(10)
);
#제약 조건 지정
ALTER TABLE regions ADD CONSTRAINT regions_reg_id_pk PRIMARY KEY (reg_id);

#샘플 자료 입력
INSERT INTO regions(reg_id, reg_name) 
VALUES(CONCAT('REG',LPAD((SUBSTRING(IFNULL((SELECT MAX(reg_id) FROM regions r),'REG00'),4)+1),2,0)),
  '강원');
INSERT INTO regions(reg_id, reg_name) 
VALUES(CONCAT('REG',LPAD((SUBSTRING(IFNULL((SELECT MAX(reg_id) FROM regions r),'REG00'),4)+1),2,0)),
  '경기');
INSERT INTO regions(reg_id, reg_name) 
VALUES(CONCAT('REG',LPAD((SUBSTRING(IFNULL((SELECT MAX(reg_id) FROM regions r),'REG00'),4)+1),2,0)),
  '경남');
INSERT INTO regions(reg_id, reg_name) 
VALUES(CONCAT('REG',LPAD((SUBSTRING(IFNULL((SELECT MAX(reg_id) FROM regions r),'REG00'),4)+1),2,0)),
  '경북');

        

COMMIT;
SELECT * FROM regions;
        
#--------------------------------------------------------------------------
CREATE TABLE departments (
    dept_id VARCHAR(6)   #PK (DEPT01, DEPT02, ... )
    ,dept_name  VARCHAR(15) NOT NULL
);

#제약 조건 지정
ALTER TABLE departments ADD CONSTRAINT departments_dept_id_pk PRIMARY KEY (dept_id);

#샘플 자료 입력
INSERT INTO departments(dept_id, dept_name) 
VALUES(CONCAT('DEPT',LPAD((SUBSTRING(IFNULL((SELECT MAX(dept_id) FROM departments d),'DEPT00'),5)+1),2,0)),
  '개발부');
INSERT INTO departments(dept_id, dept_name) 
VALUES(CONCAT('DEPT',LPAD((SUBSTRING(IFNULL((SELECT MAX(dept_id) FROM departments d),'DEPT00'),5)+1),2,0)),
  '기획부');
INSERT INTO departments(dept_id, dept_name) 
VALUES(CONCAT('DEPT',LPAD((SUBSTRING(IFNULL((SELECT MAX(dept_id) FROM departments d),'DEPT00'),5)+1),2,0)),
  '영업부');
        
COMMIT;
SELECT * FROM departments;
#--------------------------------------------------------------------------
CREATE TABLE jobs (
    job_id VARCHAR(5)   #PK (JOB01, JOB02, ... )
    ,job_title  VARCHAR(15) NOT NULL
);

#제약 조건 지정
ALTER TABLE jobs ADD CONSTRAINT jobs_job_id_pk PRIMARY KEY (job_id);

#샘플 자료 입력
INSERT INTO jobs(job_id, job_title) 
VALUES(CONCAT('JOB',LPAD((SUBSTRING(IFNULL((SELECT MAX(job_id) FROM jobs j),'JOB00'),4)+1),2,0)),
  '과장');
INSERT INTO jobs(job_id, job_title) 
VALUES(CONCAT('JOB',LPAD((SUBSTRING(IFNULL((SELECT MAX(job_id) FROM jobs j),'JOB00'),4)+1),2,0)),
  '대리');
INSERT INTO jobs(job_id, job_title) 
VALUES(CONCAT('JOB',LPAD((SUBSTRING(IFNULL((SELECT MAX(job_id) FROM jobs j),'JOB00'),4)+1),2,0)),
  '사원');

COMMIT;
SELECT * FROM jobs; 
#--------------------------------------------------------------------------
CREATE TABLE employees (
        eid VARCHAR(5) #PK (E0001, E0002, ... )
       ,name_ VARCHAR(20) NOT NULL
       ,ssn  VARCHAR(14) NOT NULL
       ,hiredate DATE     NOT NULL
       ,phone   VARCHAR(15)
       ,reg_id  VARCHAR(10) #FK
       ,dept_id VARCHAR(15) #FK
       ,job_id VARCHAR(15) #FK
       ,basicpay INT NOT NULL
       ,extrapay INT NOT NULL
);


#제약 조건 지정
ALTER TABLE employees ADD CONSTRAINT employees_eid_pk PRIMARY KEY (eid);
ALTER TABLE employees ADD CONSTRAINT employees_reg_id_fk FOREIGN KEY (reg_id) REFERENCES regions(reg_id);
ALTER TABLE employees ADD CONSTRAINT employees_dept_id_fk FOREIGN KEY (dept_id) REFERENCES departments(dept_id);
ALTER TABLE employees ADD CONSTRAINT employees_job_id_fk FOREIGN KEY (job_id) REFERENCES jobs(job_id);
ALTER TABLE employees ADD CONSTRAINT employees_basicpay_ck CHECK (basicpay>0);
ALTER TABLE employees ADD CONSTRAINT employees_basicpay_ck CHECK (extrapay>0);

#샘플 자료 입력
INSERT INTO employees(eid, name_,ssn,hiredate,phone,reg_id,dept_id,job_id,basicpay,extrapay)
VALUES (CONCAT('E',LPAD((SUBSTRING(IFNULL((SELECT MAX(eid) FROM employees e),'E0000'),2)+1),2,0)),
 'hong', '910101-2020202', '2017-01-01', '010-1111-1111', 'REG02', 'DEPT01', 'JOB01', 3000000, 500000);
INSERT INTO employees(eid, name_,ssn,hiredate,phone,reg_id,dept_id,job_id,basicpay,extrapay)
VALUES (CONCAT('E',LPAD((SUBSTRING(IFNULL((SELECT MAX(eid) FROM employees e),'E0000'),2)+1),2,0)),
 'park', '920202-1010101', '2018-01-01', '010-2222-2222', 'REG01', 'DEPT02', 'JOB03', 1000000, 100000);    

COMMIT;
SELECT * FROM employees;

# 직원 정보 삭제 쿼리
DELETE FROM employees
WHERE  ;
#--------------------------------------------------------------------------
CREATE TABLE login (
 id_ VARCHAR(20) #PK
 , pw_ VARCHAR(20)
 , grade TINYINT #0(관리자), 1(강사), 2(수강생, 기본값)
);

#제약 조건 지정
ALTER TABLE login ADD CONSTRAINT login_id_pk PRIMARY KEY (id_);

#grade 컬럼에는 0(관리자), 1(강사), 2(수강생, 기본값) 만 넣을 수 있다

#샘플 자료 입력
#관리자 계정(admin, 1234)은 필수 입력
INSERT INTO login VALUES('admin', 1234, 0);
INSERT INTO login VALUES('jong', 1234, 1);
INSERT INTO login VALUES('hong', 1234, 2);
#-----------------------------------------------
# 삭제 가능 여부 확인 쿼리 (참조하고 있는 자료가 있으면 삭제 불가능)
SELECT reg_id, reg_name, 
 (SELECT COUNT(*) FROM employees WHERE reg_id = r.reg_id) AS deleteCheck
FROM regions r
ORDER BY reg_id;

SELECT dept_id, dept_name, 
 (SELECT COUNT(*) FROM employees WHERE dept_id = d.dept_id) AS deleteCheck
FROM departments d
ORDER BY dept_id;

SELECT job_id, job_title,
 (SELECT COUNT(*) FROM employees WHERE job_id = j.job_id) AS deleteCheck
FROM jobs j
ORDER BY job_id;

#-----------------------------------------------
# 삭제 테스트
INSERT INTO regions(reg_id, reg_name) 
VALUES(CONCAT('REG',LPAD((SUBSTRING(IFNULL((SELECT MAX(reg_id) FROM regions r),'REG00'),4)+1),2,0)),
  'test');
        
DELETE FROM regions
WHERE reg_id = 'REG05';

SELECT * FROM regions;

#-----------------------------------------------
CREATE VIEW empView
AS
SELECT eid, name_, ssn, hiredate, phone, reg_name, dept_name, job_title, basicpay, extrapay, basicpay+extrapay AS pay
FROM employees 
INNER JOIN regions USING(reg_id)
INNER JOIN departments USING(dept_id)
INNER JOIN jobs USING(job_id);

SELECT eid, name_, ssn, hiredate, phone, reg_name, dept_name, job_title, basicpay, extrapay, pay
FROM empView;
#-------------------------------------------------