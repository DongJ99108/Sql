SELECT  * FROM TAB;

----------------------------------------------------------------------------

SUBQUERY : SQL 문안에 SQL 문을 넣어서 실행한 방법
         : 반드시 () 안에 있어야한다.
         : () 안에는 ORDER BY 사용불가
         : WHERE 조건에 맞도록 작성한다
         : 쿼리를 실행하는 순서가 필요할때

----------------------------------------------------------------------------

-- IT 부서의 직원정보를 출력하시오
1) IT 부서의 부서번호를 찾는다 --60
SELECT DEPARTMENT_ID
 FROM  DEPARTMENTS
 WHERE DEPARTMENT_NAME = 'IT'
 ;
2) 60번 부서의 직원정보를 출력
SELECT    EMPLOYEE_ID                    사번,
          FIRST_NAME || ' ' || LAST_NAME 이름,
          DEPARTMENT_ID                  직업번호
 FROM     EMPLOYEES
 WHERE    DEPARTMENT_ID IN (
 -- WHERE    DEPARTMENT_ID = (
  SELECT DEPARTMENT_ID
  FROM  DEPARTMENTS
  WHERE DEPARTMENT_NAME IN ( 'IT', 'Sales' )
  -- WHERE DEPARTMENT_NAME = 'IT'
 )
 ;
 -- 서브쿼리 안에 값이 2개 이상이면 그때는 = 이 아닌 IN 으로 처리해야한다.
 

SELECT    EMPLOYEE_ID                    사번,
          FIRST_NAME || ' ' || LAST_NAME 이름,
          JOB_ID                         직업,
          DEPARTMENT_ID                  직업번호
FROM      EMPLOYEES
WHERE     DEPARTMENT_ID = 60
ORDER BY  EMPLOYEE_ID
;

----------------------------------------------------------------------------

-- 평균월급보다 많은 월급을 받는 사람의 명단
SELECT    EMPLOYEE_ID                    사번,
          FIRST_NAME || ' ' || LAST_NAME 이름,
          SALARY                         월급,
          AVG( SALARY )                  평균월급
 FROM     EMPLOYEES
 --WHERE EMPLOYEE_ID
 --GROUP BY EMPLOYEE_ID
 --HAVING   
 ORDER BY
 ;
 
1) 평균월급 -- 6461.831775700934579439252336448598130841 -- TEACHER
SELECT     AVG( SALARY )
 FROM      EMPLOYEES
 ;
 
2) 월급이 6461.831775700934579439252336448598130841 보다 많은 직원
SELECT     EMPLOYEE_ID,
           FIRST_NAME,
           LAST_NAME,
           SALARY
 FROM      EMPLOYEES
 WHERE     SALARY >= 6461.831775700934579439252336448598130841
 ;
 
 1 + 2)
 SELECT     EMPLOYEE_ID,
           FIRST_NAME,
           LAST_NAME,
           SALARY
 FROM      EMPLOYEES
 WHERE     SALARY >= (
  SELECT     AVG( SALARY )
   FROM      EMPLOYEES
 )
 ;

-- 60번 부서의 평균월급보다 많은 월급을 받는 사람의 명단
1) 60번 평균월급
SELECT AVG( SALARY )
 FROM  EMPLOYEES
 WHERE DEPARTMENT_ID = 60
 ;


2)월급이 5760 보다 많은 직원
SELECT   EMPLOYEE_ID,
         FIRST_NAME,
         LAST_NAME,
         SALARY
FROM     EMPLOYEES
WHERE    SALARY > 5760
ORDER BY SALARY
;

1 + 2)
SELECT   EMPLOYEE_ID,
         FIRST_NAME,
         LAST_NAME,
         SALARY
 FROM     EMPLOYEES
 WHERE   SALARY > (
  SELECT AVG( SALARY )
   FROM  EMPLOYEES
   WHERE DEPARTMENT_ID = 60
 )
 ORDER BY SALARY
 ;
 
 
