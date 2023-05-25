-- 고정태그 테이블 생성
create table fixed_tag (
    fixed_tag_no number primary key,
    fixed_tag_name varchar2(90)
);
drop table fixed_tag;
ALTER TABLE fixed_tag 
MODIFY fixed_tag_name varchar2(90) not NULL;



-- 고정태그 시퀀스 생성
CREATE SEQUENCE fixed_tag_seq
INCREMENT BY 1 START WITH 1 NOMAXVALUE
MINVALUE 1 NOCYCLE NOCACHE  NOORDER;
-- 통합게시물 시퀀스 삭제
drop sequence fixed_tag_seq;




-- 고정태그 사용량 View 생성
create or replace view fixed_tag_cnt as
  select c.fixed_tag_name from (
    select rownum rn, a.fixed_tag_name from fixed_tag a where instr(fixed_tag_name, '고정') > 0
      left join (
        select * from tag_cnt where tag_type = '고정' 
      ) b
      on a.fixed_tag_name = b.tag_name
    order by b.tag_cnt desc, fixed_tag_name asc
  ) c
  where c.rn between 1 and 5;
select * from fixed_tag_cnt;



-- 테스트
select rownum rn, a.fixed_tag_name from fixed_tag a where instr(fixed_tag_name, '고정') > 0;