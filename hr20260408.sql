SELECT SYSDATE FROM DUAL;

SELECT EMPLOYEE_ID, HIRE_DATE
 FROM EMPLOYEES
 WHERE HIRE_DATE = '15/09/21'
 ;
 -- 단순 26/04/07로 검색하면 보검이랑 리나가 안나온다 이유는 SYSDATE로 입력해서 시분초 단위까지 다 입력해야 나오기 때문
 
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
 
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

SELECT EMPLOYEE_ID, HIRE_DATE
 FROM EMPLOYEES
 WHERE HIRE_DATE = '2015-09-21'
 ;
 ------------------------------------------------------------------
-- 앞으로 날짜는 다음과 같이 표현한다.
SELECT EMPLOYEE_ID, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
 FROM EMPLOYEES
 --WHERE TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') = '2015-09-21'
 WHERE TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') = '2026-04-07'
 -- 'YYYY-MM-DD'는 시,분,초를 무시하는 역할도 있음
 ;


-- 입사 후 일주일 이내인 직원명단
SELECT EMPLOYEE_ID                     사번,
       FIRST_NAME || ' ' || LAST_NAME  이름,
       EMAIL                           이메일,
       HIRE_DATE                       입사년월
 FROM   EMPLOYEES
 WHERE  HIRE_DATE > SYSDATE - 7
 -- 이게 진짜였노
;

-- 입사 후 일주일 이내인 직원명단 - TEACHER
SELECT  EMPLOYEE_ID, TO_DATE(HIRE_DATE, 'YYYY-MM-DD')
 FROM   EMPLOYEES
 WHERE  HIRE_DATE > SYSDATE - 7
 ;

-- 08월 입사자의 사번, 이름, 입사일을 입사일 순으로 정렬
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
SELECT EMPLOYEE_ID                     사번,
       FIRST_NAME || ' ' || LAST_NAME  이름,
       HIRE_DATE                       입사년월
 FROM   EMPLOYEES
 WHERE  HIRE_DATE LIKE '____-08%'
 ORDER BY HIRE_DATE ASC
;

-- 08월 입사자의 사번, 이름, 입사일을 입사일 순으로 정렬 - TEACHER
SELECT  EMPLOYEE_ID                       "사 번",
        fIRST_NAME || ' ' || LAST_NAME    이름,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')  입사일
 FROM   EMPLOYEES
 WHERE  TO_CHAR( HIRE_DATE, 'MM' ) = '08'
 ;


-- 부서번호 80이 아닌 직원
SELECT EMPLOYEE_ID                     사번,
       FIRST_NAME || ' ' || LAST_NAME  이름,
       DEPARTMENT_ID                   부서번호
 FROM   EMPLOYEES
 WHERE  DEPARTMENT_ID != 80
;

-- 부서번호 80이 아닌 직원 - TEACHER
SELECT   EMPLOYEE_ID, DEPARTMENT_ID
 FROM    EMPLOYEES
 WHERE   DEPARTMENT_ID <> '80'
 -- 80이든 '80'이든 결과가 똑같이 나옴 -> ORACLE의 융통성 만세
 -- != 와 <> 는 같은 기능을 가지고 있다(같지 않다)
 -- +, -, *, /, MOD(7, 2)
 ;


-- 2026년 04월 07일 10시 05분 04초 오후 화요일
-- 한자로 출력
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
SELECT EMPLOYEE_ID                     사번,
       FIRST_NAME || ' ' || LAST_NAME  이름,
       HIRE_DATE                       입사년월,
       TO_CHAR( SYSDATE, 'YYYY' ) || '年'|| ' ' ||
       TO_CHAR( SYSDATE, 'MM' )   || '月'|| ' ' ||
       TO_CHAR( SYSDATE, 'DD' )   || '日'|| ' ' ||
       TO_CHAR( SYSDATE, 'HH24' ) || '時'|| ' ' ||
       TO_CHAR( SYSDATE, 'MI' )   || '分'|| ' ' ||
       TO_CHAR( SYSDATE, 'SS' )   || '秒'|| ' ' ||
       '午後' || ' ' || '火曜日'
 FROM EMPLOYEES
 ORDER BY 사번 ASC
 ;
 
