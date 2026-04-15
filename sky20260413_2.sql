
성적처리 TABLE
 업무
 학생 : 학번, 이름, 전화, 입학일
 성적 : 학번, 국어, 영어, 수학, 총점, 평균, 석차 결과
 과목은 변경될 수 있다.
 
 TABLE 생성
 학생     : 학번(PK), 이름,   전화,   입학일
 STUDENT    STID      STNAME  PHONE   INDATE  
 
 성적     : 일련번호(PK), 교과목,   점수,   학번(FK)
 SCORES     SCID          SUBJECT   SCORE   STID
 
 -- 제약조건(CONSTRAINTS) - 무결성  
  TABLE 에 저장될 데이터에 조건을 부여하여 잘못된 DATA 입력되는 것을 방지
  1. 주식별자 설정 : 기본키
     PRIMARY KEY     : NOT NULL + UNIQUE 기본 적용
      CREATE TABLE 명령안에 한번만 사용가능
  2. NOT NULL / NULL : 필수입력, 컬럼단위 제약조건
  3. UNIQUE          : 중복방지
  4. CHECK           : 값의 범위지정 , DOMAIN 제약 조건 
  5. FOREIGN KEY     : 외래키 제약조건
  

-- 관계가 설정된 테이블 삭제방법 1
DROP TABLE SCORES;  -- 자식 테이블을 먼저 삭제해야됨
DROP TABLE STUDENT; -- 그다음 얘를 지워야 지워짐(부모테이블을 나중에 삭제 해야한다는 뜻)

-- 관계가 설정된 테이블 삭제방법 2
DROP TABLE STUDENT CASCADE CONSTRAINTS PURGE; -- 순서에 무관하게 삭제 가능
DROP TABLE SCORES;



 학생     : 학번(PK), 이름,   전화,   입학일
 STUDENT    STID      STNAME  PHONE   INDATE 
CREATE TABLE STUDENT
(
 STID      NUMBER(6)    PRIMARY KEY     -- 학번 숫자(6) 기본키
 ,STNAME   VARCHAR2(30) NOT NULL        -- 이름 문자(30) 필수입력
 ,PHONE    VARCHAR2(20) UNIQUE          -- 전화 문자(20) 중복방지
 ,INDATE   DATE         DEFAULT SYSDATE -- 입학일 날짜 기본값 오늘
 -- 날짜에 CHECK 조건을 거는것에 버그가 있음
);

-- 학생정보 입력
INSERT INTO STUDENT( STID, STNAME, PHONE, INDATE )
 VALUES            ( 1,   '가나',  '010', SYSDATE );
 
INSERT INTO STUDENT -- ( STID, STNAME, PHONE, INDATE ) 칸이 딱 맞을땐 이걸 안적어도 됨(전체 칸 - 4칸, 입력 칸 - 4칸)
 VALUES            ( 2,   '나나',  '011', SYSDATE );

INSERT INTO STUDENT( STID, STNAME, PHONE ) -- 칸이 딱 맞지 않을땐 이렇게 정해줘야함(전체 칸 - 4칸, 입력 칸 - 3칸)
 VALUES            ( 3,   '다나',  '012' );
 
INSERT INTO STUDENT( STID, STNAME, PHONE )
 VALUES            ( 4,   '라나',  '013' );
 
INSERT INTO STUDENT( STID, STNAME, PHONE )
 VALUES            ( 5,   '라나',  '014' );
 
INSERT INTO STUDENT( STID, STNAME, PHONE )
 VALUES            ( NULL,   '사나',  '015' ); -- 입력안됨 : 학번 칸은 NOT NULL이기 때문(PRIMARY KEY 제약조건 위반)
-- SQL 오류: ORA-01400: NULL을 ("SKY"."STUDENT"."STID") 안에 삽입할 수 없습니다
 
INSERT INTO STUDENT( STID, STNAME, PHONE )
 VALUES            ( 5,   '라나',  '014' );
-- ORA-00001: 무결성 제약 조건(SKY.SYS_C008387)에 위배됩니다

INSERT INTO STUDENT( STID, STNAME, PHONE )
 VALUES            ( 6,   '하나',  '014' ); -- 입력 안됨 - PHONE 넘버 중복
