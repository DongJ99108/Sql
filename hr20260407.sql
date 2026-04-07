SELECT * FROM TAB; -- 테이블 목록 조회

/*
SELECT    칼럼명1 별칭1, 칼럼명2 별칭2, 칼럼명3 별칭3, ... 
 FROM     테이블명
 WHERE    조건
 ORDER BY 정렬할칼럼1 ASC, 정렬할칼럼2 DESC;
*/

-- 직원의 성과 이름을 붙여서 출력
SELECT         FIRST_NAME, LAST_NAME,
               FIRST_NAME || ' ' || LAST_NAME   EMPNAME
 FROM          EMPLOYEES
 -- ORDER BY      FIRST_NAME || ' ' || LAST_NAME
 -- ORDER BY      EMPNAME
  ORDER BY 3   -- 3번째 칼럼을 기준으로
;



-- 부서번호가 60인 직원정보(번호, 이름, 이메일, 부서번호)
-- 조건 : =,!=(<>,^=)
--        >,<,>=,<=
--        NOT, AND, OR
SELECT      EMPLOYEE_ID                      번호,
            FIRST_NAME || ' ' || LAST_NAME   이름, 
            EMAIL                            이메일,
            DEPARTMENT_ID                    부서번호
 FROM       EMPLOYEES
 WHERE      DEPARTMENT_ID    =    60
 ORDER BY   이름  ASC
 ;

-- 부서번호가 90인 직원정보(번호, 이름, 이메일, 부서번호)
SELECT      EMPLOYEE_ID                      번호,
            FIRST_NAME || ' ' || LAST_NAME   이름, 
            EMAIL                            이메일,
            DEPARTMENT_ID                    부서번호
 FROM       EMPLOYEES
 WHERE      DEPARTMENT_ID    =    90
 ORDER BY   이름  ASC
 ;

-- 부서번호가 60, 90인 직원정보(번호, 이름, 이메일, 부서번호)
SELECT      EMPLOYEE_ID                      번호,
            FIRST_NAME || ' ' || LAST_NAME   이름, 
            EMAIL                            이메일,
            DEPARTMENT_ID                    부서번호
 FROM       EMPLOYEES
 WHERE      DEPARTMENT_ID    =    60
 OR         DEPARTMENT_ID    =    90
 ORDER BY   이름  ASC
 ;

-- 부서번호가 60, 90인 직원정보(번호, 이름, 이메일, 부서번호) - TEACHER
SELECT      E.EMPLOYEE_ID                        번호,
            E.FIRST_NAME || ' ' || E.LAST_NAME   이름,
            E.EMAIL                              이메일,
            E.DEPARTMENT_ID                      부서번호
 FROM       EMPLOYEES   E
 WHERE      DEPARTMENT_ID    =    60
 OR         DEPARTMENT_ID    =    90    -- OR : 이거나 + 논리합
 ORDER BY   부서번호 ASC
;

-- IN 명령어
SELECT      E.EMPLOYEE_ID                        번호,
            E.FIRST_NAME || ' ' || E.LAST_NAME   이름,
            E.EMAIL                              이메일,
            E.DEPARTMENT_ID                      부서번호
 FROM       EMPLOYEES   E
 WHERE      DEPARTMENT_ID   IN ( 90, 60, 80 )
 ORDER BY   부서번호 ASC, 이름 ASC
    -- 먼저 부서번호순으로 정렬하고 부서번호가 같으면 이름순
;

-- 1. 월급이 12000 이상인 직원의 번호, 이름, 이메일 월급을 월급순으로 출력
SELECT    E.EMPLOYEE_ID                        번호,
          E.FIRST_NAME || ' ' || E.LAST_NAME   이름,
          E.EMAIL                              이메일,
          E.SALARY                             월급
 FROM      EMPLOYEES   E
 WHERE     SALARY >= 12000
 ORDER BY  월급 DESC
;

-- 2. 월급이 10000~15000 인 직원의 사번, 이름 월급 부서번호
-- 1)
SELECT    E.EMPLOYEE_ID                        번호,
          E.FIRST_NAME || ' ' || E.LAST_NAME   이름,
          E.SALARY                             월급,
          E.DEPARTMENT_ID                      부서번호
 FROM      EMPLOYEES   E
 WHERE     SALARY >= 10000
  AND      SALARY <= 15000
 ORDER BY  월급 DESC
;

-- 2) 코딩은 짧아지지만 추천하지는 않는다
SELECT    E.EMPLOYEE_ID                        번호,
          E.FIRST_NAME || ' ' || E.LAST_NAME   이름,
          E.SALARY                             월급,
          E.DEPARTMENT_ID                      부서번호
 FROM      EMPLOYEES   E
 WHERE     SALARY BETWEEN 10000 AND 15000 -- 월급 10000 <=SALARY <= 15000
 ORDER BY  월급 DESC