-- 50번 부서의 최고 월급자의 이름을 출력
1) 50번 부서
SELECT  DEPARTMENT_ID
 FROM   DEPARTMENTS
 WHERE  DEPARTMENT_ID = 50
 ;

2) 50번 부서의 월급자 명단
SELECT   EMPLOYEE_ID,
         FIRST_NAME,
         LAST_NAME,
         DEPARTMENT_ID,
         SALARY
 FROM    EMPLOYEES
 WHERE   DEPARTMENT_ID = (
 SELECT  DEPARTMENT_ID
  FROM   DEPARTMENTS
  WHERE  DEPARTMENT_ID = 50
 )
 ;
 
 3) 50번 부서의 최고 월급자의 이름
SELECT   MAX( SALARY )
 FROM    EMPLOYEES
 WHERE   SALARY = (
 SELECT   EMPLOYEE_ID,
         FIRST_NAME,
         LAST_NAME,
         DEPARTMENT_ID,
         SALARY
 FROM    EMPLOYEES
 WHERE   DEPARTMENT_ID = (
 SELECT  DEPARTMENT_ID
  FROM   DEPARTMENTS
  WHERE  DEPARTMENT_ID = 50
 )
 )
 ;

----------------------------------------------------------------------------

-- 50번 부서의 최고 월급자의 이름을 출력 - TEACHER
1) 50번 부서의 최고 월급자의 월급
SELECT MAX( SALARY )
 FROM  EMPLOYEES
 WHERE DEPARTMENT_ID = 50
 ;
 
 2) 월급자의 이름
 
 SELECT EMPLOYEE_ID,
         FIRST_NAME,
         LAST_NAME,
         DEPARTMENT_ID,
         SALARY
 FROM   EMPLOYEES
 WHERE  SALARY = 8200
 ;
 1 + 2)
 SELECT EMPLOYEE_ID,
         FIRST_NAME,
         LAST_NAME,
         DEPARTMENT_ID,
         SALARY
  FROM   EMPLOYEES
  WHERE  SALARY = (
  SELECT MAX( SALARY )
 FROM  EMPLOYEES
 WHERE DEPARTMENT_ID = 50
  )
  AND DEPARTMENT_ID = 50
  ;
















---------------------------------------------------------------------------- 

-- SALES 부서의 평균월급보다 많은 월급을 받는 사람의 명단
1) SALES 부서
SELECT DEPARTMENT_NAME
 FROM  DEPARTMENTS
 WHERE DEPARTMENT_NAME = 'Sales'
 ;
 
2) SALES 부서의 평균월급
SELECT AVG( SALARY )
 FROM  EMPLOYEES
 WHERE DEPARTMENT_ID = (
  SELECT DEPARTMENT_NAME
   FROM  DEPARTMENTS
   WHERE DEPARTMENT_ID = 80
 )
;

---- SALES 부서의 평균월급보다 많은 월급을 받는 사람의 명단 - TEACHER

1) SALES 부서의 부서번호
SELECT   DEPARTMENT_ID
 FROM    DEPARTMENTS
 WHERE   UPPER( DEPARTMENT_NAME ) = 'SALES'
 ;
2) 1) 부서의 평균월급 = 8955.882352941176470588235294117647058824
SELECT AVG( SALARY )
 FROM  EMPLOYEES
 WHERE DEPARTMENT_ID = (
 SELECT   DEPARTMENT_ID
 FROM    DEPARTMENTS
 WHERE   UPPER( DEPARTMENT_NAME ) = 'SALES'
 )
 ;

3) 2) 보다 많은 월급자의 명단
SELECT EMPLOYEE_ID,
       FIRST_NAME,
       LAST_NAME,
       DEPARTMENT_ID,
       SALARY
 FROM  EMPLOYEES
 WHERE SALARY > (
  SELECT AVG( SALARY )
   FROM  EMPLOYEES
   WHERE DEPARTMENT_ID = (
    SELECT   DEPARTMENT_ID
     FROM    DEPARTMENTS
     WHERE   UPPER( DEPARTMENT_NAME ) = 'SALES'
   ) -- DEPARTMENT_ID
 ) -- SALARY
 ORDER BY DEPARTMENT_ID
