//	MEMBER------ -------- ------------- 
//	MID    NOT NULL VARCHAR2(20)  
//	MPWD   NOT NULL VARCHAR2(20)  
//	MNAME  NOT NULL VARCHAR2(50)  
//	MEMAIL NOT NULL VARCHAR2(150)
select * from MEMBER;
desc MEMBER;
DELETE FROM MEMBER;
drop table member;

CREATE TABLE MEMBER(
    MID VARCHAR2(20),
    MPWD VARCHAR2(20),
    MNAME VARCHAR2(50),
    MEMAIL VARCHAR2(150)
);

INSERT INTO MEMBER
VALUES('S5924','1234','박솔빈','SOL55@naver.com');
INSERT INTO MEMBER
VALUES('S8024','2909','조민지','MIN55@naver.com');