-- ORA-00001: 무결성 제약 조건(SKY.SYS_C008388)에 위배됩니다

INSERT INTO STUDENT( STID, STNAME, PHONE )
 VALUES            ( 7,   NULL,  '018' ); -- 아까 학번이 안되던것과 같은 논리
-- SQL 오류: ORA-01400: NULL을 ("SKY"."STUDENT"."STNAME") 안에 삽입할 수 없습니다

COMMIT;

INSERT INTO STUDENT( STID, STNAME, PHONE )
 VALUES            ( 6,   '하나',  '019' );
 
SELECT * FROM STUDENT;

COMMIT; -- 커밋을 하기 전이라도 테이블에선 보이지만 CMD에서 테이블을 검색했을땐 보이지 않음

 성적     : 일련번호(PK), 교과목,   점수,   학번(FK)
 SCORES     SCID          SUBJECT   SCORE   STID
 
CREATE TABLE SCORES
(
 SCID        NUMBER(7)    NOT NULL    -- 일련번호 숫자(7)  기본키, 번호 자동증가
 ,SUBJECT    VARCHAR2(60) NOT NULL    -- 교과목   문자(60) 필수입력
 ,SCORE      NUMBER(3)    CHECK( SCORE BETWEEN 0 AND 100 ) 
                                    -- 점수     숫자(3)  범위0 ~ 100
 ,STID       NUMBER(6)    -- 학번     숫자(6)  외래키
 ,CONSTRAINT   SCID_PK
   PRIMARY KEY ( SCID, SUBJECT )
 ,CONSTRAINT   STID_FK
   FOREIGN KEY ( STID )
   REFERENCES  STUDENT(STID) 
);

INSERT INTO SCORES( SCID, SUBJECT, SCORE, STID )
 VALUES           ( 1,    '국어',  100, 1 );

INSERT INTO SCORES VALUES ( 2,  '영어', 100,  1 );
INSERT INTO SCORES VALUES ( 3,  '수학', 100,  1 );
INSERT INTO SCORES VALUES ( 4,  '국어', 100,  2 );
INSERT INTO SCORES VALUES ( 5,  '수학',  80,  2 ); -- 여기까진 스무스하게 입력 성공
INSERT INTO SCORES VALUES ( 6,  '국어',  70,  4 );
INSERT INTO SCORES VALUES ( 7,  '영어',  80,  4 );
INSERT INTO SCORES VALUES ( 8,  '수학',  85,  4 );
INSERT INTO SCORES VALUES ( 9,  '국어', 805,  5 ); -- ORA-02290: 체크 제약조건(SKY.SYS_C008391)이 위배되었습니다
INSERT INTO SCORES VALUES ( 10, '영어', 100,  8 ); -- ORA-02291: 무결성 제약조건(SKY.STID_FK)이 위배되었습니다- 부모 키가 없습니다 - 패드립?

DML 추가, 수정, 삭제 -- COMMIT 필수
1. INSERT(추가) - 줄 (DATA) 추가
 1) INSERT INTO SCORES( SCID, SUBJECT, SCORE, STID )
     VALUES           ( 1,    '국어',  100,   1 );
 2) 여러줄 추가
   INSERT INTO EMP4
    SELECT * FROM HR.EMPLOYEES;
 3) INSERT 문 여러개를 한번에 실행 = 여러줄 추가( NEW 문법! )
    CREATE TABLE EX_SKY
    (
     ID NUMBER(7) PRIMARY KEY,
     NAME VARCHAR2(30) NOT NULL
    );
    
    INSERT ALL
     INTO EX_SKY VALUES( 103, '이순신' )
     INTO EX_SKY VALUES( 104, '김유신' )
     INTO EX_SKY VALUES( 105, '강감찬' )
    SELECT * FROM DUAL;
    -- 한번에 3줄이 입력 -> 놀랍다! (DB가 지원해야 사용가능)
    
    COMMIT;

2. DELETE -- 줄(DATA) 를 삭제한다, 기본적으로 여러줄이 대상이다.
          -- WHERE이 없으면 전체를 대상으로 작업한다.
   DELETE
    FROM  테이블명
    WHERE 조건;