-- 2026년 04월 07일 10시 05분 04초 오후 화요일
-- 한자로 출력 - TEACHER

SELECT   SYSDATE,
         TO_CHAR( SYSDATE, 'YYYY-MM-DD HH24:MI:SS DAY AM' ),
         TO_CHAR( SYSDATE, 'AM')
 FROM    DUAL
 ;
 
 -- 오전/오후      - 午前/午後
 -- 년월일시분초   - 年, 月, 日, 時, 分, 秒
 -- 일월화수목금토 - 日, 月, 火, 水, 木, 金, 土
 -- 요일           - 曜日
SELECT   TO_CHAR( SYSDATE, 'YYYY' ) || '年 ' ||
         TO_CHAR( SYSDATE, 'MM' )   || '月 ' ||
         TO_CHAR( SYSDATE, 'DD' )   || '日 ' ||
         TO_CHAR( SYSDATE, 'HH12' ) || '時 ' ||
         TO_CHAR( SYSDATE, 'MI' )   || '分 ' ||
         TO_CHAR( SYSDATE, 'SS' )   || '秒 ' ||
         CASE TO_CHAR( SYSDATE, 'DY' )
          WHEN '일' THEN '日'
          WHEN '월' THEN '月'
          WHEN '화' THEN '火'
          WHEN '수' THEN '水'
          WHEN '목' THEN '木'
          WHEN '금' THEN '金'
          WHEN '토' THEN '土'
         END                        || '曜日 ' ||
         DECODE( TO_CHAR( SYSDATE, 'AM' ), '오전', '午前'
                                                   '午後')
 FROM    DUAL
 ;
 
 -- 1) TO_CHAR 활용
 SELECT   SYSDATE,
         TO_CHAR( SYSDATE, 'YYYY-MM-DD HH24:MI:SS DAY AM' )  날짜1,
         -- TO_CHAR( SYSDATE, 'YYYY년MM월DD일 HH24시MI분SS초 DAY AM' )  날짜2, -- ORA-01821: 날짜 형식이 부적합합니다
         TO_CHAR( SYSDATE, 'YYYY"년"MM"월"DD"일" HH24"시"MI"분"SS"초" DAY AM' )  날짜2,
         TO_CHAR( SYSDATE, 'YYYY"年"MM"月"DD"日" HH24"時"MI"分"SS"秒" DAY AM' )  날짜3,
         TO_CHAR( SYSDATE, 'AM')
 FROM    DUAL
 ;
 
 -- 2)   IF를 구현
 
 -- 2-1) NVL(expr1, expr2), NVL2((expr1, expr2, expr3) : NULL VALUE(값이 NULL 일때 출력할 말)
 ---- 사번, 이름, 월급, COMMISSION_PCT( 단 NULL이면 0 으로 출력 )
SELECT  EMPLOYEE_ID                                                        사번,
        FIRST_NAME || ' ' || LAST_NAME                                     이름,
        NVL( SALARY, 0 )                                                   월급,
        NVL( COMMISSION_PCT, 0 )                                           COMMISSION_PCT,
        NVL2( COMMISSION_PCT, SALARY + ( SALARY * COMMISSION_PCT ), SALARY ) 보너스
 FROM   EMPLOYEES
 ;
 
 
-- 2-2) NULLIF( expr1, expr2 )
-- 둘을 비교해서 같으면 NULL, 같지 않으면 expr1
 
-- 2-3) DECODE (expr, search1, result1, 
--                     search2, result2,
--                     …, 
--                     default)
-- DECODE는 expr과 search1을 비교해 두 값이 같으면 result1을, 
-- 같지 않으면 다시 search2와 비교해 값이 같으면 result2를 반환하고, 
-- 이런 식으로 계속 비교한 뒤 최종적으로 같은 값이 없으면 default 값을 반환한다.

 -- 사번, 부서번호 ( 단 부서번호가 NULL 이면 '부서없음' )
