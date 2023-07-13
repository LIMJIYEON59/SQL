-- * 모든 것
select * from user_tables;

-- create 명령어 - DDL 데이터 정의어이다.
-- 학습용 계정을 만든다. scott(계정명) tiger(비번)
create user c##scott identified by tiger;
-- 계정 삭제
drop user c##scott;

--21버전 이후 "_ORACLE_SCRIPT"=true; 셋 해줘야 한다.
alter session set "_ORACLE_SCRIPT"=true;
create user kh identified by kh;
--위에서 계정을 삭제 했으니 다시 하나 더 만든다
create user scott identified by tiger;
drop user soctt;

--상태: 실패 -테스트 실패: ORA-01017: 사용자명/비밀번호가 부적합, 로그온할 수 없습니다.
--상태: 실패 -테스트 실패: ORA-01045: 사용자 SCOTT는 CREATE SESSION 권한을 가지고있지 않음; 로그온이 거절되었습니다
--계정이 만들어졌지만 SESSION(접속,접근) 권한이 없음 그래서 접속을할 수 있는 권한을 줘야함

-- DCL명령어이다.
-- 주고싶은 권한명이나 롤명을 적어준다 
-- grant 권한명, 롤명 to scott; (to하고 scott한테 주고싶다)
-- grant CREATE SESSION to scott; <=위에 CREATE SESSION이런 오류가 떴으니 이걸 적어줌
-- 다른방법
-- create session, create table 처럼 각각의 권한명을 모두 나열하여 적기 어려움 그래서
-- 권한들을 묶어서 만들어둔 롤role을 사용하여 권한을 부여함.
-- connect = 접속관련 권한들이 있는 role
-- resource = 자원(table.view 등 객체)관련 권한들이 있는 role

grant connect, resource to c##scott, kh;
grant connect, resource to kh;
-- 줬던 권한을 뺐는 revoke
revoke connect, resource from kh;
grant connect, resource to scott, kh;

-- 21버젼되면서 dba를 붙여줘야 한다.
grant connect, resource, dba to scott, kh;

