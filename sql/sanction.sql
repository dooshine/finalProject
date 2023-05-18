-- 제재 테이블 생성
create table sanction(
    -- 제재번호
    sanction_no number primary key,
    -- 제재대상 종류
    sanction_target_type varchar2(9) not null,
    -- 제재대상 PK
    sanction_target_primary_key varchar2(20) not null,
    -- 제재내용
    sanction_for varchar2(60) not null,
    -- 제재기간
    sanction_term number not null,
    -- 제재시작시간
    sanction_start date not null,
    -- 제재종료시간
    sanction_end date not null
);
-- 제재 테이블 삭제
drop table sanction;




-- 제재 시퀀스 생성
CREATE SEQUENCE sanction_seq
INCREMENT BY 1 START WITH 1 NOMAXVALUE
MINVALUE 1 NOCYCLE NOCACHE  NOORDER;
-- 제재 시퀀스 삭제
drop sequence sanction_seq;