SELECT    EMPLOYEE_ID                      사번, 
          -- NVL(DEPARTMENT_ID, '부서없음')   부서번호 -- ORA-01722: 수치가 부적합합니다 -> 두 TYPE이 같아야함
          DECODE(DEPARTMENT_ID, NULL, '부서없음',
                                       DEPARTMENT_ID ) 부서번호
 FROM     EMPLOYEES
 ;


SELECT   TO_CHAR( SYSDATE, 'AM' ),
         DECODE( TO_CHAR( SYSDATE, 'AM' ), '오전', '午前' ,
                                                   '午後' ) -- 비교할 값이 두개이기 때문에 defalut 값에 午後를 넣어놓음
 FROM    DUAL
 ;



 
 -------------------------------------------------------------------------------------------------------------------------
 /*
 10	Administration
20	Marketing
30	Purchasing
40	Human Resources
50	Shipping
60	IT
70	Public Relations
80	Sales
90	Executive
100	Finance
110	Accounting
*/
 -- DECODE 로 
 -- 사번, 이름, 부서명 : 모든 부서명, NULL : 부서없음
SELECT    EMPLOYEE_ID                      사번,
          FIRST_NAME || ' ' || LAST_NAME   이름,
          DECODE(DEPARTMENT_ID, 10,  'Administration',
                                20,  'Marketing',
                                30,  'Purchasing',
                                40,  'Human Resources',
                                50,  'Shipping',
                                60,  'IT',
                                70,  'Public Relations',
                                80,  'Sales',
                                90,  'Executive',
                                100, 'Finance',
                                110, 'Accounting'
                                  , '부서없음')                         
                                           부서명
 FROM     EMPLOYEES
 ;
 
-- NULL 이 계산에 포함되면 결과는 NULL
-- 직원명단, 직원의 월급, 보너스 출력 연봉출력
-- NVL2((expr1, expr2, expr3)
SELECT    EMPLOYEE_ID                                                            사번,
          FIRST_NAME || ' ' || LAST_NAME                                         이름,
          SALARY                                                                 월급,
          NVL( COMMISSION_PCT, 0 )                                               COMMISSION_PCT,
          NVL2(COMMISSION_PCT, (SALARY * COMMISSION_PCT), 0 )                    "보너스",
          SALARY * 12 + NVL2(COMMISSION_PCT, (SALARY * COMMISSION_PCT), 0)       연봉
 FROM     EMPLOYEES
 ;
 
 
 -------------------------------------------------------------------------------------------------------------------------
 
 -- 3) CASE WHEN THEN END
 -- WHEN SCORE BETWEEN 90 AND 100 THEN 'A'
 -- WHEN 90 <= SCORE AND SCORE <= 100 THEN 'A'
 -- 사번, 이름, 부서명
SELECT     EMPLOYEE_ID                                                            사번,
           FIRST_NAME || ' ' || LAST_NAME                                         이름,
           CASE DEPARTMENT_ID
             WHEN 10  THEN 'Administration'
             WHEN 20  THEN 'Marketing'
             WHEN 30  THEN 'Purchasing'
             WHEN 40  THEN 'Human Resources'
             WHEN 50  THEN 'Shipping'
             WHEN 60  THEN 'IT'
             WHEN 70  THEN 'Public Relations'
             WHEN 80  THEN 'Sales'
             WHEN 90  THEN 'Executive'
             WHEN 100 THEN 'Finance'
             WHEN 110 THEN 'Accounting'
             ELSE          '그 외'
           END                                                                    부서명
 FROM      EMPLOYEES
 ;
 
 SELECT     EMPLOYEE_ID                                                            사번,
           FIRST_NAME || ' ' || LAST_NAME                                          이름,
           CASE 
             WHEN DEPARTMENT_ID = 10  THEN 'Administration'
             WHEN DEPARTMENT_ID = 20  THEN 'Marketing'
             WHEN DEPARTMENT_ID = 30  THEN 'Purchasing'
             WHEN DEPARTMENT_ID = 40  THEN 'Human Resources'
             WHEN DEPARTMENT_ID = 50  THEN 'Shipping'
             WHEN DEPARTMENT_ID = 60  THEN 'IT'
             WHEN DEPARTMENT_ID = 70  THEN 'Public Relations'
             WHEN DEPARTMENT_ID = 80  THEN 'Sales'
             WHEN DEPARTMENT_ID = 90  THEN 'Executive'
             WHEN DEPARTMENT_ID = 100 THEN 'Finance'
             WHEN DEPARTMENT_ID = 110 THEN 'Accounting'
             ELSE          '그 외'
           END                                                                    부서명
 FROM      EMPLOYEES
 ;
 
 -------------------------------------------------------------------------------------------------------------------------
 
 -- 집계함수 : AGGREGATE 함수
 -- 모든 집계함수는 NULL 값을 포함하지 않는다. - NULL은 빼고 계산(만약 NULL로 연산을 할 경우 결과는 무조건 NULL로 나옴)
 -- SUM(), AVG(), MIN(), MAX(), COUNT(), STDDEV(), VARIANCE() - 이것들이 집계함수
 -- 합계   평균   최솟값 최댓값 줄수     표준편차  분산
 -- 그룹핑 : GROUP BY
 -- ~별 인원수
 
