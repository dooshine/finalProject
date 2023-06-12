-- 대표페이지 테이블 생성
create table artist (
    -- 대표페이지 번호(PK)
    artist_no number primary key,
    -- 대표페이지 이름
    artist_name varchar2(30) not null unique,
    -- 대표페이지 영어이름
    artist_eng_name varchar2(30) not null unique,
    -- 대표페이지 영어이름(소문자, 띄어쓰기 제거)
    artist_eng_name_lower varchar2(30) not null unique
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
    on a.artist_eng_name_lower = b.artist_name
  ) c
  left join artist_profile d
  on c.artist_no = d.artist_no
  order by c.artist_no asc;  

select * from artist_view;
update follow set attachment_no = #{attachmentNo} where artist_no = #{artistNo}

-- 대표페이지 프로필 테이블 생성
create table artist_profile(
    artist_no references artist(artist_no) on delete cascade primary key,
    attachment_no references attachment(attachment_no) on delete cascade
);




-- ######################## 대표페이지 constraint ########################
-- 대표페이지 이름: [한글, 띄어쓰기] 1~10자, 최소 한글 1글자
ALTER TABLE artist
ADD 
check (
  regexp_like(artist_name, '^[[:space:]가-힣]{1,10}$')
  and 
  regexp_like(artist_name, '[가-힣]{1,}')
);

-- 대표페이지 영어이름 [영어 대소문자, 띄어쓰기] 1~30자, 최소 영어 1글자
ALTER TABLE artist
ADD 
check (
  regexp_like(artist_eng_name, '^[[:space:]A-Za-z]{1,30}$')
  and
  regexp_like(artist_eng_name, '[A-Za-z]+')
);

-- 대표페이지 영어식별이름 [영어 소문자] 1~30자
ALTER TABLE artist
ADD 
check (
  regexp_like(artist_eng_name_lower, '^[a-z]{1,30}$')
);

-- ######################## 대표페이지 constraint 끝 #######################
