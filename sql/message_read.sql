-- 테이블1 챗_메세지 테이블
create table chat_message (
  -- 메세지 번호
  chat_message_no number primary key,
  -- 메세지 글쓴이
  member_id references member(member_id),
  -- 메세지 방 번호
  chat_room_no number,
  -- 메세지 보낸시간
  chat_message_time date,
  chat_message_content varchar2(4000)
);

-- 테이블2 챗_메세지 시퀀스
create sequence chat_message_seq;


-- [설정]
-- 방번호가 1번인 방에는 testuser1, testuser2, testuser3가 멤버이다


-- [상황]
-- testuser1이 메세지를 보낸다(chat_join 참조)
insert into chat_message (chat_message_no,member_id,chat_room_no,chat_message_time, chat_message_content) values(1000, 'testuser1', 1, sysdate, '안녕하새우1');
insert into chat_message (chat_message_no,member_id,chat_room_no,chat_message_time, chat_message_content) values(1001, 'testuser1', 1, sysdate, '안녕하새우2');
insert into chat_message (chat_message_no,member_id,chat_room_no,chat_message_time, chat_message_content) values(1002, 'testuser1', 1, sysdate, '안녕하새우3');


drop table chat_message;


-- 읽은 사람 기록 테이블
create table chat_read (
  -- 메세지 번호
  chat_message_no references chat_message,
  -- 읽은 사람 번호
  member_id varchar2(20),
  -- 읽은 시간
  read_time date
);




-- [1] 메세지별 읽은 횟수 조회
select count(*) cnt, chat_message_no from chat_read
    group by chat_message_no



-- [2] chat메세지 테이블과 메세지별 읽은 횟수 데이터 outer join
create or replace view message_with_read as
select a.*, cnt from chat_message a
  left outer join (
    select count(*) cnt, chat_message_no from chat_read
    group by chat_message_no
  ) b
  on a.chat_message_no = b.chat_message_no
order by a.chat_message_no asc;


-- [결과] 쳇 메세지 + 읽은 횟수
select * from message_with_read;


-- 읽기 시작(확인 + 데이터 생성)
select * from chat_read where chat_message_no = 1000 and member_id = 'testuser2';
insert into chat_read (chat_message_no, member_id) values (1000, 'testuser2');

select * from chat_read where chat_message_no = 1001 and member_id = 'testuser2';
insert into chat_read (chat_message_no, member_id) values (1001, 'testuser2');

select * from chat_read where chat_message_no = 1002 and member_id = 'testuser2';
insert into chat_read (chat_message_no, member_id) values (1002, 'testuser2');
select * from message_with_read;

insert into chat_read (chat_message_no, member_id) values (1000, 'testuser3');
insert into chat_read (chat_message_no, member_id) values (1001, 'testuser3');
insert into chat_read (chat_message_no, member_id) values (1002, 'testuser3');
select * from message_with_read;



-- 읽은 메세지 지우기
delete from chat_read;
