--학습용 SCOTT 명령어들
--실행 순서: 테이블을 선택하는 from절이 1번 > 행(where) > 열(select) 
SELECT * 
FROM EMP
;

-- select 다음 것들 =>열
-- where 다음 것들 =>행
SELECT EMPNO, ENAME, SAL 
FROM EMP
;

-- WHERE이라는 조건식에는 컬럼 명밖에 못 옴 
-- WHRER DEPTNO=20 => 부서번호의 속성값이 20인걸 찾아줘
select ENAME, MGR, SAL, DEPTNO
from emp
WHERE DEPTNO=20 OR SAL>1500  --AND와 OR 사용 가능
;

SELECT ENAME, MGR, SAL, DEPTNO
FROM emp
--WHERE ENAME = 'smith' => 컬럽값(속성값)은 대소문자를 구분해야함 무조건 대문자!
WHERE ENAME = 'SMITH'
;

select empno, ename, sal
from emp
;

-- * 을 사용하는 것 보다 속도 빠름 권장.
select empno, ename, job, mgr, hiredate, sal, comm, deptno
from emp;

-- 그래도 이거 쓰래(나열 하기 힘드니 학습차원에서)
select * from emp;
select * from dept;
select * from salgrade;
select * from bonus;

-- Q: 사원명(ENAME)과 연봉과 보너스 포함한 연봉을 조회
-- 사원명을 보면 emp table에 있으니 from emp을 통해야한다.
-- sal은 월급 개념으로 통한다.
--  nvl(comm, 0) => 만약에 comm이 nvl(널벨류)라면 0으로 인지하고 계산해달라
select ename, sal*12, sal*12 + nvl(comm, 0)
from emp
;
select comm, nvl(comm, 0), nvl(comm, 100)
from emp
;

--쉼표 기준으로 덩어리 / 컬럼명(sal) 다음 연산자(*) 
--큰따옴표를 쓰면 결과값 띄어쓰기 가능/(단, 식별자는 작은따옴표 써야함!)
select ename 사원명, sal*12 연봉, sal*12 + nvl(comm, 0) "보너스 포함 연봉"
from emp
;

--as하고 별칭을 적어줌
select '안녕' as hello
from dept
;
select '달러' as 단위, sal
from emp
;
select '$' as 단위, sal
from emp
;
--중복값 제거 =distinct
select distinct '$' as 단위, sal
from emp
;

-- 급여(sal)를 1500보다 많이 받고 2800보다 적게 받는 직원 이름(ename)과 급여 조회
-- between and 사용
select ename, sal
from emp
where sal between 1500 and 2800 
;

-- >= <= 사용
select ename, sal
from emp
where sal >= 1500 and sal < 2800
;

--<제외>
-- 20번 부서를 제외한 사원 정보를 조회
select *
    from emp
--같지 않다. !=, <>, ^=
--where deptno != 20 
--where deptno <> 20 
--where deptno ^= 20
where not deptno = 20 --(deptno = 20) 괄호를 쳐서 구분을 쉽게 해줘도된다. 
;

-- 20번 부서를 제외한 사원 중(and) comm이 null인 사원 정보를 조회
select *
    from emp
    where not deptno =20 
        and comm is null 
        --comm = null =>오류뜸 is를 붙여줘야 함
;

-- 10,20을 제외한 부서 사원 정보를 조회
select *
    from emp
--  where not (deptno = 10 OR deptno = 20)
    where deptno != 10 AND deptno != 20
;

-- 10,20,30가 아닌 부서 사원 정보를 조회
select *
    from emp
    where deptno not in (10,20,30) --아무도 없으니 아무것도 안나타남,
;
-- 'S'씨 성을 가진 직원 이름과 급여 조회
select ename, sal
    from emp
        where ename like 'S%'
;

-- 'S'로 시작하는 2글자이상의 이름을 가진 직원 이름과 급여 조회
select ename, sal
    from emp
        where ename like 'S_%'
;

--이름 중 3번째 글자가 'S' 인 직원 이름과 급여 조회
--3번째 위치에 S 존재
select ename, sal
    from emp
        where ename like '__S%' 
;
-- 이름 중 3번째 글자가 '_' 인 직원 이름과 급여 조회
select ename, sal
    from emp
    where ename like '__\_%' escape '\'
        or job like '__@_%' escape '@'
;