SELECT *                    FROM EMPLOYEES;
SELECT COUNT(*)             FROM EMPLOYEES; -- 109 : ROW 줄 수
SELECT COUNT(EMPLOYEE_ID)   FROM EMPLOYEES; -- 109
SELECT COUNT(DEPARTMENT_ID) FROM EMPLOYEES; -- 106


-- SELECT EMPLOYEE_ID          FROM EMPLOYEES -- 누군지 궁금해서 고로시 하고싶을때
SELECT COUNT(EMPLOYEE_ID)   FROM EMPLOYEES -- 몇명인가 세고싶을때
 WHERE DEPARTMENT_ID        IS NULL;

-- 전체 직원의 월급 합을 구한다 : 세로로 합을 구함(하지만 NULL은 제외)
SELECT COUNT(SALARY)          FROM EMPLOYEES; -- 107
SELECT SUM(SALARY)            FROM EMPLOYEES; -- 691416 달러 = 10억 2,046만 874.40 원(달러환율 1475.90원 기준 / 26/04/08 오후 12:10)
SELECT AVG(SALARY)            FROM EMPLOYEES; -- 6461.831775700934579439252336448598130841
SELECT MAX(SALARY)            FROM EMPLOYEES; -- 24000
SELECT MIN(SALARY)            FROM EMPLOYEES; -- 2100

SELECT SUM(SALARY) / COUNT(SALARY) FROM EMPLOYEES; -- 6461.831775700934579439252336448598130841
SELECT SUM(SALARY) / COUNT(*)      FROM EMPLOYEES; -- 6343.266055045871559633027522935779816514
-- ㄴ NULL 의 차이로 인해 발생하는 일

-- 60 번 부서의 평균 월급
SELECT    AVG(SALARY)
 FROM     EMPLOYEES
 WHERE    DEPARTMENT_ID = 60
 ;

-- EMPLOYEES 테이블의 부서수를 알고 싶다
SELECT COUNT(DEPARTMENT_ID)
 FROM  EMPLOYEES -- 106
 ;
 
SELECT DEPARTMENT_ID
 FROM  EMPLOYEES -- 109줄
 ;
 
 -- 중복을 제거(DISTINCT)한 부서의 수를 출력
 -- 중복을 제거한 부서 번호 리스트 : NULL값도 출력
SELECT DISTINCT DEPARTMENT_ID
 FROM  EMPLOYEES -- 12줄 : NULL 값 포함
 ;
 
SELECT COUNT( DISTINCT DEPARTMENT_ID )
 FROM  EMPLOYEES -- 11 : NULL 값 제외
 ; 
 -- ㄴ NULL값을 포함해서 세고싶으면 NVR을 활용해서 NULL 값을 다른것으로 대체하면 됨(살짝 억지)
 
 
-- 직원이 근무하는 부서의 수 : 부서장이 있는 부서수 : DEPARTMENTS
SELECT COUNT( DISTINCT MANAGER_ID )
 FROM  DEPARTMENTS