-- 너무 간단해서 따로 덧붙일 설명이나 메모가 없다.
3. UPDATE -- 줄에 변화는 없고 칸에 있는 정보만 수정
          -- WHERE이 없으면 전체를 대상으로 작업한다.
   UPDATE 테이블
    SET 칼럼1 = 고칠값1,
        칼럼2 = 고칠값2,
        칼럼3 = 고칠값3
    WHERE 조건;
    
SELECT * FROM SCORES;

   UPDATE SCORES
    SET   SCORE = 70
    WHERE SCID  = 6;
-- 위의 식에서 WHERE을 빼고 실행시켜버리면 모두를 대상으로 데이터를 바꿔버린다. 조심하라는 뜻

ROLLBACK;
--------------------------------------------------------------------------------
DATA 제거
1. DROP TABLE SCORES;      -- 구조( 테이블 ), DATA 모두 삭제, 복구불가능

2. TRUNCATE TABLE SCORES;  -- 구조 남기고 DATA 만 삭제 속도 빠름

3. DELETE FROM SCORES;     -- 구조 남기가 DATA 만 삭제 속도 느림

SCORES DATA 삭제
-- SET TIMING ON

SELECT * FROM SCORES;
DELETE   FROM SCORES;
SELECT * FROM SCORES;
ROLLBACK;