-- 핸드폰의 앞 네 자리 중 첫 번호가 7인 직원 이름과 전화번호 조회
-- EMALL ID 중 '_'의 앞의 3자리인 직원 이름, 이메일 조회

-- 관리자도 없고 부서 배치도 받지 않은 직원 조회(직원 전체를 의미)
select *
    from emp
    where mgr is null --없다고 함
         and deptno is null
;
-- 관리자가 없지만 보너스를 지급받는 직원 조회
select *
    from emp
    where mgr is null
        and comm is not null
;
-- 20 부서와 30 부서원들의 이름, 부서코드, 급여 조회 --IN 사용한다!
select ename, deptno, sal
    from emp
        where deptno in (20,30)
        --deptno = 20 or deptno =30
;
-- ANALYST 똔는 SALESMAN인 사원 중 급여을 2500보다 많이 받는 직원의 이름, 급여, job 조회
select ename, sal, job
    from emp
    where job in ('ANALYST', 'SALESMAN')
        and sal >= 2500
;
--<함수!!!!!!>
-- 사원명의 길이와 byte크기를 조회
select length(ename), lengthb(ename) --매개인자로 ename을 준다. 
    from emp
    ;
    
select 'a안녕b', length('a안녕b'), lengthb('a안녕b')
  --from emp  --14개가 나옴
    from dual --1개만 나옴, 테이블 dual은 임시테이블로 연산이나 간단한 함수 결과값을 조회할때 사용.
    ;
    
-- trim은 지정한 문자를 없애준다
select trim(' a안 녕b '), length(trim(' a 안 녕b ')), lengthb(trim(' a안 녕b '))
    from dual
    ;
    
-- 사원명의 시작부분 S와 끝나는 부분 S 모두 제거해주세요.
select Rtrim(Ltrim(ename, 'S'), 'S')  
    from emp;
    
-- Lpad / Rpad 채워넣기
-- 뜻: ename이 총 10자가 되도록 left 쪽에 'S'를 채워주세요.
select Lpad(ename, 10, 'S') from emp; 
-- ename이 총 10자가 되도록 left 쪽에 ' ' 공백을(default)를 채워주세요.
select Lpad(ename, 10) from emp;

-- 문자열(컬럼) 이어붙이기
select concat(ename, comm) from emp;
select ename||comm from emp;
select sal||'달러' from emp;
select concat(sal, '달러') from emp;

-- substr 엄청중요!!
-- replace 
-- SM을 A라고 바꾸고 싶어요!
select replace(ename, 'SM', 'A') from emp;

-- 현재 날짜를 알려줌
-- sysdate는 함수가 아니나 명령어가 실행되는 시점에 결과값을 출력해주므로 함수 호출과 비슷하게 동작
select sysdate from dual;
select hiredate from emp;
-- 1개월을 더함
select hiredate, add_months(hiredate, 1) from emp;
-- 2023.07.10 (월) 처럼 나타내고싶을때
select sysdate, to_char(sysdate, 'yyy.mm.dd (dy) hh24:mi:ss') from dual;
select sysdate, to_char(sysdate, 'yyy.mm.dd (day) hh24:mi:ss') from dual;

-- alter:구조를 바꾸겠다(변경x) 
alter session set NLS_DATE_FORMAT = 'yyyy-mm-dd hh24:mi:ss';
select sysdate from dual;
select * from emp;

-- year 2023 month 09 day 11 hour 13
select to_date('2023091113', 'yyyymmddhh24') from dual; 
select add_months(to_date('2023091113', 'yyyymmddhh24'), 5) from dual;  
select next_day(to_date('2023091113', 'yyyymmddhh24'), '수') from dual;

-- 1:일요일, 2:월요일, 3:화요일...
select next_day(to_date('2023091113', 'yyyymmddhh24'), '4') from dual;
--이거 절대 안됨(원래는 to_date를 써서 바꿔줘야 한다)
select add_months('2023091113', 2) from dual;


select to_char(empno, '000000') , to_char(sal, '999,999,999,999')
    from emp;
select to_char(empno, '000000') , '$'||trim(to_char(sal, '999,999,999,999'))
    from emp; 
--공백 없애기:trim
select to_char(empno, '000000') , trim(to_char(sal, '999,999,999,999'))
    from emp;

select to_number('123,4567,8907', '999,9999,9999')*5 from dual;