;

----------------------------------------------------------------------------
-- 다중열 SUBQUERY
-- employees 테이블에서 job_id별로 가장 낮은 salary가 얼마인지 찾아보고, 
-- 찾아낸 job_id별 salary에 해당하는 직원이 누구인지
SELECT *
FROM EMPLOYEES A
WHERE (A.JOB_ID, A.SALARY) IN (
   SELECT JOB_ID, MIN(SALARY) 그룹별급여
    FROM EMPLOYEES
    GROUP BY JOB_ID
  )
ORDER BY A.SALARY DESC
;

-- 상관 서브 쿼리 CORELATIVE SUBQUERY
-- job_history에 있는 부서번호와 DEPARTMENTS에 있는 부서번호가 같은 부서를 찾아서
-- DEPARTMENTS 에 있는 부서번호와 부서명을 출력
SELECT a.department_id, a.department_name
 FROM departments a
 WHERE EXISTS ( 
  SELECT 1
   FROM job_history b
   WHERE a.department_id = b.department_id );
   
-- SHIPPING 부서의 직원명단
SELECT DEPARTMENT_ID
 FROM  DEPARTMENTS
 WHERE UPPER(DEPARTMENT_NAME) = 'SHIPPING'
 ;

SELECT *
 FROM EMPLOYEES
 WHERE DEPARTMENT_ID = (
 SELECT DEPARTMENT_ID
  FROM  DEPARTMENTS
  WHERE UPPER(DEPARTMENT_NAME) = 'SHIPPING'
 )
 ;
   
----------------------------------------------------------------------------

JOIN

----------------------------------------------------------------------------
직원이름, 부서명-- 출력 줄 수가 109줄

SELECT 109 * 27 FROM DUAL;

** ORACLE OLD 문법(FULL OUTER JOIN 제외) **

1) 카티션프로덕트 : 109 * 27 = 2943 -> CROSS JOIN , 조건이 없는 JOIN;
SELECT  FIRST_NAME || ' ' || LAST_NAME    직원이름, 
        DEPARTMENT_NAME                   부서명
 FROM   EMPLOYEES, DEPARTMENTS
 ;
 
2) 내부조인 : 양쪽다 존재하는 DATA, NULL 제외
   : 109 - 3(부서번호 NULL) = 106 줄 -> INNER JOIN
   비교조건이 필수
SELECT  EMPLOYEES.FIRST_NAME || ' ' || EMPLOYEES.LAST_NAME    직원이름, 
        DEPARTMENT_NAME                   부서명
 FROM   EMPLOYEES, DEPARTMENTS
 WHERE  EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID -- 문서 두개 안에 DEPARTMENT_ID 가 있으니까 둘의 차별점을 두어야함
 -- ㄴ 2개 이상의 테이블에서 자료를 가져올때는 출처를 명확하게 적어줘야 결과값이 나옴
 ;

SELECT  E.FIRST_NAME || ' ' || E.LAST_NAME    직원이름, 
        DEPARTMENT_NAME                   부서명
 FROM   EMPLOYEES   E, DEPARTMENTS   D
 WHERE  E.DEPARTMENT_ID = D.DEPARTMENT_ID
 -- ㄴ FROM에서 별칭을 줬으면 별칭을 써야함, 본명쓰면 화냄;
 ;
 
3) LEFT OUTER JOIN -- 기준을 정해서
모든 직원을 출력하라이 : 109 줄
 직원의 부서번호가 NULL 이라도 악으로 깡으로 출력해야한다
 (+) : 기준(직원)이 되는 조건의 반대방향에 붙인다
       NULL 이 출력될 곳;
       
SELECT   E.FIRST_NAME || ' ' || E.LAST_NAME   이름,
         D.DEPARTMENT_NAME                    부서명
 FROM    EMPLOYEES  E, DEPARTMENTS  D
 WHERE   E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
 ;

