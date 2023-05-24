-- 대표페이지 테이블 생성
create table artist (
    -- 대표페이지 번호(PK)
    artist_no number primary key,
    -- 대표페이지 이름
    artist_name varchar2(30) not null unique
);




-- 대표페이지 시퀀스 생성
CREATE SEQUENCE artist_seq
INCREMENT BY 1 START WITH 1 NOMAXVALUE
MINVALUE 1 NOCYCLE NOCACHE  NOORDER;
-- 통합게시물 시퀀스 삭제
drop sequence post_seq;




insert into artist values (artist_seq.nextval, 'zico');
insert into artist values (artist_seq.nextval, 'btob');
commit;

select * from artist;


select a.*, b.follow_cnt from artist a
  left join (
    select count(*) follow_cnt, follow_target_primary_key as artist_name from follow 
    where follow_target_type = '대표페이지'
    group by follow_target_primary_key
  ) b
  on a.artist_name = b.artist_name
order by a.artist_no asc;


-- 아티스트 테이블 + 팔로우 수 + 프로필사진 번호
create or replace view artist_view as 
select c.*, d.attachment_no from (
  select a.*, b.follow_cnt from artist a
    left join (
      select count(*) follow_cnt, follow_target_primary_key as artist_name from follow 
      where follow_target_type = '대표페이지'
      group by follow_target_primary_key
    ) b
    on a.artist_name = b.artist_name
  ) c
  left join artist_profile d
  on c.artist_no = d.artist_no
  order by c.artist_no asc;  

select * from artist_view;


-- 대표페이지 프로필 테이블 생성
create table artist_profile(
    artist_no references artist(artist_no) on delete cascade primary key,
    attachment_no references attachment(attachment_no) on delete cascade
);