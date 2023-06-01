-- 대표페이지 프로필사진 저장

create table artist;



select  from
(select follow_target_primary_key from follow 
where 
  member_id = 'testuser1' 
  and 
  follow_target_type = '회원') a
left join MEMBER_SIMPLE_PROFILE p on a.follow_target_primary_key = p.member_id;

select * from MEMBER_SIMPLE_PROFILE;

CREATE OR REPLACE VIEW testView AS 
  select 
        A.attachment_no,
        M.member_id,
        M.member_nick
    from
        attachment A inner join member_profile_image MP
            on A.attachment_no = MP.attachment_no
        inner join member M
            on MP.member_id = M.member_id;