4) RIGHT OUTER JOIN -- 기준을 정해서
SELECT   E.FIRST_NAME || ' ' || E.LAST_NAME   이름,
         D.DEPARTMENT_NAME                    부서명
 FROM    EMPLOYEES  E, DEPARTMENTS  D
 WHERE   D.DEPARTMENT_ID(+) = E.DEPARTMENT_ID
 ;

5) RIGHT OUTER JOIN
 모든 부서를 출력하라이 - 122 : ( 109 - 3(NULL 직원) ) + ( 27(모든 부서) - 11(소속된 직원이 있는 부서) )
 직원정보가 없더라도 악으로 깡으로 출력해야한다
SELECT   E.FIRST_NAME || ' ' || E.LAST_NAME   이름,
         D.DEPARTMENT_NAME                    부서명
 FROM    EMPLOYEES  E, DEPARTMENTS  D
 WHERE   E.DEPARTMENT_ID(+) = D.DEPARTMENT_ID
 ;

5) FULL OUTER JOIN - OLD 문법에 존재하지 않는 명령
   모든 직원과 모든 부서를 출력

------------------------------------------------------------------------

표준 SQL 문법
1. CROSS JOIN : 2943
SELECT   E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
 FROM    EMPLOYEES  E CROSS JOIN DEPARTMENTS  D
 ;

2. (INNER) JOIN : 106 -- 테이블 두개를 붙일때 ON을 씀, 다른조건을 붙일때는 WHERE을 쓴대
    -- ㄴ INNER를 생략해도 INNER JOIN인지 안다
SELECT  E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
 FROM   EMPLOYEES  E INNER JOIN DEPARTMENTS  D 
   ON   E.DEPARTMENT_ID = D.DEPARTMENT_ID
 ;

3. OUTER JOIN
3-1) LEFT  ( OUTER ) JOIN -- 109
SELECT  E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
 FROM   EMPLOYEES E LEFT JOIN DEPARTMENTS D
  ON    E.DEPARTMENT_ID = D.DEPARTMENT_ID
  ;

3-2) RIGHT ( OUTER ) JOIN -- 122
SELECT  E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
 FROM   EMPLOYEES E RIGHT JOIN DEPARTMENTS D
  ON    E.DEPARTMENT_ID = D.DEPARTMENT_ID
  ;

3-3) FULL  ( OUTER ) JOIN -- 125(RIGHT JOIN에서 NULL 3명 추가)
SELECT  E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
 FROM   EMPLOYEES E FULL JOIN DEPARTMENTS D
  ON    E.DEPARTMENT_ID = D.DEPARTMENT_ID
  ;

------------------------------------------------------------------------
-- 직원이름, 담당업무(JOB_TITLE)
-- INNER JOIN
-- LEFT JOIN
-- RIGHT JOIN
-- FULL JOIN

-- INNER JOIN - 109
SELECT  E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE
 FROM   EMPLOYEES E INNER JOIN JOBS J
  ON    E.JOB_ID = J.JOB_ID
 ;
-- RIGHT JOIN - 109
SELECT  E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE
 FROM   EMPLOYEES E RIGHT JOIN JOBS J
  ON    E.JOB_ID = J.JOB_ID
 ;
-- LEFT JOIN - 109
SELECT  E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE
 FROM   EMPLOYEES E LEFT JOIN JOBS J
  ON    E.JOB_ID = J.JOB_ID
 ;
-- 지금 INNER, RIGHT, LEFT 전부 데이터 값에 차이가 없는 이유는 NULL이 없어서이다
-- 애초에 JOIN 명령어 자체가 NULL때문에 쓰는것인데 NULL이 없으니 차이가 없는것 아마 FULL로 해도 차이가 없겠지?
-- FULL JOIN - 109 위랑 차이가 없다
SELECT  E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE
 FROM   EMPLOYEES E FULL JOIN JOBS J
  ON    E.JOB_ID = J.JOB_ID
 ;
 
------------------------------------------------------------------------