;

SELECT  7 / 2,
        ROUND(156.456, 2), ROUND(156.456, -2),
        TRUNC(156.456, 2), TRUNC(156.456, -2)
 FROM   DUAL
 ;

-- 직원수, 월급합, 월급평균, 최대월급, 최소월급
SELECT  COUNT(*)                   직원수,
        SUM( SALARY )              월급합,
        ROUND( AVG( SALARY ), 3 )  월급평균,
        MAX( SALARY )              최대월급,
        MIN( SALARY )              최소월급
 FROM   EMPLOYEES
;

-------------------------------------------------------------------------------------------------------------------------

SQL 문의 실행순서
1. SELECT
2. FROM
3. WHERE
4. ORDER BY

-------------------------------------------------------------------------------------------------------------------------

-- 부서 60번 부서 인원수, 월급합, 월급평균
SELECT COUNT(*),
       SUM( SALARY ),
       AVG( SALARY )
 FROM  EMPLOYEES
 WHERE DEPARTMENT_ID = 60
 ;


-- 부서 50, 60, 80 부서가 아닌 인원수, 월급합, 월급평균
-- 22	194716	8850.73 - 원래50, 60, 80이 아닌 인원들은 25명이지만 NULL 3명을 제외해서 22명
SELECT COUNT(*),
       SUM( SALARY ),
       ROUND( AVG( SALARY ), 2 )
 FROM  EMPLOYEES
 -- WHERE DEPARTMENT_ID != ALL(50, 60, 80)
 WHERE DEPARTMENT_ID <> 50
  AND  DEPARTMENT_ID <> 60
  AND  DEPARTMENT_ID <> 80
 ;

SELECT COUNT(*),
       SUM( SALARY ),
       ROUND( AVG( SALARY ), 2 )
 FROM  EMPLOYEES
 WHERE DEPARTMENT_ID != ALL(50, 60, 80)
 -- WHERE DEPARTMENT_ID NOT IN (50, 60, 80)
 ;

-------------------------------------------------------------------------------------------------------------------------
부서별 사원수

SELECT     DEPARTMENT_ID          부서번호,
           COUNT( EMPLOYEE_ID )   사원수
 FROM      EMPLOYEES
 -- WHERE
 GROUP BY  DEPARTMENT_ID 
 -- HAVING 
 -- HAVING을 쓰려면 GROUP BY와 무조건 같이있어야함
 ORDER BY DEPARTMENT_ID
 
 -- ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
;

-- 부서별 월급합, 월급 평균
SELECT DEPARTMENT_ID                     부서번호,
       SUM( SALARY )                     월급,
       ROUND(AVG( SALARY ), 2 )          월급평균
 FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID -- 여기에는 집계함수를 빼야됨
 ORDER BY DEPARTMENT_ID
;

-- 부서별 사원수 통계
SELECT DEPARTMENT_ID                     부서번호,
       COUNT ( EMPLOYEE_ID )             사원수
 FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY DEPARTMENT_ID
;

-- 부서별 인원수가 5명 이상인 부서번호
SELECT DEPARTMENT_ID                     부서번호,
       COUNT( EMPLOYEE_ID )              사원수
 FROM EMPLOYEES
 -- WHERE 
 GROUP BY DEPARTMENT_ID
 ORDER BY 사원수
;

-- 부서별 월급 총계가 2000 이상인 부서번호
SELECT    DEPARTMENT_ID,
          SUM(SALARY)      월급총계
 FROM     EMPLOYEES
 GROUP BY DEPARTMENT_ID
 HAVING   SUM(SALARY) >= 2000
 ORDER BY 월급총계
 ;

-- JOB_ID 별 인원수
SELECT    JOB_ID,
          COUNT(*)    인원수
 FROM     EMPLOYEES
 GROUP BY JOB_ID
 -- HAVING
 ORDER BY 인원수
 ;

-- 입사일 기준 월별 인원수, 2017년 기준

-- 부서별 최대 월급이 14000 이상인 부서의 부서번호와 최대월급




 









 
 





