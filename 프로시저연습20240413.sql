CREATE OR REPLACE PROCEDURE GET_NAME_MAXSAL( -- 새로만들거나 있으면 대체해라 GET_NAME_MAXSAL라는 프로시저를 만들거다
 IN_DEPTID IN  NUMBER, -- IN_DEPTID라는 변수를 만든다 타입은 넘버로, 변수지정이니까 길이는 지정안한다.
 O_NAME    OUT VARCHAR2,
 O_SAL     OUT NUMBER
 )
 IS -- 이거랑 BEGIN 사이는 여기서 잠깐 쓰고 버릴 변수를 지정할거야
  V_MAXSAL NUMBER(8,2); -- 이게 잠깐 쓰고 버릴 변수인데 타입은 넘버고 총 8자리인데 그중 2자리는 소수야
 BEGIN -- 자 이제 위의 변수들을 바탕으로 프로시저를 만들거다
  SELECT MAX(SALARY)
   INTO V_MAXSAL -- MAX(SALARY)에 해당하는 값을 찾아서 V_MAXSAL에 담아라
   FROM EMPLOYEES -- EMPLOYEES의 테이블을 참고할거고
   WHERE DEPARTMENT_ID = IN_DEPTID; -- 우리가 입력할 IN_DEPTID랑 DEPARTMENT_ID를 비교해서 같은걸 찾아
   
  SELECT  FIRST_NAME || ' ' || LAST_NAME, SALARY
   INTO  O_NAME, O_SAL -- 위에서 찾은 최고연봉자의 이름과 연봉을 각각 O_NAME, O_SAL 에 담아라
   FROM  EMPLOYEES
   WHERE SALARY = V_MAXSAL
   AND   DEPARTMENT_ID = IN_DEPTID; -- 우리가 입력한 ID와 같으면서 최고연봉액과 봉급이 같은 사람을 찾아라
   
 DBMS_OUTPUT.PUT_LINE( O_NAME ); -- 결과값을 화면에 출력해서 맞는지 아닌지 확인
 DBMS_OUTPUT.PUT_LINE( O_SAL );
 
 END; -- 끝 
 /