-- 부서명, 부서위치(CITY, STREET_ADDRESS)



-- INNER JOIN - 27
SELECT  D.DEPARTMENT_NAME, L.CITY, L.STREET_ADDRESS
 FROM   DEPARTMENTS D INNER JOIN LOCATIONS L
  ON    D.LOCATION_ID = L.LOCATION_ID
  ;
-- LEFT JOIN -27
SELECT  D.DEPARTMENT_NAME, L.CITY, L.STREET_ADDRESS
 FROM   DEPARTMENTS D LEFT JOIN LOCATIONS L
  ON    D.LOCATION_ID = L.LOCATION_ID
  ;
-- RIGHT JOIN - 43
SELECT  D.DEPARTMENT_NAME, L.CITY, L.STREET_ADDRESS
 FROM   DEPARTMENTS D RIGHT JOIN LOCATIONS L
  ON    D.LOCATION_ID = L.LOCATION_ID
  ;
-- 자 여기서 LEFT랑 RIGHT가 차이나는 이유는 DEPARTMENTS 안에서는 NULL 값이 있지만 LOCATION 안에는 NULL값이 없기 때문이다.
-- 그렇다면 왜 RIGHT에 더 많은 데이터가 찍히는가
-- DEPARTMENTS << LOCATION 로는 모든 데이터가 대응이 되지만     (LEFT)
-- DEPARTMENTS >> LOCATION 로는 모든 데이터가 대응이 안되기때문 (RIGHT)

-- FULL JOIN - 43
SELECT  D.DEPARTMENT_NAME, L.CITY, L.STREET_ADDRESS
 FROM   DEPARTMENTS D FULL JOIN LOCATIONS L
  ON    D.LOCATION_ID = L.LOCATION_ID
  ;

------------------------------------------------------------------------

-- 직원명, 부서명, 부서위치(CITY, STREE_ADDRESS)
-- TEACHER
SELECT  E.FIRST_NAME || ' ' || E.LAST_NAME 직원명,
        D.DEPARTMENT_NAME                  부서명,
        L.CITY || ' ' || L.STREET_ADDRESS  부서위치                    
 FROM   EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
  AND  D.LOCATION_ID = L.LOCATION_ID
 ORDER BY 직원명
 ;
--INNER JOIN - TEACHER
SELECT  E.FIRST_NAME || ' ' || E.LAST_NAME 직원명,
        D.DEPARTMENT_NAME                  부서명,
        L.CITY || ' ' || L.STREET_ADDRESS  부서위치
 FROM   EMPLOYEES E
        JOIN DEPARTMENTS D ON  E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN LOCATIONS   L ON  D.LOCATION_ID = L.LOCATION_ID
 ORDER BY 직원명 ASC
 ;
 
-- LEFT JOIN - TEACHER - 이거때문이었다
SELECT  E.FIRST_NAME || ' ' || E.LAST_NAME 직원명,
        D.DEPARTMENT_NAME                  부서명,
        L.CITY || ' ' || L.STREET_ADDRESS  부서위치
 FROM   EMPLOYEES E
        LEFT JOIN DEPARTMENTS D ON  E.DEPARTMENT_ID = D.DEPARTMENT_ID
        LEFT JOIN LOCATIONS   L ON  D.LOCATION_ID = L.LOCATION_ID
 ORDER BY 직원명 ASC
 ;
 

SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, L.STREET_ADDRESS
 FROM  DEPARTMENTS D FULL JOIN LOCATIONS L
  ON   D.LOCATION_ID = L.LOCATION_ID INNER JOIN EMPLOYEES E
  ON   E.DEPARTMENT_ID = D.DEPARTMENT_ID
  ;
  
------------------------------------------------------------------------
SELECT  E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
 FROM   EMPLOYEES E LEFT JOIN DEPARTMENTS D
  ON    E.DEPARTMENT_ID = D.DEPARTMENT_ID
  ;

------------------------------------------------------------------------

