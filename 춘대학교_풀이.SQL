-- 3-18
SELECT TB2. * FROM
(
SELECT ROWNUM RN, TB1. * FROM
(
SELECT STUDENT_NAME, AVG(POINT) AVGPOINT
--국어 국문과 학생들만 뽑고싶다.
    FROM ( 
     --국어국문과 학생들만 뽑아줌
     SELECT * FROM TB_STUDENT WHERE DEPARTMENT_NO = 
                            (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT 
                            WHERE DEPARTMENT_NAME='국어국문학과')
                            -- 국문의 넘버만 추출하면 된다.
    ) S
    --평점을 나타내야 하니 JOIN을 한다.
      JOIN TB_GRADE G USING (STUDENT_NO)
      GROUP BY STUDENT_NO, STUDENT_NAME
      ORDER BY AVGPOINT DESC
) TB1  -- 묶어줌 
) TB2
WHERE RN = 1
-- WHERE ROWNUM <= 3 --극히 제한적임(잘 안나오는게 많음)
-- 그래서 TB2로 한번 더 묶어주고 밑에 WHERE RN = //이래 쓰면 안정적
;

-- <04-KH-JOIN-10>
-- 10.보너스 포함한 연봉이 높은 5명의 사번, 이름, 부서 명, 직급, 입사일, 순위 조회
SELECT TB2.* FROM
(
SELECT TB1.*, ROWNUM RN FROM 
(
SELECT EMP_ID,EMP_NAME,(SELECT DEPT_TITLE FROM DEPARTMENT D WHERE DEPT_ID = E.DEPT_CODE) "부서 명", JOB_CODE, HIRE_DATE, SALARY*12+ (SALARY*12*NVL(BONUS,0)) SAL_RANK
FROM EMPLOYEE E
    ORDER BY SAL_RANK DESC
)TB1
)TB2
WHERE RN <=5
;

-- 보너스를 포함한 연봉
SELECT EMP_ID, SALARY*12+ (SALARY*12*NVL(BONUS,0)) SAL_RANK FROM EMPLOYEE ORDER BY SAL_RANK DESC;
SELECT DECODE(BONUS,NULL, 0, BONUS) BONUS FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
-- 입사일 순서가 빠른 사람 3명을 조회해 주세요.
 SELECT * FROM
(  
SELECT ROWNUM RN, TB1.*FROM
(
SELECT * FROM EMPLOYEE ORDER BY HIRE_DATE ASC
) TB1
)
WHERE RN <=3
;
-- 방법2 간단하게
SELECT TB1.* FROM
(
SELECT * FROM EMPLOYEE ORDER BY HIRE_DATE ASC
)TB1
WHERE ROWNUM <=3
;
--춘대학교 2번 14번문항 HAVING COUNT(*) > 2 / 5번 16번
--

--<춘대학교>
-- 3-2 휴학중인 학생들의 이름과 주민번호 나이가 적은 순
 --ABSENCE_YN:재학여부 N,Y 
 --STUDENT_SSN:주민 번호
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC; --나이가 적은 순이니 주민번호가 큰 순서대로이다.

SELECT *
FROM TB_STUDENT;

-- 2-14 동명이인 학생의 이름 찾기
SELECT STUDENT_NAME, COUNT(*)
FROM TB_STUDENT
GROUP BY STUDENT_NAME -- 그룹화 해줘야 한다
HAVING COUNT(STUDENT_NAME) > 1 -- GROUP BY에 대한 조건식을 작성 HAVING에다가! () 컬럼명 넣는다.
ORDER BY 1; -- 정렬

-- 5- 15 DDL 춘 기술학교는 인기 과목들에 수강 신청이 몰린다 최근 3년 기준으로 수강인원이 가장
           --많았던 3과목을 찾아라
-- CREATE VIEW 또는 CREATE OR REPLACE VIEW는 '뷰(VIEW)를 생성해 주는 명령어이다.
-- CREATE OR REPLACE VIEW: 이미 같은 이름의 뷰를 생성할 경우 걍 덮어쓰기 함
CREATE OR REPLACE VIEW "VW_인기과목_TOP3"
    AS SELECT CLASS_NO AS "과목번호", CLASS_NAME AS "과목이름", 
    COUNT(*) AS "누적수강생수(명)" 
    FROM TB_GRADE
    -- USING: 연결하고자 하는 테이블의 컬럼 명이() 같을 경우 쓴다.
    -- TB_GRADE와 TB_CLASS의 테이블의 CLASS_NO 컬럼명이 같다.
    JOIN TB_CLASS USING (CLASS_NO)
    WHERE TERM_NO BETWEEN '2007%' AND '2010%'
    GROUP BY CLASS_NO, CLASS_NAME
    ORDER BY 3 DESC
    FETCH FIRST 3 ROW ONLY;

SELECT * 
FROM VW_인기과목_TOP3;
                        
-- 5-15 SELECT 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 학번, 이름, 학과
    --, 평점을 출력해라
    -- ROUND(AVG(POINT),3) : 평균 점수가 소수점 3자리까지 나오도록한다 (4번째 자리에서 반올림을해서 .하고 3자리가 나와줘야 한다)
    SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME, ROUND(AVG(POINT),3) AS "평점"
    FROM TB_STUDENT TS
    -- LEFT:왼쪽을 기준으로
    LEFT JOIN TB_DEPARTMENT TD USING (DEPARTMENT_NO)
    LEFT JOIN TB_GRADE TG USING (STUDENT_NO)
        -- ABSENCE_YN: 재학여부 'N'과 'Y'로 나뉜다.
        WHERE ABSENCE_YN = 'N'
        -- ROUND 빼고 SELECT절꺼 넣어준다.
        GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
            HAVING AVG(POINT) >= 4.0
                ORDER BY 1;

SELECT * FROM TB_STUDENT;
DESC TB_STUDENT;

select * from tb_student;







