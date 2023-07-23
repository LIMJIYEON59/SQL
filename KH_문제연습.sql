-- <JOIN>: 하나 이상의 테이블에서 데이터를 조회하기 위해 사용하고 결과는 하나의 RESULT SET으로 나옴
-- FROM절에 쉼표(,)로 구분하여 합칠 테이블명을 적기
-- WHERE절에 합칠 컬럼명 적기

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE --나올 컬럼명들
FROM EMPLOYEE, DEPARTMENT --이 테이블들을 합치겠다.
WHERE DEPT_CODE = DEPT_ID; --ID를 CODE안에 넣겠다.

-- JOB_CODE:직급, JOB_NAME:직급이름
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME --JOB테이블꺼랑 헷갈리니깐? 저것만 앞에 붙여줌
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
-- =>E.JOB_CODE랑 J.JOB_CODE가 합쳐져서 나온다.
-- 별칭 사용 가능
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME 
FROM EMPLOYEE E, JOB J --별칭 사용시 FROM절에도 테이블 별칭을 써줘야 한다.
WHERE E.JOB_CODE = J.JOB_CODE;

-- <연결할 컬럼 명이 같은 경우 USING, 다른경우 ON>
-- 같은경우 USING
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE); --EMPLOYEE 테이블에 JOIN을 하여 JOB테이블의 JOB_CODE를 합치겠다.

-- 다른 경우 ON
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE =DEPT_ID); -- 컬럼명이 다름

-- <INNER, OUTER JOIN>
-- 기본값:INNER (중복 행 제외), OUTER (일치하지 않은 값도 포함)
-- OUTER JOIN 종류: LEFT OUTER JOIN: 왼쪽 테이블 컬럼 수 기준으로 조인, RIGHT:오른쪽, FULL:모든 테이블

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT
ON (DEPT_CODE = DEPT_ID); --EMPLOYEE 테이블에는 DEPARTMENT가 가지고 있는 DEPT_ID가 없어서 NULL로 나온다.

-- <SUBQUERY>
-- SELECT문장 안에 또 다른 SELECT문장, 비교할 SELECT문장의 항목 개수와 자료형 일치 시켜야 함
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE);

-- 전 직원의 급여 평균보다 많은 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY --JOB_CODE:직급
FROM EMPLOYEE E  --테이블 별칭 써주기
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE) --평균보다 많은 급여를 받는거니깐 급여 >= 평균
ORDER BY 2; --JOB_CODE를 기준으로 정렬

-- 부서 별 최고 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE E
-- IN : 필요한 값을 불러 오겠다.
WHERE SALARY IN (SELECT MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE)
-- 부서 별이 기준이니 GROUP BY를 사용해서 DEPT_CODE를 묶어준다.
-- 다중 행 서브쿼리 앞에는 일반 비교 연산자 사용 불가!
ORDER BY 3;

-- 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 사원의 이름, 직급, 부서, 입사일 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                                WHERE SUBSTR(EMP_NO, 8,1) =2 AND ENT_YN='Y'); --퇴사자? Y



-- 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 사원의 이름, 직급, 부서, 입사일 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE 
                                FROM EMPLOYEE
                                WHERE SUBSTR(EMP_NO, 8, 1) =2 AND ENT_YN ='Y');

-- 직급별 최소 급여를 받는 직원의 사번, 이름, 직급, 급여 조회
SELECT EMP_NO, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE,SALARY) IN (SELECT JOB_CODE, MIN(SALARY) 
                            FROM EMPLOYEE 
                            GROUP BY JOB_CODE)
ORDER BY 3;

-- 인라인 뷰(INLINE-VIEW):FROM절에 서브쿼리 사용한 것
-- 잘못된 예시 (1.FROM절 수행X)
-- ROWNUM: 오라클에서 조회된 행이 몇번째 행인지 부여해주는 것
-- ROWNUM을 사용한 곳에 ORDER BY를 사용하면 안된다. ORDER BY를 사용해야 한다면 서브쿼리 안에 사용한다.
SELECT ROWNUM, EMP_NAME, SALARY 
-- ROWNUM은 FROM절을 수행하면서 붙여지기 때문에 SELECT절에 사용한 ROWNUM이 의미 없게 됨
FROM EMPLOYEE   
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-- 2.ORDER BY만 사용하게 되면 전체가 순서대로 출력이 된다.
SELECT  EMP_NAME, SALARY 
FROM EMPLOYEE   
ORDER BY SALARY DESC;

-- 올바른 예시
-- ROWNUM을 뒤에 쓸 경우 뒤에 나타나게 되니 순서 잘 보기(맨 앞)
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
        FROM EMPLOYEE
        ORDER BY SALARY DESC)
WHERE ROWNUM <= 5; 
--FROM절에 이미 정렬된 서브쿼리(인라인 뷰) 적용 시 ROWNUM이 TOP-N분석에 사용 가능

-- RIGHT 오른쪽 테이블인 DEPARTMENT를 기준으로 값이 없으면(EMPLOYEE에) NULL로 표시된다.
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT 
ON (DEPT_CODE = DEPT_ID);
-- 테이블 DEPARTMENT에 DEPT_TITLE의 DEPT_ID가 있는데 
    -- EMP_NAME에 DEPT_CODE가 없는겨 그래서 NULL이 생김 

-- <KH 시험 문제>
-- 1. SELECT DEPT, SUM(SALARY) 합계, FLOOR(AVG(SALARY)) 평균, COUNT(*) 인원수
    --FROM EMP 
    --WHERE SALARY > 2800000 
    --GROUP BY DEPT 
    --ORDER BY DEPT ASC;
    
-- 2. SELECT ROWNUM, EMPNAME, SAL
    --FROM EMP
    --WHERE ROWNUM <=3
    --ORDER BY SAL DESC;














