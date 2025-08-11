-- 생성자 Oracle SQL Developer Data Modeler 24.3.1.347.1153
--   위치:        2025-08-11 11:30:06 KST
--   사이트:      Oracle Database 21c
--   유형:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE bank_account (
    a_no        CHAR(11) NOT NULL,
    a_item_dist CHAR(2) NOT NULL,
    a_item_name VARCHAR2(20) NOT NULL,
    a_c_no      VARCHAR2(14 BYTE),
    a_balance   NUMBER NOT NULL,
    a_open_date DATE NOT NULL
);

ALTER TABLE bank_account ADD CONSTRAINT bank_account_pk PRIMARY KEY ( a_no );

CREATE TABLE bank_customer (
    c_no    VARCHAR2(14 BYTE) NOT NULL,
    c_name  VARCHAR2(20 BYTE) NOT NULL,
    c_dist  NUMBER NOT NULL,
    c_phone CHAR(13 BYTE) NOT NULL,
    c_addr  VARCHAR2(50 BYTE)
);

ALTER TABLE bank_customer ADD CONSTRAINT bank_customer_pk PRIMARY KEY ( c_no );

CREATE TABLE bank_transaction (
    t_no       NUMBER NOT NULL,
    t_a_no     CHAR(11) NOT NULL,
    t_dist     NUMBER NOT NULL,
    t_amount   NUMBER NOT NULL,
    t_datetime DATE NOT NULL
);

ALTER TABLE bank_transaction ADD CONSTRAINT bank_transaction_pk PRIMARY KEY ( t_no );

ALTER TABLE bank_account
    ADD CONSTRAINT bank_account_bank_customer_fk FOREIGN KEY ( a_c_no )
        REFERENCES bank_customer ( c_no );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE bank_transaction
    ADD CONSTRAINT bank_transaction_bank_account_fk FOREIGN KEY ( t_a_no )
        REFERENCES bank_account ( a_no );

CREATE SEQUENCE bank_transaction_t_no_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER bank_transaction_t_no_trg BEFORE
    INSERT ON bank_transaction
    FOR EACH ROW
    WHEN ( new.t_no IS NULL )
BEGIN
    :new.t_no := bank_transaction_t_no_seq.nextval;
END;
/



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             3
-- CREATE INDEX                             0
-- ALTER TABLE                              5
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           1
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          1
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   1
-- WARNINGS                                 0





-- 실습 6-5
INSERT INTO BANK_CUSTOMER VALUES('730423-1000001','김유신',1,'010-1234-1001','경남 김해시');
INSERT INTO BANK_CUSTOMER VALUES('730423-1000002','김춘추',1,'010-1234-1002','경남 경주시');
INSERT INTO BANK_CUSTOMER VALUES('730423-1000003','장보고',1,'010-1234-1003','전남 완도군');
INSERT INTO BANK_CUSTOMER VALUES('102-12-51094','(주)정보산업',2,'051-500-1004','부산시 부산진구');
INSERT INTO BANK_CUSTOMER VALUES('930423-1000005','이순신',1,'010-1234-1005','서울 종로구');

INSERT INTO BANK_ACCOUNT VALUES('101-11-1001','S1','자유저축예금','730423-1000001',1550000,'2011-04-11');
INSERT INTO BANK_ACCOUNT VALUES('101-11-1002','S1','자유저축예금','930423-1000005',260000,'2011-05-12');
INSERT INTO BANK_ACCOUNT VALUES('101-11-1003','S1','자유저축예금','730423-1000003',75000,'2011-06-13');
INSERT INTO BANK_ACCOUNT VALUES('101-12-1001','S2','기업전용예금','102-12-51094',15000000,'2011-07-14');
INSERT INTO BANK_ACCOUNT VALUES('101-13-1001','S3','정기저축예금','730423-1000002',1200000,'2011-08-15');

INSERT INTO BANK_TRANSACTION(T_A_NO, T_DIST, T_AMOUNT, T_DATETIME) VALUES('101-11-1001',1,50000,'2023-01-01 13:15:10');
INSERT INTO BANK_TRANSACTION(T_A_NO, T_DIST, T_AMOUNT, T_DATETIME) VALUES('101-12-1001',2,1000000,'2023-01-02 13:15:12');
INSERT INTO BANK_TRANSACTION(T_A_NO, T_DIST, T_AMOUNT, T_DATETIME) VALUES('101-11-1002',3,260000,'2023-01-03 13:15:14');
INSERT INTO BANK_TRANSACTION(T_A_NO, T_DIST, T_AMOUNT, T_DATETIME) VALUES('101-11-1002',2,100000,'2023-01-04 13:15:16');
INSERT INTO BANK_TRANSACTION(T_A_NO, T_DIST, T_AMOUNT, T_DATETIME) VALUES('101-11-1003',3,75000,'2023-01-05 13:15:18');
INSERT INTO BANK_TRANSACTION(T_A_NO, T_DIST, T_AMOUNT, T_DATETIME) VALUES('101-11-1001',1,150000,'2023-01-05 13:15:28');

-- 실습 6-6
SELECT 
    c.c_no,
    c.c_name,
    c.c_phone,
    a.a_no,
    a.a_item_name,
    a.a_balance
FROM bank_customer c
JOIN bank_account a on c.c_no = a.a_c_no;

SELECT 
    t.t_dist,
    t.t_amount,
    t.t_datetime
FROM bank_transaction t
WHERE t_a_no = (
                select a_no 
                from bank_account 
                where a_c_no = (
                    select c_no 
                    from bank_customer 
                    where c_name='이순신')
                    );

SELECT 
    c.c_no,
    c.c_name,
    a.a_no,
    a.a_balance,
    a.a_open_date
FROM bank_customer c
JOIN bank_account a on c.c_no = a.a_c_no
order by a.a_balance desc
FETCH FIRST 1 ROWS ONLY;
