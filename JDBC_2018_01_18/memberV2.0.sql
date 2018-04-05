--ȸ������ v2.0�� ���� ���̺� ����
--ȸ�� ���� ���̺� ����
--
CREATE TABLE members(
    mem_id VARCHAR2(3), --PK
    name_ NVARCHAR2(20) NOT NULL,
    phone VARCHAR2(20) NOT NULL,
    email VARCHAR2(50),
    regDate DATE,
    dept_id VARCHAR2(4) --FK
);

--�μ� ���� ���̺� ����
--
ALTER TABLE members
    ADD CONSTRAINTS members_mem_id_pk PRIMARY KEY(mem_id);

ALTER TABLE members
    ADD CONSTRAINTS members_dept_id FOREIGN KEY (dept_id)
    REFERENCES department(dept_id);
    
CREATE TABLE department(
    dept_id VARCHAR(3), --PK
    dept_name VARCHAR(4)
);

ALTER TABLE department
    ADD CONSTRAINTS department_dept_id_pk PRIMARY KEY(dept_id);

ALTER TABLE department
    MODIFY (dept_id VARCHAR(3));

--�������� �߰�
INSERT INTO department (dept_id, dept_name) VALUES ('D01', '���ߺ�');
INSERT INTO department (dept_id, dept_name) VALUES ('D02', '�����ú�');
INSERT INTO department (dept_id, dept_name) VALUES ('D03', '�ѹ���');
--���� �ڷ� �Է�

COMMIT;

SELECT dept_id, dept_name FROM department;
SELECT mem_id, name_, phone, email, regDate, dept_id FROM members;

--ȸ��+�μ�
SELECT mem_id, name_, phone, email, regDate, dept_name 
FROM members m, department d
WHERE m.dept_id = d.dept_id;

--ȸ��+�μ� ��
CREATE OR REPLACE VIEW membersView 
AS
SELECT mem_id, name_, phone, email, regDate, dept_name
FROM members m, department d
WHERE m.dept_id = d.dept_id;

INSERT INTO members(mem_id, name_, phone, email, regDate, dept_id) VALUES((SELECT NVL(LPAD(SUBSTR(MAX(mem_id), 2, 3)+1, 3, 'M0'), 'M01') FROM members), 'moon', '010-4318-0221', 'seongjae.m@gmail.com', '2017-04-28', 'D01');
INSERT INTO members(mem_id, name_, phone, email, regDate, dept_id) VALUES((SELECT NVL(LPAD(SUBSTR(MAX(mem_id), 2, 3)+1, 3, 'M0'), 'M01') FROM members), 'seong', '010-4318-0221', 'seongjae.m@gmail.com', '2017-04-28', 'D02');
INSERT INTO members(mem_id, name_, phone, email, regDate, dept_id) VALUES((SELECT NVL(LPAD(SUBSTR(MAX(mem_id), 2, 3)+1, 3, 'M0'), 'M01') FROM members), 'jae', '010-4318-0221', 'seongjae.m@gmail.com', '2017-04-28', 'D02');
INSERT INTO members(mem_id, name_, phone, email, regDate, dept_id) VALUES((SELECT NVL(LPAD(SUBSTR(MAX(mem_id), 2, 3)+1, 3, 'M0'), 'M01') FROM members), 'cool', '010-4318-0221', 'seongjae.m@gmail.com', '2017-04-28', 'D03');
COMMIT;

SELECT mem_id, name_, phone, email, regDate, dept_name
FROM membersView;

ROLLBACK;

SELECT * FROM members;