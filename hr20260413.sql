---------------------------------------------------------------
-- 부프로그램 : 함수
1. 프로시저 ( PROCEDURE ) -- SUBROUTINE : 서브루틴 -> 함수보다 더 많이 사용한다.
   : 리턴값이 0개 이상
   STORED PROCEDURE : 저장 프로시저
   
2. 함수 ( FUNCTION )
   : 반드시 무조건 리턴값이 1개
   
USER DEFINE FUNCTION - 사용자가 정의한 함수, 우리가 함수를 만든다
---------------------------------------------------------------

-- 107번 직원의 이름과 월급 조회
SELECT FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         월급
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 107
;

-- 부서번호입력, 해당부서의 최고월급자의 이름, 월급출력
SELECT DEPARTMENT_ID 부서번호,
       MAX( SALARY ) 최고월급
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID
;


-- 90번 부서번호 입력, 직원들 출력
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 90
;

-- 107번 직원의 이름과 월급 조회 - TEACHER
SELECT FIRST_NAME || ' ' || LAST_NAME 이름,
       SALARY                         월급
 FROM EMPLOYEES
 WHERE EMPLOYEE_ID = 107
;

익명 블락
SET SERVEROUTPUT ON;
DECLARE
 V_NAME VARCHAR2(46);
 V_SAL NUMBER(8, 2);
BEGIN
 V_NAME := '카리나';
 V_SAL  := 10000;
 DBMS_OUTPUT.PUT_LINE(V_NAME);
 DBMS_OUTPUT.PUT_LINE(V_SAL);
 IF V_SAL >= 1000 THEN
  DBMS_OUTPUT.PUT_LINE('Good');
 ELSE
  DBMS_OUTPUT.PUT_LINE('Sad');
 END IF;
END;
/ -- 일반적으로 ; 는 문장을 끝내는 표시인데 이 작업을 할때는 ;에서 끝나면 안되니까 DECLART 명령 한정, / 이 문장을 끝내는 명령어가 된다

저장 프로시저 ( IN:INPUT, OUT OUTPUT, INOUT : INPUTOUT )
CREATE PROCEDURE GET_EMPSAL ( IN_EMPID IN NUMBER ) -- GET_EMPSAL는 IN_EMPID를 IN NUMBER 타입으로 변환해서
IS
 V_NAME VARCHAR2( 46 );
 V_SAL  NUMBER( 8, 2 );
 BEGIN
    SELECT FIRST_NAME || ' ' || LAST_NAME, SALARY
     INTO  V_NAME                         , V_SAL
    FROM   EMPLOYEES
    WHERE  EMPLOYEE_ID = IN_EMPID
    ;
    
    DBMS_OUTPUT.PUT_LINE('이름:' || V_NAME );
    DBMS_OUTPUT.PUT_LINE('월급:' || V_SAL  );
 END;
/

-- ORCLE로 프로시저를 생성한다.



-- 부서번호입력, 해당부서의 최고월급자의 이름, 월급출력 - TEACHER

-- 90번 부서번호 입력, 직원들 출력 - TEACHER
