SELECT * FROM STUDENT;
DELETE   FROM STUDENT; -- ORA-02292: 무결성 제약조건(SKY.STID_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
-- 자식 먼저 지우고 DELETE를 하면 지워진다
SELECT * FROM STUDENT;

INSERT INTO STUDENT VALUES( 11, '히나', '0111', SYSDATE );
COMMIT;

DELETE 
 FROM STUDENT
 WHERE STID = 1
; -- ORA-02292: 무결성 제약조건(SKY.STID_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다

DELETE 
 FROM STUDENT
 WHERE STID = 11
; -- 이건 지워짐 -> 왜? 1번은 SCORES에 자기의 점수가 할당되어 있지만 11번은 없기때문에 자식레코드가 없음

외래키 관계에서 자식테이블의 DATA 를 지우고 부모 테이블에 DATA를 삭제하면 된다.

DELETE
 FROM SCORES
 WHERE STID = 1
;

DELETE
 FROM STUDENT
 WHERE STID = 1
;

DROP TABLE SCORES;
DROP TABLE STUDENT;

--------------------------------------------------------------------------------

성적처리 TABLE
 업무
 학생 : 학번, 이름, 전화, 입학일
 성적 : 학번, 국어, 영어, 수학, 총점, 평균, 석차 결과
 과목은 변경될 수 있다.

--------------------------------------------------------------------------------
학생
SELECT * FROM STUDENT;
SELECT * FROM SCORES;


조회
1. 학번, 이름, 점수(국어)
SELECT    T.STID     학번, 
          T.STNAME   이름, 
          C.SUBJECT  과목명, 
          C.SCORE    "점수(국어)"
 FROM SCORES C
  FULL JOIN STUDENT T ON C.STID = T.STID
 WHERE    C.SUBJECT = '국어'
 ORDER BY T.STID
;

2. 학번, 이름, 총점, 평균
SELECT    T.STID                    학번, 
          T.STNAME                  이름, 
          SUM(C.SCORE)              총점, 
          ROUND( AVG(C.SCORE), 2 )  평균
 FROM SCORES C
  FULL JOIN STUDENT T ON C.STID = T.STID
 GROUP BY T.STID, T.STNAME
 ORDER BY T.STID
;

2. 학번, 이름, 총점, 평균 - TEACHER
SELECT ST.STID                    학번, 
       ST.STNAME                  이름, 
       SUM(SC.SCORE)              총점, 
       ROUND( AVG(SC.SCORE), 2 )  평균
 FROM STUDENT ST LEFT JOIN SCORES SC
  ON  ST.STID = SC.STID
 GROUP BY ST.STID, ST.STNAME
 ORDER BY ST.STID ASC
;

3. 모든 학생의 학번, 이름, 총점, 평균
   점수가 NULL인 학생은 '미응시' 처리
SELECT    T.STID                                                                          학번, 
          T.STNAME                                                                        이름, 
          NVL2(SUM(C.SCORE), TO_CHAR(SUM(C.SCORE)), '미응시')                             총점,
          NVL2(ROUND( AVG(C.SCORE), 2 ), TO_CHAR( ROUND( AVG(C.SCORE), 2 ) ), '미응시' )  평균
 FROM SCORES C
  FULL JOIN STUDENT T ON C.STID = T.STID
 GROUP BY T.STID, T.STNAME
 ORDER BY T.STID
;

3. 모든 학생의 학번, 이름, 총점, 평균
   점수가 NULL인 학생은 '미응시' 처리 - TEACHER
SELECT ST.STID                    학번, 
       ST.STNAME                  이름, 
       DECODE(SUM(SC.SCORE), NULL, '미응시', SUM(SC.SCORE))   총점, 
       CASE 
        WHEN ROUND( AVG(SC.SCORE), 2 ) IS NULL THEN '미응시'
        ELSE           TO_CHAR( AVG(SC.SCORE), '990.00' )
        END                                                   평균
 FROM STUDENT ST LEFT JOIN SCORES SC
  ON  ST.STID = SC.STID
 GROUP BY ST.STID, ST.STNAME
 ORDER BY ST.STID ASC
;
SELECT 학번, 이름, 
       DECODE(총점, NULL, '미응시', TO_CHAR(총점, '990') ),
       DECODE(평균, NULL, '미응시', TO_CHAR(평균, '990.00') )
 FROM (
SELECT ST.STID                    학번, 
       ST.STNAME                  이름, 
       SUM(SC.SCORE)              총점, 
       ROUND( AVG(SC.SCORE), 2 )  평균
 FROM STUDENT ST LEFT JOIN SCORES SC
  ON  ST.STID = SC.STID
 GROUP BY ST.STID, ST.STNAME
 ORDER BY ST.STID ASC
)
;






4. 모든 학생의 학번, 이름, 총점, 평균, 등급, 석차
SELECT T.STID                                                                         학번, 
       T.STNAME                                                                       이름, 
       NVL2(SUM(C.SCORE), TO_CHAR(SUM(C.SCORE)), '미응시')                            총점, 
       NVL2(ROUND( AVG(C.SCORE), 2 ), TO_CHAR( ROUND( AVG(C.SCORE), 2 ) ), '미응시' ) 평균,
       CASE 
        WHEN 90 <= AVG(C.SCORE) AND AVG(C.SCORE) <=  100 THEN 'S'
        WHEN 80 <= AVG(C.SCORE) AND AVG(C.SCORE)  <   90 THEN 'A'
        WHEN 70 <= AVG(C.SCORE) AND AVG(C.SCORE)  <   80 THEN 'B'
        ELSE                                 '노답'
        END                                                                            등급,
       RANK() OVER ( ORDER BY AVG(C.SCORE) DESC NULLS LAST )                           석차
 FROM  SCORES C
  FULL JOIN STUDENT T ON C.STID = T.STID
 GROUP BY T.STID, T.STNAME
 ORDER BY AVG(C.SCORE) DESC NULLS LAST
;

4. 모든 학생의 학번, 이름, 총점, 평균, 등급, 석차 - TEACHER
-- 점수가 NULL 인 학생은 미응시로 처리
SELECT ST.STID                                                         학번,
       ST.STNAME                                                       이름,
       CASE
         WHEN SUM(SC.SCORE) IS NULL THEN '미응시'
          ELSE TO_CHAR(SUM(SC.SCORE), '990')
         END                                                           총점,
       CASE
         WHEN AVG(SC.SCORE) IS NULL THEN '미응시'
          ELSE TO_CHAR(AVG(SC.SCORE), '990.00')
         END                                                           평균, 
       CASE
        WHEN ROUND(AVG( SC.SCORE ), 2) BETWEEN 90 AND 100 THEN   'A'
        WHEN ROUND(AVG( SC.SCORE ), 2) BETWEEN 80 AND 89.99 THEN 'B'
        WHEN ROUND(AVG( SC.SCORE ), 2) BETWEEN 70 AND 79.99 THEN 'C'
        WHEN ROUND(AVG( SC.SCORE ), 2) BETWEEN 60 AND 69.99 THEN 'D'
       ELSE                                                      'F'
       END                                                             등급, 
       RANK() OVER( ORDER BY SUM(SC.SCORE) DESC NULLS LAST )           석차
 FROM  STUDENT ST
  LEFT JOIN SCORES SC ON ST.STID = SC.STID
  GROUP BY ST.STID, ST.STNAME
;




5. 모든 학생의 학번, 이름, 국어, 영어, 수학, 총점, 평균, 등급, 석차 -- 어떻게 하는거야 슈발
SELECT T.STID                                                                         학번, 
       T.STNAME                                                                       이름,
       NVL2(SUM(C.SCORE), TO_CHAR(SUM(C.SCORE)), '미응시')                            총점, 
       NVL2(ROUND( AVG(C.SCORE), 2 ), TO_CHAR( ROUND( AVG(C.SCORE), 2 ) ), '미응시' ) 평균,
       CASE 
        WHEN 90 <= AVG(C.SCORE) AND AVG(C.SCORE) <=  100 THEN 'S'
        WHEN 80 <= AVG(C.SCORE) AND AVG(C.SCORE)  <   90 THEN 'A'
        WHEN 70 <= AVG(C.SCORE) AND AVG(C.SCORE)  <   80 THEN 'B'
        ELSE                                 '노답'
        END                                                                            등급,
        RANK() OVER ( ORDER BY AVG(C.SCORE) DESC NULLS LAST )                          석차
 FROM  SCORES C
  FULL JOIN STUDENT T ON C.STID = T.STID
 GROUP BY T.STID, T.STNAME
 ORDER BY AVG(C.SCORE) DESC NULLS LAST
;

--------------------------------------------------------------------------------

-- 모든 학생의 학번, 이름, 국어, 영어, 수학, 총점, 평균, 등급, 석차 - TEACHER

-- 학번, 이름, 국어, 영어, 수학, 총점, 평균
1. ORACLE 10G 방식
1-1) 학번, 국어, 영어, 수학
SELECT  SC.STID                                 학번, 
        DECODE( SC.SUBJECT, '국어', SC.SCORE )  국어,
        DECODE( SC.SUBJECT, '영어', SC.SCORE )  영어,
        DECODE( SC.SUBJECT, '수학', SC.SCORE )  수학
 FROM   SCORES SC;

1-2) 학번, 국어, 영어, 수학
SELECT  SC.STID                                        학번, 
        SUM( DECODE( SC.SUBJECT, '국어', SC.SCORE ) )  국어,
        SUM( DECODE( SC.SUBJECT, '영어', SC.SCORE ) )  영어,
        SUM( DECODE( SC.SUBJECT, '수학', SC.SCORE ) )  수학
 FROM   SCORES SC
 GROUP BY SC.STID
