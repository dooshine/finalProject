-- 회원 팔로우 통계 테이블(팔로우 수, 팔로워 수, 팔로우한 페이지 수) 
create or replace view member_follow_cnt as
select m.member_id, a.member_follow_cnt, b.member_follower_cnt, c.page_follow_cnt from member m
    left join (
        select count(*) member_follow_cnt , member_id from follow 
        where follow.follow_target_type = '회원'
        group by member_id
    ) a on m.member_id = a.member_id
    left join (
        select count(*) member_follower_cnt, follow_target_primary_key member_id from follow 
        where follow.follow_target_type = '회원'
        group by follow.follow_target_primary_key
    ) b on m.member_id = b.member_id
    left join (
        select count(*) page_follow_cnt, member_id from follow 
        where follow.follow_target_type = '대표페이지'
        group by member_id
    ) c on m.member_id = c.member_id
order by m.member_id asc;
-- 회원 팔로우 통계 조회
select * from member_follow_cnt;




-- 회원 팔로우 수
select count(*) , member_id from follow 
where follow.follow_target_type = '회원'
group by member_id;




-- 회원 팔로워 수
select count(*), follow_target_primary_key from follow 
where follow.follow_target_type = '회원'
group by follow.follow_target_primary_key;




-- 회원 팔로우 수
select count(*), member_id from follow 
where follow.follow_target_type = '대표페이지'
group by member_id;