;

-- 3-1. 직업 ID 가 IT_PROG 인 직원 명단
SELECT   *
 FROM     EMPLOYEES
 WHERE    JOB_ID = 'IT_PROG'
 ORDER BY EMPLOYEE_ID ASC
;

-- 3-2. 직업 ID 가 IT_PROG 인 직원 명단(사번, 이름, 직업ID, 부서번호)
SELECT   EMPLOYEE_ID                      사번,
         FIRST_NAME || ' ' || LAST_NAME   이름,
         JOB_ID                           직업ID, 
         DEPARTMENT_ID                    부서번호
 FROM     EMPLOYEES
 WHERE    JOB_ID = 'IT_PROG'
  OR      JOB_ID = 'it_prog'
 ORDER BY EMPLOYEE_ID ASC
;

-- 3-3. 직업 ID 가 IT_PROG 인 직원 명단(사번, 이름, 직업ID, 부서번호)
    -- UPPER(), LOWER(), INITCAP()
SELECT   EMPLOYEE_ID                      사번,
         FIRST_NAME || ' ' || LAST_NAME   이름,
         JOB_ID                           직업ID, 
         DEPARTMENT_ID                    부서번호
 FROM     EMPLOYEES
 WHERE    LOWER(JOB_ID) = 'it_prog'
 ORDER BY EMPLOYEE_ID ASC
;

-- 4. 직원이름이 GRANT 인 직원을 찾으세요
SELECT       EMPLOYEE_ID                      사번,
             FIRST_NAME || ' ' || LAST_NAME   이름,
             EMAIL                            이메일,
             DEPARTMENT_ID                    부서번호
 FROM        EMPLOYEES
 WHERE UPPER (LAST_NAME)  = 'GRANT'
 OR    UPPER (FIRST_NAME) = 'GRANT'
 ORDER BY    FIRST_NAME || ' ' || LAST_NAME ASC
 ;


-- 5. 사번, 월급, 10% 인상한 월급
SELECT       EMPLOYEE_ID                      EMPID,
             FIRST_NAME || ' ' || LAST_NAME   ENAME,
             SALARY                           SAL,
             SALARY * 1.1                    "SAL * 10%"
 FROM        EMPLOYEES
 ORDER BY    SALARY DESC
 ;


-- 6. 50번 부서의 직원명단, 월급, 부서번호
SELECT       EMPLOYEE_ID                      사번,
             FIRST_NAME || ' ' || LAST_NAME   이름,
             SALARY                           월급,
             DEPARTMENT_ID                    부서번호
 FROM        EMPLOYEES
 WHERE       DEPARTMENT_ID = 50
 ;


-- 7. 20, 80, 60, 90번 부서의 직원명단, 월급, 부서번호
SELECT       EMPLOYEE_ID                      사번,
             FIRST_NAME || ' ' || LAST_NAME   이름,
             SALARY                           월급,
             DEPARTMENT_ID                    부서번호
 FROM        EMPLOYEES
 WHERE       DEPARTMENT_ID IN (20, 80, 60, 90)
 ;

-- 중요 데이터를 2개 입력
SELECT         COUNT(*)
 FROM          EMPLOYEES
 ; -- 107 -> 전체 자료 수(ROW 수)

SELECT SYSDATE
 FROM  DUAL; -- 오늘의 날짜 연월일시분초 까지 저장
 -- DUAL = 자료를 하나만 출력하는 가상의 테이블
 -- SMALLDATE = 연월일시분
 -- TIMESTAMP = 연월일시분초

-- 신입사원 입사( 박보검, 장원영 ) 데이터를 채울때는 테이블의 칼럼 수에 맞게 넣어야함 많거나 적으면 오류
INSERT    INTO EMPLOYEES
 VALUES ( 207,      '보검', '박', 'BOKUM', '1.515.555.8888', SYSDATE, 
          'IT_PROG', NULL,  NULL,   NULL,  NULL );
 -- SYSDATE는 함수처럼 작동하지만 함수는 아님

INSERT    INTO EMPLOYEES
 VALUES ( 208,      '리나', '카', 'RINA', '1.515.555.9999', SYSDATE, 
          'IT_PROG', NULL,  NULL,   NULL,  NULL );
          
SELECT *        FROM EMPLOYEES;
SELECT COUNT(*) FROM EMPLOYEES;  -- 109

UPDATE   EMPLOYEES
 SET     EMAIL        = 'KARINA',
         PHONE_NUMBER = '010-1234-5678'
 WHERE   EMPLOYEE_ID  = 208
 ;