;

1-3) 학번, 이름, 국어, 영어, 수학 : JOIN 추가
SELECT  ST.STID                                        학번,
        ST.STNAME                                      이름,
        SUM( DECODE( SC.SUBJECT, '국어', SC.SCORE ) )  국어,
        SUM( DECODE( SC.SUBJECT, '영어', SC.SCORE ) )  영어,
        SUM( DECODE( SC.SUBJECT, '수학', SC.SCORE ) )  수학
 FROM   SCORES SC
  FULL JOIN STUDENT ST ON SC.STID = ST.STID
 GROUP BY ST.STID, ST.STNAME
 ORDER BY ST.STID
;

1-4) 학번, 이름, 국어, 영어, 수학, 총점, 평균
SELECT  ST.STID                                        학번,
        ST.STNAME                                      이름,
        SUM( DECODE( SC.SUBJECT, '국어', SC.SCORE ) )  국어,
        SUM( DECODE( SC.SUBJECT, '영어', SC.SCORE ) )  영어,
        SUM( DECODE( SC.SUBJECT, '수학', SC.SCORE ) )  수학,
        SUM(SCORE)                                     총점, 
        ROUND( AVG(SCORE), 2 )                         평균
 FROM   SCORES SC
  FULL JOIN STUDENT ST ON SC.STID = ST.STID
 GROUP BY ST.STID, ST.STNAME
 ORDER BY ST.STID
;

