select * from EMPLOYEE;
select * from DEPARTMENT;
select * from JOB;
select * from LOCATION;
select * from SAL_GRADE;

--select emp_name, length(emp



--'J1'값 위치에 있기 때문에 ''작은 따옴표와 대문자!!
select * from employee where job_code = 'J1'; 

-- 급여를 1800보다 많이 받고 2500보다 적게 받는 사람
select EMP_NAME, SALARY
from EMPLOYEE
where salary >= 3500000 and salary <=6000000;

-- instr 1부터 시작(0부터 시작하는게 아님)
-- @이의 위치 지정하는 것???????????
select email, instr(email, '@') 위치
    from employee
;
select email, instr(email, '@', 9) 위치
    from employee
;
--email 은 @ 이후에 .1개 이상있어야 함.
-- 이메일에서 점을 찾는데 어디? 골뱅이 이휴에 잇는 점(만약 점이 없으면 0이 나옴)
select email, instr(email, '@'), instr(email, '.', instr(email, '@')) 위치
    from employee
    where instr(email, '.', instr(email, '@')) <> 0
;

-- 문자 자리 찾기(몇 번째에 있는지)
select instr('oraclewelcome', 'o', 2) from dual;
select instr('oraclewelcome', 'o', 1, 2) from dual;  -- 2번째에 있는 o를 찾아줘
select instr('oraclewelcome', 'o', 1, 2, 3) from dual; -- 3번째는 없으니깐 못찾음

-- 모든 사원들의 남, 여 성별과 함께 이름과 주민번호를 조회
select emp_name, emp_no, 
        decode(substr(emp_no, 8,1), 2, '여', 4, '여', 1, '남', 3, '남', '그외')
        as "성 별"
    from employee
;
--조건식을 각각 적어줌
select emp_name, emp_no,
     case
          when substr(emp_no, 8,1) = 2 then '여'
            when substr(emp_no, 8,1) = 1 then '남'
            when substr(emp_no, 8,1) = 4 then '여'
            when substr(emp_no, 8,1) = 3 then '남'
            else '그외'
        end
        as "성 별"
    from employee
;

--각각 필요없다면 간결하게 (비슷한건 묶고)
select emp_name, emp_no,
         case substr(emp_no, 8,1)
            when  '2'  then '여'
            when  '1'  then '남'
            when  '4'  then '여'
            when  '3'  then '남'
            else '그외'
        end
        as "성 별"
    from employee
;
        
        
-- java, js 삼항연산자
-- string a = ( substr(emp_no, 8,1) == 2 ? "여" : "남";
--if(substr(emp_no, 8,1) == 2){
--    return "여";
--} else {
--    return "남";
--}
--if(substr(emp_no, 8,1) == 2){
--    return "여";
--} else if(substr(emp_no, 8,1) == 4) {
--    return "여";
--} else if(substr(emp_no, 8,1) == 1) {
--    return "남";
--} else if(substr(emp_no, 8,1) == 3) {
--    return "남";
--} else {
--    return "그외";
--}
--switch(substr(emp_no, 8,1)){
--    case 1:
--        return "남";
--    case 2:
--        return "여";
--    case 3:
--        return "남";
--    case 4:
--        return "여";
--    default:
--        return "그외";
--}
    

-- 직원들의 평균 급여는 얼마인지 조회 (합을 구해라, 가장 많은 급여 max , 가장 적은 급여 min)
select avg(salary) 평균급여 from employee;
select floor(avg(salary)) 평균급여 from employee; --소수점을 다 자르겠다.
select trunc(avg(salary)) 평균급여 from employee;
select (avg(salary)) 평균급여 from employee;
select (avg(salary)) 평균급여 from employee;
select (avg(salary)) 평균급여 from employee;

--count는 null의 값을 세지않는다.
SELECT COUNT(DISTINCT DEPT_CODE) 
    FROM EMPLOYEE;
SELECT COUNT(DEPT_CODE)
    FROM EMPLOYEE;  --21
SELECT COUNT(*) 
    FROM EMPLOYEE; --23
SELECT * --COUNT(*) 
    FROM EMPLOYEE 
    where dept_code is null;
    
-- count는 resultset의 row값이 null 이면 count 되지 않음. --count(*) row 개수
-- 1.from 2.where 3.count(여기서 값이 null이면 값을 세지 않는다.)
SELECT COUNT(dept_code), count(bonus), count(emp_id), count(manager_id)
    FROM EMPLOYEE 
    where dept_code is null;

-- distinct:중복값을 제거
SELECT COUNT(DEPT_CODE), COUNT(distinct DEPT_CODE)
    FROM EMPLOYEE;
    
SELECT DEPT_CODE     FROM EMPLOYEE;
SELECT distinct DEPT_CODE  FROM EMPLOYEE;

SELECT distinct DEPT_CODE    FROM EMPLOYEE
    order by dept_code asc
; 


GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;


-- EMPLOYEE에서 부서코드(DEPT_CODE), 그룹 별 급여의 합계, 그룹 별 급여의 평균(정수처리), 인원 수를 조회하고 부서 코드 순으로 정렬
select dept_code 부서코드,
    sum(salary) 합계,
    floor(avg(salary)) 평균,
    count(*) 인원수
    FROM EMPLOYEE
    group by dept_code
    order by dept_code asc;
    
-- EMPLOYEE테이블에서 부서코드와 보너스 받는 사원 수 조회하고 부서코드 순으로 정렬
-- SELECT 맨 마지막에는 ,(쉼표)를 안 쓴다.
SELECT DEPT_CODE 부서코드, COUNT(BONUS) 인원수 --보너스 받는 사원 수
FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC;

--dsd
select * from EMPLOYEE;
-- EMPLOYEE테이블에서 성별과 성별 별 급여 평균(정수처리), 급여 합계, 인원 수 조회하고 인원수로 내림차순 정렬
-- DECODE 함수는 산술 계산 외에 문자열 표현 가능
-- DECODE(열 이름, 조건 값 1, 치환 값 1, 조건 값 2, 치환 값 2...., 기본값)

--SELECT DECODE(
--    SUM(SALARY) 합계,
--    COUNT(*) 인원 수
--    FROM EMPLOYEE;
    
select sysdate
from dual;

select emp_id, emp_name, emp_no,
    case when substr(emp_no, 8,1) =1 then '남'
    else '여'
    end as 성별
    from employee;
    
-- 부서 코드와 급여 3000000 이상인 직원의 그룹별 평균 조회
select dept_code, avg(salary)
    from employee
    where salary >= 3000000
    group by dept_code
;
-- 부서 코드와 급여 평균이 3000000 이상인 그룹 조회 (위처럼 개인이 아니라 그룹이라서 having을 써야한다.)
select dept_code, avg(salary)
    from employee
    group by dept_code
    having avg(salary) > 3000000
;

-- 평균 급여 이상 받는 직원 조회
select emp_id, emp_name, job_code, salary --행
from employee
where salary >= (select avg(salary) from employee); --서브 쿼리 셀렉 다음() 괄호

-- 전 직원의 급여 평균보다 많은 급여를 받는 직원의 이름, 직급(job_code), 부서,급여 조회
select emp_name, job_code, dept_code, salary 
from employee e --employee 테이블을 e라고 칭한다?
where salary >= (select avg(salary) from employee)
order by 2; -- 2번째 컬럼(열) 기준으로 오름차순 정렬!(만약 숫자 뒤에 DESC가 적혀져있다면 내림차순)

-- 부서 별 최고 급여를 받는 직원의 이름,직급,부서,급여 조회
select emp_name, job_code, dept_code, salary
from employee 
where salary in (selact max(salary) from employee group by dept_code); --부서 별 최고라고 했으니 부서를 묶었나?
order by 3; --부서 별 최고 급여를 받는 사람을 조회하는거니 그걸 기준으로 묶었나?


select * from EMPLOYEE;
select * from DEPARTMENT;
select * from JOB;
select * from LOCATION;
select * from SAL_GRADE;

--<join>
select emp_id, emp_name, dept_code
from employee;
select dept_id, dept_title
from department;

--from절에 합치게 될 테이블을 ,(쉼표)로 구분해서 적는다.
--그리고 where절에 합쳐질 컬럼명을 적는다. (=)
select emp_id, emp_name, dept_code, dept_title
from employee, department
where dept_code = dept_id;

--employee 테이블과 job 테이블의 job_code를 합친다.
select emp_id, emp_name, employee.job_code, job_name
from employee, job --를 합칠거다.
where employee.job_code = job.job_code;

--테이블 별칭 이용 가능 (select은 앞에 from은 뒤에)
select emp_id, emp_name, e.job_code, job_name
from employee e, job j
where e.job_code = j.job_code;

--<ANSI> 연결할 컬럼 명이 같은 경우 USING() 사용 다른 경우 ON()사용
select emp_id, emp_name, job_code,job_name
from employee
join job using(job_code); --연결할 테이블 쓰고 같으니 using(같은 컬럼 명)

--연결할 컬럼 명이 다를 경우 on()사용
select emp_id, emp_name, dept_code, dept_title
from employee
join department on(dept_code = dept_id);

--inner join과 outer join
-- 기본값-= inner join: 두 개 이상 테이블 조인 시 일치 하는 값이 없는 행은 조인에서 제외
-- outer join: 일치하지 않은 값도 포함. 반드시 outer join명시
select emp_name, dept_title
from employee
join department on (dept_code =dept_id);

select emp_name, dept_title --이게 결과값이 표시되고
from employee 
left join department on (dept_code = dept_id);

--cross join(카테시안 곱, cartesian product)
--행의 컬럼 수 전체가 다 나온다?
select emp_name, dept_title
from employee
cross join department;

--<non_equ join>
select emp_name, salary, e.sal_level
from employee e
join sal_grade s on (salary between min_sal and max_sal);
--s에 있는 sal_grede (salary에 있는 between 작은넘 and 큰넘 다 보여줘)

--<self join> : 두 개이상 서로 다른 테이블이 아닌 같은 테이블 조인하는 것
select e.emp_id, e.emp_name 사원이름, e.dept_code, e.manager_id, m.emp_name 관리자이름
from employee e, employee m
where e.manager_id = m.emp_id;

--<다중 join>??
select * from LOCATION;
select emp_id, emp_name, dept_code, dept_title, local_name
from employee
join department on (dept_code = dept_id)
join location on (location_id = local_code);

-- --------------------------------------------------
--ppt 6 DDL

--<create>:테이블이나 인덱스, 뷰 등 데이터베이스 객체를 생성하는 구문
create table member(    
    member_id varchar2(20), --varchar2(크기,길이):문자 데이터 최대 4,000 byte!
    member_pwd varchar2(20),    --컬럼명 자료형(크기)
    member_name varchar2(20)
);





































    


