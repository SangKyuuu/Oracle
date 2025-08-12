/*
    25/08/12
    최상규
    8장 정규화 실습
*/

-- 정규화 되지 않은 테이블 생성

CREATE TABLE bookorder (
    orderno   NUMBER NOT NULL,
    orderdate DATE,
    custid    VARCHAR2(20 BYTE),
    cname     VARCHAR2(20 BYTE),
    address   VARCHAR2(100 BYTE),
    bookid    NUMBER,
    bookname  VARCHAR2(100 BYTE),
    count     NUMBER,
    price     NUMBER
);

ALTER TABLE bookorder ADD CONSTRAINT bookorder_pk PRIMARY KEY ( orderno );

-- 실습 7-1 제1정규화
INSERT INTO BOOKORDER VALUES(10001,'2024-01-12','a101','김유신','김해',101,'프로그래밍',1,28000);
INSERT INTO BOOKORDER VALUES(10002,'2024-01-12','a102','김춘추','경주',101,'프로그래밍',1,28000);
INSERT INTO BOOKORDER VALUES(10003,'2024-01-12','a102','김춘추','경주',102,'자료구조',2,32000);
INSERT INTO BOOKORDER VALUES(10004,'2024-01-12','a103','장보고','완도',102,'자료구조',2,32000);
INSERT INTO BOOKORDER VALUES(10005,'2024-01-12','a104','강감찬','서울',110,'데이터베이스',1,25000);
INSERT INTO BOOKORDER VALUES(10006,'2024-01-12','a105','이순신','서울',110,'데이터베이스',1,28000);
INSERT INTO BOOKORDER VALUES(10007,'2024-01-12','a105','이순신','서울',102,'자료구조',1,32000);

select * from bookorder;

-- 실습 7-2 제2정규화

CREATE TABLE bo_customer (
    custid  VARCHAR2(20) NOT NULL,
    name    VARCHAR2(20),
    address VARCHAR2(100)
);

ALTER TABLE bo_customer ADD CONSTRAINT customer_pk PRIMARY KEY ( custid );

CREATE TABLE bo_book (
    bookid   NUMBER NOT NULL,
    bookname VARCHAR2(100),
    price    NUMBER
);

ALTER TABLE bo_book ADD CONSTRAINT book_pk PRIMARY KEY ( bookid );

CREATE TABLE bo_order (
    orderno   NUMBER NOT NULL,
    orderid   VARCHAR2(20),
    bookid    NUMBER,
    count     NUMBER,
    orderdate DATE
);

ALTER TABLE bo_order ADD CONSTRAINT order_pk PRIMARY KEY ( orderno );

ALTER TABLE bo_order
    ADD CONSTRAINT order_book_fk FOREIGN KEY ( bookid )
        REFERENCES bo_book ( bookid );

ALTER TABLE bo_order
    ADD CONSTRAINT order_customer_fk FOREIGN KEY ( orderid )
        REFERENCES bo_customer ( custid );

-- 실습 7-3

CREATE TABLE bo_customer3 (
    custid  VARCHAR2(20) NOT NULL,
    name    VARCHAR2(20),
    address VARCHAR2(100)
);

ALTER TABLE bo_customer3 ADD CONSTRAINT bo_customerv1_pk PRIMARY KEY ( custid );

CREATE TABLE bo_order3 (
    orderno   NUMBER NOT NULL,
    orderid   VARCHAR2(20),
    orderdate DATE
);

ALTER TABLE bo_order3 ADD CONSTRAINT bo_orderv1_pk PRIMARY KEY ( orderno );

ALTER TABLE bo_order3
    ADD CONSTRAINT bo_order3_bo_customer3_fk FOREIGN KEY ( orderid )
        REFERENCES bo_customer3 ( custid );

CREATE TABLE bo_book3 (
    bookid   NUMBER NOT NULL,
    bookname VARCHAR2(100)
);

ALTER TABLE bo_book3 ADD CONSTRAINT bo_bookv1_pk PRIMARY KEY ( bookid );

CREATE TABLE bo_orderitem (
    orderno NUMBER NOT NULL,
    bookid  NUMBER NOT NULL,
    price   NUMBER,
    count   NUMBER
);

ALTER TABLE bo_orderitem ADD CONSTRAINT bo_order3v1_pk PRIMARY KEY ( orderno );

ALTER TABLE bo_orderitem
    ADD CONSTRAINT bo_orderitem_bo_book3_fk FOREIGN KEY ( bookid )
        REFERENCES bo_book3 ( bookid );

ALTER TABLE bo_orderitem
    ADD CONSTRAINT bo_orderitem_bo_order3_fk FOREIGN KEY ( orderno )
        REFERENCES bo_order3 ( orderno );