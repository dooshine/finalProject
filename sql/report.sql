-- 신고 테이블 생성
create table report(
    -- 신고 PK(시퀀스)   
	report_no number primary key,
    -- 신고한 사람
	member_id varchar2(20),
    -- 신고 대상 종류(게시물, 댓글, 회원)
	report_target_type varchar2(9) not null check (report_target_type in ('게시물', '댓글', '회원')),
    -- 신고 대상의 PK    
	report_target_primary_key varchar2(20) not null,
    -- 신고 이유
    report_for varchar2(60) not null, 
    -- 신고 시간
	report_time date default sysdate not null
);
-- 신고 테이블 삭제
drop table report;




-- 신고 시퀀스(캐시 X)
CREATE SEQUENCE report_seq
INCREMENT BY 1 START WITH 1 NOMAXVALUE
MINVALUE 1 NOCYCLE NOCACHE  NOORDER;
--신고 시퀀스 삭제
drop sequence report_seq;




-- 제재 테이블
create table sanction(
    -- 제재 PK(시퀀스)
    sanction_seq number primary key,
    -- 제재 대상 종류
    sacntion_target_type varchar2(9) not null check (report_target_type in ('게시물', '댓글', '회원')),
    -- 제재 대상 PK
    sacntion_target_primary_key varchar2(20) not null,
    -- 제재 일자
    sanction_expire date not null,
);




-- 제재 시퀀스 생성
CREATE SEQUENCE sanction_seq
INCREMENT BY 1 START WITH 1 NOMAXVALUE
MINVALUE 1 NOCYCLE NOCACHE  NOORDER;
-- 제재 시퀀스 삭제
drop sequence sanction_seq;