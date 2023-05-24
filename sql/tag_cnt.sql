-- # 태그 사용량 조회 view 생성
create or replace view tag_cnt as
  select count(*) tag_cnt, tag_type ,tag_name 
  from tag 
  group by tag_name, tag_type 
  order by count(*) desc;




-- # 사용량 보기
select * from tag_cnt;
-- 자유태그 사용량 보기
select * from tag_cnt 
  where tag_type = '자유';
-- 고정태그 사용량 보기
select * from tag_cnt 
  where tag_type = '고정';




-- # 태그이름으로 타입 업데이트하기 
-- 태그타입 고정으로 바꾸기
update tag
  set tag_type = '고정' 
  where tag_name = '?';
-- 태그타입 자유로 바꾸기
update tag
  set tag_type = '자유' 
  where tag_name = '?';