-- 직원명, 부서명, 국가, 부서위치(CITY, STREE_ADDRESS)
SELECT  E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, R.REGION_NAME, L.CITY, L.STREET_ADDRESS
 FROM   EMPLOYEES E JOIN DEPARTMENTS D
  ON    E.DEPARTMENT_ID = D.DEPARTMENT_ID INNER JOIN LOCATIONS L
  ON    D.LOCATION_ID = L.LOCATION_ID INNER JOIN COUNTRIES C
  ON    L.COUNTRY_ID = C.COUNTRY_ID INNER JOIN REGIONS R
  ON    C.REGION_ID = R.REGION_ID
  ;
  
-- 직원명, 부서명, 국가, 부서위치(CITY, STREE_ADDRESS) - TEACHER
SELECT  E.FIRST_NAME || ' ' || E.LAST_NAME 직원명,
        D.DEPARTMENT_NAME                  부서명,
        C.COUNTRY_NAME                     국가,
        L.CITY || ' ' || L.STREET_ADDRESS  부서위치
 FROM   EMPLOYEES E
        JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN LOCATIONS   L ON D.LOCATION_ID   = L.LOCATION_ID
        JOIN COUNTRIES   C ON L.COUNTRY_ID    = C.COUNTRY_ID
 ORDER BY 직원명, 부서명
 ;

------------------------------------------------------------------------

-- 부서명, 국가 : 모든 부서 : 27줄 이상
SELECT   D.DEPARTMENT_NAME 부서명, C.COUNTRY_NAME 국가 -- R.REGION_NAME
 FROM  DEPARTMENTS D 
       JOIN LOCATIONS L ON   D.LOCATION_ID = L.LOCATION_ID 
       JOIN COUNTRIES C ON   L.COUNTRY_ID  = C.COUNTRY_ID 
       -- JOIN REGIONS   R ON   C.REGION_ID   = R.REGION_ID
 ORDER BY 부서명, 국가
  ;

------------------------------------------------------------------------

-- 직원명, 부서위치 단 IT 부서만
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, C.COUNTRY_NAME
 FROM  EMPLOYEES E JOIN DEPARTMENTS D
  ON   E.DEPARTMENT_ID = D.DEPARTMENT_ID JOIN LOCATIONS L
  ON   D.LOCATION_ID = L.LOCATION_ID JOIN COUNTRIES C
  ON   L.COUNTRY_ID = C.COUNTRY_ID
  ;

-- 직원명, 부서위치 단 IT 부서만 - TEACHER
SELECT E.FIRST_NAME || ' ' || LAST_NAME   직원명,
       D.DEPARTMENT_NAME                  부서명,
       L.STATE_PROVINCE || ',' || L.CITY || ',' || L.STREET_ADDRESS  부서위치
 FROM  EMPLOYEES E
       LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
       LEFT JOIN LOCATIONS   L ON D.LOCATION_ID   = L.LOCATION_ID
 -- WHERE E.JOB_ID LIKE 'IT%' -- 보검이랑 리나는 아직 부서가 정해지지않아서 나오지않는게 맞다
 WHERE D.DEPARTMENT_ID = 60
 ORDER BY 직원명
;

-- 60번 부서 최소월급과 같은 월급자의 명단출력
1) 60번 부서 최소월급 - 4200
SELECT MIN( SALARY )
 FROM  EMPLOYEES
 WHERE DEPARTMENT_ID = 60
 ;
2) 4200달러 가치의 사람들 출력 - 2명(다이애나 응우옌(60), 난디타 사찬드(50))
SELECT *
 FROM  EMPLOYEES
 WHERE SALARY = (
  SELECT MIN( SALARY )
   FROM  EMPLOYEES
   WHERE DEPARTMENT_ID = 60
 )
 AND DEPARTMENT_ID != 60
 ;
 