1-5)학번, 이름, 국어, 영어, 수학, 총점, 평균, 등급, 석차
-- 미응시자는 '미응시' 로 출력
-- 등급 : 비등가 조인으로 해결

DROP TABLE SCOREGRADE;

CREATE TABLE SCOREGRADE
(
 GRADE     VARCHAR2(1) PRIMARY KEY,
 LOSCORE   NUMBER(6, 2),
 HISCORE   NUMBER(6, 2)
)
;
INSERT INTO SCOREGRADE VALUES ( 'A', 90, 100 );
INSERT INTO SCOREGRADE VALUES ( 'B', 80, 89.99 );
INSERT INTO SCOREGRADE VALUES ( 'C', 70, 79.99 );
INSERT INTO SCOREGRADE VALUES ( 'D', 60, 69.99 );
INSERT INTO SCOREGRADE VALUES ( 'F', 50, 59.99 );
COMMIT;

SELECT T.학번, 
       T.이름, 
       DECODE(T.국어, NULL, '미응시', T.국어)       국어, 
       DECODE(T.영어, NULL, '미응시', T.영어)       영어, 
       DECODE(T.수학, NULL, '미응시', T.수학)       수학, 
       DECODE(T.총점, NULL, '미응시', T.총점)       총점, 
       DECODE(T.평균, NULL, '미응시', T.평균)       평균, 
       DECODE(SG.GRADE, NULL, '미응시', SG.GRADE)   등급,
       RANK() OVER(ORDER BY T.총점 DESC NULLS LAST) 석차
 FROM
 (
SELECT  ST.STID                                        학번,
        ST.STNAME                                      이름,
        SUM( DECODE( SC.SUBJECT, '국어', SC.SCORE ) )  국어,
        SUM( DECODE( SC.SUBJECT, '영어', SC.SCORE ) )  영어,
        SUM( DECODE( SC.SUBJECT, '수학', SC.SCORE ) )  수학,
        SUM(SCORE)                                     총점, 
        ROUND( AVG(SCORE), 2 )                         평균
 FROM   SCORES SC
  FULL JOIN STUDENT ST ON SC.STID = ST.STID
 GROUP BY ST.STID, ST.STNAME
 ORDER BY ST.STID
) T LEFT JOIN SCOREGRADE SG 
     ON T.평균 BETWEEN SG.LOSCORE AND SG.HISCORE
;



2. ORACLE 11G 방식 - PIVOT 명령사용 : 통계를 생성 -- 일반적으로 집계함수랑 같이 사용

학번, 이름, 국어 ,영어, 수학, 총점, 평균, 등급, 석차
1)학번, 국어 ,영어, 수학
SELECT * FROM (
 SELECT STID, SUBJECT, SCORE
  FROM SCORES
)
PIVOT
(
 SUM(SCORE)
  FOR SUBJECT
   IN('국어' AS 국어, '영어' AS 영어, '수학' AS 수학)
)
;
2) 학번, 이름, 국어 ,영어, 수학, 총점, 평균, 등급, 석차

SELECT T.STID                                                    학번,
       T.이름, T.국어 ,T.영어, T.수학, 
       (  NVL(T.국어, 0) + NVL(T.영어, 0) + NVL(T.수학, 0) )     총점,
       (  NVL(T.국어, 0) + NVL(T.영어, 0) + NVL(T.수학, 0) ) / 3 평균,
       -- SG.GRADE                                                등급,
       RANK() OVER(ORDER BY ( NVL(T.국어, 0), NVL(T.영어, 0), NVL(T.수학, 0) DESC NULLS LAST ) 석차
 FROM (
 SELECT * FROM (
 SELECT STID, SUBJECT, SCORE
  FROM SCORES
 )
 PIVOT
 (
  SUM(SCORE)
   FOR SUBJECT
    IN('국어' AS 국어, '영어' AS 영어, '수학' AS 수학)
)
) T RIGHT JOIN STUDENT    ST ON T.STID = ST.STID
    LEFT JOIN       SCOREGRADE SG 
    ON (  NVL(T.국어, 0) + NVL(T.영어, 0) + NVL(T.수학, 0) ) / 3 
    BETWEEN SG.LOSCORE AND SG.HISCORE
   ;











