--직원들의 평균 급여는 얼마인지 조회
select avg(sal) 평균급여 from emp; --select avg(sal) 평균급여, deptno from emp; =>불가능
select sum(sal) sum from emp;
select max(sal) max from emp;
select min(sal) min from emp;
--부서별 평균 급여 조회
select avg(sal) 평균급여, deptno  from emp group by deptno; --그룹 단위
select sum(sal) sum, deptno  from emp group by deptno;
select max(sal) max, deptno  from emp group by deptno;
select min(sal) min, deptno  from emp group by deptno;
select count(sal) count, deptno from emp group by deptno;
select count(*) count, deptno from emp group by deptno;
-- job별 평균 급여 조회
select avg(sal) 평균급여, job from emp group by job;
select sum(sal) sum, job  from emp group by job;
select max(sal) max, job from emp group by job;
select min(sal) min, job  from emp group by job;
select count(sal) count, job from emp group by job; --count는 갯수를 묻다.
select count(*) count, job from emp group by job;

-- job이 ANALYST인 직원의 평균 급여 조회
select avg(sal) 평균급여, job 
    from emp 
    group by job
    having job = 'ANALYST' --조건식을 적어준다. having이나 where아무거나 써라
;
--이건 오류남
select avg(sal) 평균급여
    from emp 
    where job = 'ANALYST' 
;
-- job이 CLERK인 부서별 직원의 평균 급여 조회
-- job이 CLERK인 부서별 직원
select job, deptno, ename
    from emp
    where job='CLERK';
    
-- job이 CLERK인 부서별 직원의 평균 급여 조회
select job, deptno, avg(sal)
    from emp
    where job='CLERK'
    group by deptno, job
    ;

select * from emp
    order by sal desc, ename asc
    ;
select sal, sal*12+nvl(comm,0) salcomm 
    from emp
    order by salcomm desc, sal asc
    ;
select ename, sal*12+nvl(comm,0)  
    from emp
    order by 2 desc, 1 desc
    ;
-- job 오름차순
select * from emp
--    order by job;
    order by 3
;    

--on을 쓴다면 두 식을 조건?
--join을 쓰면 잘 알아보기가 숩지아나
select emp.ename, emp.deptno, dept.dname, dept.loc --(.)점이란 앞에 있는 놈한테 접근하겠다. emp,dept 생략가능
    from emp
        join dept on emp.deptno = dept.deptno
;
-- 위를 생략한 것(using)
select *
    from emp
        join dept using (deptno)
;

select empno, loc
    from emp cross join dept
;

select * from emp;
select * from salgrade;
-- 사원의 이름, 사번, sal, grade를 조회

select emp_name, emp_no, sal, grade
from emp e
    join salgrade  s on e.sal between s.losal and s.hisal
;

select empno, ename, mgr 
  from emp
;

create table t1( c1 char(5), c2 varchar2(5));

desc t1;
desc emp;

--2023-713
create table emp_copy1 as select * from emp;
select * from emp_copy1;
create view view_emp1 as select * from emp;
select * from view_emp1;
desc emp;
insert into emp values(8000, 'EJKIM', 'KH', 7788, sysdate, 3000, 700, 40); --순서대로 넣어줘야한다.
commit; --insert한 다음에는 꼭 커밋 해줘야한다.
insert into emp_copy1 values(8001, 'EJ1', 'KH', 7788, sysdate, 3000, 700, 40);
commit;
insert into view_emp1 values(8002, 'EJ2', 'KH', 7788, sysdate, 3000, 700, 40);
commit;
create table emp_copy20 as
select empno, ename 사원명, job, hiredate, sal
from emp
where deptno=20
;
desc emp;
desc emp_copy20;
select * from user_constraints;

desc emp;
--insert into emp (컬럼명1, 컬럼명2,...) values(값1, 값2ㅣ...)
insert into emp (ename, empno, job, mgr, hiredate. deptno)
    values ('EJK', 8003, 'T', 7788, sysdate, 40);
select * from emp;
insert into emp (ename, empno, job, mgr, hiredate. deptno)
    values ('EJK2', 8004, 'F', null, to_date('2023-07-12','yyyy-mm-dd'), 40);
commit;
update emp --테이블 먼저 (emp)
    set mar=7788
    where ename='EJL2'
;
    -- uodate 명령문의 where절에는 컬럼명 PK=값
    -- where절에는 컬럼명 PK- 값 ==> resultser 은 단일행
    
--20번 부서가
rollback;
select * from emp;
--30번 부서의 mgr가 smith 7908로 조직개편
update emp 
    set mgr=7908
    where deptno=30
;





















