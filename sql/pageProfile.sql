-- 페이지 별 페이지 수
select * from follow;

-- 대표페이지 별 팔로우 카운트 수
select count(*), follow_target_primary_key from follow 
  where follow_target_type = '대표페이지' 
  group by follow_target_primary_key;


select artist_profile.artist_no, artist_name, artist_eng_name, artist_profile.attachment_no, b.followerCnt from artist
left join artist_profile
on artist.artist_no = artist_profile.artist_no
left join (
select count(*) followerCnt, follow_target_primary_key from follow 
  where follow_target_type = '대표페이지' 
  group by follow_target_primary_key
) b
on artist.artist_eng_name_lower = b.follow_target_primary_key;

select * from artist;
select * from artist_profile;
  
select count(*), follow_target_primary_key from (select * from follow where follow_target_type = '대표페이지') group by follow_target_primary_key;