COMMIT;   -- 한번 커밋하면 취소(ROLLBACK)할 수 없다
ROLLBACK; -- 글을 작성할 때에 맨 밑에 있는 확인과 취소같은 느낌
-- 원래 오라클은 자동커밋 방식을 채택하지 않지만 JAVA로 작성한 코드에서는 자동커밋 방식을 사용


-- 8. 보너스 없는 직원명단 (COMMISSION_PCT) 가 없다
SELECT EMPLOYEE_ID                        사번,
       FIRST_NAME || ' ' || LAST_NAME     이름,
       COMMISSION_PCT                     보너스
 FROM   EMPLOYEES
 WHERE  COMMISSION_PCT IS NULL
;

-- 9. 전화번호가 010으로 시작하는
-- PATTERN MATCHING - LIKE를 써야함
-- % : 0자 이상의 모든 숫자 글자
-- _ : 1자의 모든 숫자 글자
SELECT EMPLOYEE_ID                     사번,
       FIRST_NAME || ' ' || LAST_NAME  이름,
       PHONE_NUMBER                    전화번호
 FROM   EMPLOYEES
 WHERE  PHONE_NUMBER LIKE '010%'     -- STARTS WITH 로 시작되는
-- WHERE  PHONE_NUMBER LIKE '%555%' -- CONTAINS를 포함하는
-- WHERE  PHONE_NUMBER LIKE '%16'   -- ENDS WITH로 끝나는
;


-- 10. LAST_NAME 세번째, 네번째 글자가 LL인것을 찾아라
SELECT EMPLOYEE_ID                     사번,
       FIRST_NAME || ' ' || LAST_NAME  이름,
       EMAIL                           이메일
 FROM  EMPLOYEES
 WHERE UPPER(LAST_NAME) LIKE '__LL%'
 ;
 
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
 
SELECT SYSDATE       FROM DUAL; -- 26/04/07 00:00:00
SELECT 7/2           FROM DUAL; -- 3.5
SELECT 0/2           FROM DUAL; -- 0
SELECT 2.0/0.0       FROM DUAL; -- 오류 ORA-01476 : 제수가 0입니다.
SELECT SYSTIMESTAMP  FROM DUAL; -- 26/04/07 15:35:57.323000000 +09:00

SELECT   SYSDATE - 7 "일주일 전 날짜"
       , SYSDATE     "오늘 날짜"
       , SYSDATE + 7 "일주일 후 날짜"
FROM DUAL;
-- 날짜 + n, 날짜 - n : 몇 일 전, 후,
-- 날짜1 - 날짜2      : 두 날짜 사이의 차이를 날 수로 계산
-- 날짜1 + 날짜2      : 오류 잘못된 표현 - 의미가 없음

// TO_DATE, TO_CHAR, TO_NUMBER
-- 크리스마스와 오늘 날짜의 차이
SELECT TO_DATE('26/12/25') - SYSDATE
 FROM DUAL; -- 261.341006944444444444444444444444444444
 
 -- 소수이하 3자리로 반올림    : ROUND(VAL, 3)
 -- 소수이하 3자리로 절사      : TRUNC(VAL, 3)
  -- 15일 기준으로 반올림 날짜 : ROUND(SYSDATE, 'MONTH')
 -- 해당 달의 첫번째 날짜      : TRUNC(SYSDATE, 'MONTH')
SELECT SYSDATE, ROUND(SYSDATE, 'MONTH'), TRUNC(SYSDATE, 'MONTH')
 FROM DUAL;
 
SELECT NEXT_DAY( SYSDATE, '월요일' ) FROM DUAL; -- 26/04/13 : 바로 다음 월요일
SELECT TRUNC( SYSDATE, 'MONTH' )     FROM DUAL; -- 26/04/01 : 날짜에 해당하는 월의 첫번째 날
SELECT LAST_DAY( SYSDATE )           FROM DUAL; -- 26/04/30 : 날짜에 해당하는 월의 마지막 날

-- 11. 입사년월이 17년 2월인 사원출력
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
SELECT EMPLOYEE_ID                     사번,
       FIRST_NAME || ' ' || LAST_NAME  이름,
       EMAIL                           이메일,
       HIRE_DATE                       입사년월
 FROM   EMPLOYEES
 -- WHERE  HIRE_DATE LIKE '17/02%'
 WHERE HIRE_DATE
  BETWEEN '2017-02-01'
  AND     LAST_DAY('2017-02-01')
;

-- 날짜 26/04/07 : 표현법이 틀림(년/월/일)
-- 2026-04-07    : ANSI 표준
-- 04/07/26      : 월/일/년 -> 미국식 표현법
-- 07/04/26      : 일/월/년 -> 영국식 표현법

