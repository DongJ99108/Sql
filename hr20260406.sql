SELECT * FROM TAB;

DESC EMPLOYEES;

select * from employees;

-- 직원번호가 100인 사람을 출력 해봐
select *
 from  employees
 where employee_id = 100;
 
 -- 이름이 king 이라는 직원을 출력
select * 
  from  employees
  where last_name = 'King';
 
 -- 월급을 내림차순으로 직원정보를 출력
SELECT   EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
 FROM     EMPLOYEES
 ORDER BY SALARY DESC; -- <-> ASC(오름차순)

-- 월급을 5000 이상인 사람들을 내림차순으로 직원정보를 출력
SELECT   EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
 FROM     EMPLOYEES
 WHERE    SALARY >= 5000
 ORDER BY SALARY DESC; -- <-> ASC (오름차순)
 
-- 전화번호에 010이 포함된 직원
SELECT   EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, PHONE_NUMBER
 FROM EMPLOYEES
 WHERE PHONE_NUMBER LIKE '%010%'
 ORDER BY EMPLOYEE_ID ASC;

-- 50번 부서의 직원을 출력해라
SELECT   EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
 FROM EMPLOYEES
 WHERE DEPARTMENT_ID = 50
 ORDER BY employee_id ASC;

-- 부서가 없는 직원을 출력
SELECT   EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
 FROM EMPLOYEES
 WHERE DEPARTMENT_ID IS NULL
 ORDER BY employee_id ASC;



