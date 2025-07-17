/*
    날짜:25/07/17
    이름:최상규
    내용:6장 PL/SQL
*/

//실습 1-1
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO, ORACLE!');
END;

//실습 1-2
DECLARE
    NO NUMBER(4) := 1001;
    NAME VARCHAR2(10) := '홍길동';
    HP CHAR(13) := '010-1000-1001';
    ADDR VARCHAR2(255) := '부산광역시';
BEGIN
    --DBMS_OUTPUT.PUT_LINE('번호' : ' || NO);
    --DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
    --DBMS_OUTPUT.PUT_LINE('전화 : ' || HP);
    --DBMS_OUTPUT.PUT_LINE('주소 : ' || ADDR);
END;

//실습 2-1

SET SERVEROUTPUT ON;
DECLARE
 NO CONSTANT NUMBER(4) := 1001;
 NAME VARCHAR2(10);
 HP CHAR(13) := '000-0000-0000';
 AGE NUMBER(2) DEFAULT 1;
 ADDR VARCHAR2(10) NOT NULL := '부산';
BEGIN
 NAME := '김유신';
 HP := '010-1000-1001';
 DBMS_OUTPUT.PUT_LINE('번호 : ' || NO);
 DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
 DBMS_OUTPUT.PUT_LINE('전화 : ' || HP);
 DBMS_OUTPUT.PUT_LINE('나이 : ' || AGE);
 DBMS_OUTPUT.PUT_LINE('주소 : ' || ADDR);
END;
/

//실습2-2
DECLARE
    NO DEPT.DEPTNO%TYPE;
    NAME DEPT.DNAME%TYPE;
    DTEL DEPT.DTEL%TYPE;
BEGIN
    SELECT *
    INTO NO, NAME, DTEL
    FROM DEPT
    WHERE DEPTNO = 30;
    
    DBMS_OUTPUT.PUT_LINE('부서번호 : ' || NO);
    DBMS_OUTPUT.PUT_LINE('부서이름 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('전화번호 : ' || DTEL);
END;
/

//실습 2-3
DECLARE
    --선언
    ROW_DEPT DEPT%ROWTYPE;
BEGIN
    --처리
    SELECT *
    INTO ROW_DEPT
    FROM DEPT
    WHERE DEPTNO = 40;
    
    --출력
    DBMS_OUTPUT.PUT_LINE('부서번호 : ' || ROW_DEPT.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('부서이름 : ' || ROW_DEPT.DNAME);
    DBMS_OUTPUT.PUT_LINE('전화번호 : ' || ROW_DEPT.DTEL);
    
END;
/

//실습 2-4
DECLARE
    --정의
    TYPE REC_DEPT IS RECORD (
        deptno NUMBER(2),
        dname DEPT.DNAME%TYPE,
        dtel  DEPT.DTEL%TYPE
    );
    
    --선언
    dept_rec REC_DEPT;
BEGIN
    dept_rec.deptno := 10;
    dept_rec.dname := '개발부';
    dept_rec.dtel := '051-512-1010';
    
    DBMS_OUTPUT.PUT_LINE('deptno : ' || dept_rec.deptno);
    DBMS_OUTPUT.PUT_LINE('dname : ' || dept_rec.dname);
    DBMS_OUTPUT.PUT_LINE('dtel : ' || dept_rec.dtel);
END;
/

//실습하기 2-7

DECLARE
    TYPE ARR_CITY IS TABLE OF VARCHAR2(20) INDEX BY PLS_INTEGER;
    arrCity ARR_CITY;
BEGIN
    arrCity(1) := '서울';
    arrCity(2) := '대전';
    arrCity(3) := '대구';
    
    DBMS_OUTPUT.PUT_LINE('arrCity(1) : ' || arrCity(1));
    DBMS_OUTPUT.PUT_LINE('arrCity(2) : ' || arrCity(2));
    DBMS_OUTPUT.PUT_LINE('arrCity(3) : ' || arrCity(3));
END;
/

//실습하기 4-1

DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
    
    CURSOR c1 IS SELECT * FROM DEPT WHERE DEPTNO = 40;
BEGIN
    -- 커서 열기
    OPEN c1;
    
    -- 커서 데이터 입력
    FETCH c1 INTO V_DEPT_ROW;
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('DTEL : ' || V_DEPT_ROW.DTEL);
    
    -- 커서 닫기
    CLOSE c1;
END;
/

//실습하기 4-3
DECLARE
    CURSOR c1 IS SELECT * FROM DEPT;
BEGIN
    FOR c1_rec IN c1 LOOP
        DBMS_OUTPUT.PUT_LINE('--------------------');
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || c1_rec.DEPTNO);
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || c1_rec.DNAME);
        DBMS_OUTPUT.PUT_LINE('DTEL : ' || c1_rec.DTEL);
    END LOOP;
    
END;
/


//실습하기 4-2
DECLARE
    --커서는 셀렉트 결과의 각행을 가르키는 포인트다.
    
    V_EMP_ROW EMP%ROWTYPE;
    CURSOR emp_cursor IS SELECT * FROM EMP;
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO V_EMP_ROW;
        
        EXIT WHEN emp_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('-------------------');
        DBMS_OUTPUT.PUT_LINE('EMPNO : ' || V_EMP_ROW.EMPNO);
        DBMS_OUTPUT.PUT_LINE('NAME : ' || V_EMP_ROW.NAME);
        DBMS_OUTPUT.PUT_LINE('GENDER : ' || V_EMP_ROW.GENDER);
        DBMS_OUTPUT.PUT_LINE('JOB : ' || V_EMP_ROW.JOB);
        DBMS_OUTPUT.PUT_LINE('DEPNO : ' || V_EMP_ROW.DEPNO);
        DBMS_OUTPUT.PUT_LINE('REGDATE : ' || V_EMP_ROW.REGDATE);
    END LOOP;
END;
/

//실습 5-1
 CREATE PROCEDURE hello_procedure2(p_name IN VARCHAR2)
 IS 
 BEGIN
    DBMS_OUTPUT.PUT_LINE('안녕하세요, ' || p_name || '님!');
    DBMS_OUTPUT.PUT_LINE('환영합니다.');
 END;
 /
 
 -- 프로시저 실행
 EXECUTE hello_procedure2('홍길동');
 EXECUTE hello_procedure2('김철수');
 
 -- 프로시저 제거
 DROP PROCEDURE hello_procedure;
 
 //실습 5-2
 --펑션 생성
 CREATE FUNCTION get_emp_name (p_empno NUMBER) RETURN VARCHAR2
 IS
    v_ename VARCHAR2(20);    
 BEGIN
    SELECT NAME INTO v_ename FROM EMP WHERE EMPNO = p_empno;
    RETURN v_ename;
 END;
 /
 
 --펑션 호출
 SELECT get_emp_name(1001) FROM DUAL;
 
 
 //실습 5-3
 CREATE TABLE emp_log(
    log_date DATE,
    empno NUMBER,
    action VARCHAR(10)
 );
 
 --트리거 생성
 CREATE TRIGGER trgg_emp_insert
 AFTER INSERT ON emp
 FOR EACH ROW
 BEGIN
    INSERT INTO emp_log (log_date,empno, action)
    VALUES(SYSDATE, :NEW.empno, 'INSERT');
 END;
 /
 
 INSERT INTO EMP VALUES(2001,'김유신','M','사원',10,SYSDATE);