-- 12. '17/02/07' 에 입사한 사람 출력
SELECT EMPLOYEE_ID                     사번,
       FIRST_NAME || ' ' || LAST_NAME  이름,
       EMAIL                           이메일,
       HIRE_DATE                       입사년월
 FROM   EMPLOYEES
 WHERE  HIRE_DATE = '17/02/07'
;

--     '12/06/07' 에 입사한 사람 출력
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
SELECT EMPLOYEE_ID                     사번,
       FIRST_NAME || ' ' || LAST_NAME  이름,
       EMAIL                           이메일,
       HIRE_DATE                       입사년월
 FROM   EMPLOYEES
 WHERE  HIRE_DATE = '2012-06-07';
 
 

-- 13. 오늘 '26/04/07' 입사한 사람 출력
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
SELECT EMPLOYEE_ID                     사번,
       FIRST_NAME || ' ' || LAST_NAME  이름,
       EMAIL                           이메일,
       HIRE_DATE                       입사년월
 FROM   EMPLOYEES
 -- WHERE  HIRE_DATE > SYSDATE - 1
 -- WHERE  HIRE_DATE = '26/04/07' -- '26/04/07 00:00:00';
 -- WHERE  '2026-04-07 00:00:00' <= HIRE_DATE
 --  AND   HIRE_DATE <= '2026-04-07 23:59:59'
 WHERE TRUNC(HIRE_DATE) = '2026-04-07 00:00:00'
;

-- TYPE 변환
-- TO_DATE(문자) -> 날짜
-- TO_NUMBER(문자) -> 숫자
-- TO_CHAR( 숫자, '포맷' ) -> 글자
-- TO_CHAR( 날짜, '포맷' ) -> 날짜 형태의 문자
-- 포맷 : YYYY-MM-DD HH24:MI:SS DAY AM
  -- YYYY : 연도
  -- MM   : 월
  -- DD   : 일
  -- HH24 : 시(24시 기준), 다른걸로는 HH12
  -- MI   : 분
  -- SS   : 초
  -- DAY  : 요일,          일요일
  -- DY   : 요일,          일
  -- AM   : 오전/오후
  
-- 11. 입사년월이 17년 2월인 사원출력
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
SELECT EMPLOYEE_ID                     사번,
       FIRST_NAME || ' ' || LAST_NAME  이름,
       EMAIL                           이메일,
       HIRE_DATE                       입사년월
 FROM  EMPLOYEES
 -- WHERE  HIRE_DATE LIKE '17/02%'
 WHERE TO_CHAR( HIRE_DATE, 'YYYY-MM' ) = '2017-02'
 -- ㄴ 위의것은 비교할때만 살짝 바꾸는거
 ;
 
 -- 화요일 입사자를 출력 - TEACHER
 SELECT   EMPLOYEE_ID                        사번,
          FIRST_NAME || ' ' || LAST_NAME     이름,
          TO_CHAR( HIRE_DATE, 'YYYY-MM-DD' ),
          TO_CHAR( HIRE_DATE, 'DAY' )        입사년월
 FROM     EMPLOYEES
 WHERE    TO_CHAR( HIRE_DATE, 'DY' ) = '화'
 ORDER BY HIRE_DATE ASC
 ;

-- 입사 후 일주일 이내인 직원명단
SELECT EMPLOYEE_ID                     사번,
       FIRST_NAME || ' ' || LAST_NAME  이름,
       EMAIL                           이메일,
       HIRE_DATE                       입사년월
 FROM   EMPLOYEES
 WHERE  HIRE_DATE > SYSDATE - 7
;

-- 화요일 입사자를 출력 - 나혼자 해본거 = 개씹망
SELECT EMPLOYEE_ID                     사번,
       FIRST_NAME || ' ' || LAST_NAME  이름,
       EMAIL                           이메일,
       HIRE_DATE                       입사년월
 FROM   EMPLOYEES
 WHERE  HIRE_DATE > SYSDATE - (7 * NUMBER(900)) - 1
  AND   HIRE_DATE < SYSDATE - (7 * NUMBER(1)) + 1
;

-- 08월 입사자의 사번, 이름, 입사일을 입사일 순으로 정렬
SELECT EMPLOYEE_ID                     사번,
       FIRST_NAME || ' ' || LAST_NAME  이름,
       HIRE_DATE                       입사년월
 FROM   EMPLOYEES
 WHERE  HIRE_DATE LIKE '__/08/__'
 ORDER BY HIRE_DATE ASC
;

-- 부서번호 80이 아닌 직원
SELECT EMPLOYEE_ID                     사번,
       FIRST_NAME || ' ' || LAST_NAME  이름,
       DEPARTMENT_ID                   부서번호
 FROM   EMPLOYEES
 WHERE  DEPARTMENT_ID != 80
;

/* 직원사번, 입사일 */

-- 2026년 04월 07일 10시 05분 04초 오전 수요일
-- 한자로 출력















