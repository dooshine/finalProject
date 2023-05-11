-- 통합게시물 테이블 생성
alter table post (
	-- 통합게시물 번호(PK)
	post_no number primary key,
  -- 통합게시물 작성자
	member_id varchar2(20),
  -- 통합게시물 글종류
	post_type varchar2(12),
  -- 통합게시물 작성시간
	post_time date default sysdate not null
  -- 통합게시물 내용
    post_content varchar2(4000)
);
-- 통합게시물 테이블 삭제
drop table post;
commit;




-- 통합게시물 시퀀스 생성
CREATE SEQUENCE post_seq
INCREMENT BY 1 START WITH 1 NOMAXVALUE
MINVALUE 1 NOCYCLE NOCACHE  NOORDER;
-- 통합게시물 시퀀스 삭제
drop sequence post_seq;




-- 통합테이블+닉네임 추가
create or replace view post_with_nick as
    select a.*, member_nick from post a
    left outer join (
        select * from member
    ) b
    on a.member_id = b.member_id
    order by a.member_id;
-- 통합테이블+닉네임 조회
select * from post_with_nick;