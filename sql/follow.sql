-- 팔로우 테이블 생성
CREATE TABLE follow (
    -- 팔로우 번호(PK)
	follow_no number primary key,
    -- 팔로우 한 사람    
	member_id varchar2(20) references member(member_id) on delete cascade,
    -- 팔로우 대상 종류
	follow_target_type varchar2(9)	NULL,
    -- 팔로우 대상 PK
	follow_target_primary_key varchar2(20)	NULL,
    -- 팔로우 시간
	follow_time	date NULL
);
-- 팔로우 테이블 삭제
DROP TABLE FOLLOW;




-- 팔로우 시퀀스 생성
CREATE SEQUENCE follow_seq
INCREMENT BY 1 START WITH 1 NOMAXVALUE
MINVALUE 1 NOCYCLE NOCACHE  NOORDER;
-- 통합게시물 시퀀스 삭제
drop sequence follow_seq;