-- 부서명 별 월급 평균
SELECT D.DEPARTMENT_NAME 부서명,
       -- NVL(ROUND( AVG( SALARY ), 3 ), 0)     "평균 월급" -- 정상출력
       -- NVL(ROUND( AVG( SALARY ), 3 ), '직원없음')     "평균 월급" -- NVL은 앞에것이 숫자면 뒤에도 숫자여야함
       DECODE( ROUND( AVG( E.SALARY ), 3 ), NULL, '직원없음', ROUND( AVG( E.SALARY ), 3 ) ) "평균 월급"
 FROM  EMPLOYEES E 
       RIGHT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
 GROUP BY D.DEPARTMENT_NAME
 ORDER BY AVG( E.SALARY ) DESC
 ;
 
-- 직원의 근무연수
-- MONTHS_BETWEEN(날짜1, 날짜2) : 날짜1 - 날짜2 : 월단위로
-- ADD_MONTH(날짜, N) : 날짜+N개월 / 날짜-N개월
SELECT FIRST_NAME || ' ' || LAST_NAME                       직원명, 
       TO_CHAR( HIRE_DATE, 'YYYY-MM-DD' )                   입사일,
       TO_CHAR( TRUNC( HIRE_DATE, 'MONTH'), 'YYYY-MM-DD' )  "입사월의 첫번째날",
       TO_CHAR( LAST_DAY( HIRE_DATE ), 'YYYY-MM-DD' )       "입사월의 마지막날",
       TRUNC( SYSDATE - HIRE_DATE )                         근무일수,
       TRUNC( ( SYSDATE - HIRE_DATE ) / 365.2422 )          근무연수1,
       TRUNC( MONTHS_BETWEEN( SYSDATE, HIRE_DATE ) / 12 )   근무연수2
 FROM  EMPLOYEES
 ;

-- 부서명, 부서장의 이름
1) INNER JOIN : 양쪽다 존재하는 데이터만 출력
SELECT   D.DEPARTMENT_NAME                 부서명,
         E.FIRST_NAME || ' ' || LAST_NAME  "부서장의 이름"
 FROM    DEPARTMENTS D
  JOIN   EMPLOYEES   E ON D.MANAGER_ID = E.EMPLOYEE_ID
  ;
2) 모든 부서에 대해 출력
SELECT   D.DEPARTMENT_NAME                 부서명,
         E.FIRST_NAME || ' ' || LAST_NAME  "부서장의 이름"
 FROM    DEPARTMENTS D
  LEFT JOIN   EMPLOYEES   E ON D.MANAGER_ID = E.EMPLOYEE_ID
;
-- ㄴ NULL이 안뜨고 공백이 자리한다

--------------------------------------------------------------------------
결합연산자 - 줄 단위 결합
 조건 -- 두 테이블의 칸수와 타입이 동일해야한다
 1) UNION     중복 제거
 2) UNION ALL 중복 포함
 3) INTERSECT 교집합 : 공통부분
 4) MINUS     차집합 A - B
 
 SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 80; -- 34
 SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 50; -- 45
 
 SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 80
 UNION
 SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 50; -- 79
 
 -- 칼럼수와 칼럼들의 TYPE이 같으면 합쳐진다 -> 주의해야함... 잘못하면 의도하지 않은 결합이 일어날 수 있기 때문
 SELECT EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES
 UNION
 SELECT DEPARTMENT_ID, DEPARTMENT_NAME FROM DEPARTMENTS;
 

-- 직원정보, 담당업무
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME 직원이름,
       J.JOB_TITLE                        담당업무
 FROM EMPLOYEES E
      LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID
;

-- 직원명, 담당업무, 담당업무 히스토리

-- 사번, 업무시작일, 업무종료일, 담당업무, 부서번호
SELECT E.EMPLOYEE_ID       사번,
       H.START_DATE        "업무 시작일",
       H.END_DATE          "업무 종료일",
       J.JOB_TITLE         담당업무,
       E.DEPARTMENT_ID     부서번호
 FROM  EMPLOYEES E 
       LEFT JOIN JOB_HISTORY H ON E.EMPLOYEE_ID = H.EMPLOYEE_ID
       LEFT JOIN JOBS J        ON H.JOB_ID = J.JOB_ID
;

















