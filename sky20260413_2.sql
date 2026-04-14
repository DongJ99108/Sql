
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
조회

1. 학번, 이름, 점수(국어)

2. 학번, 이름, 총점, 평균

3. 모든 학생의 학번, 이름, 총점, 평균
   점수가 NULL인 학생은 '미응시' 처리
   
4. 모든 학생의 학번, 이름, 총점, 평균, 등급, 석차












































