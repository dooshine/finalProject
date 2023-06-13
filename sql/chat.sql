-- 단체 채팅방
CREATE TABLE chat_room(
	chat_room_no NUMBER PRIMARY KEY,
	chat_room_name1 varchar2(60),
	chat_room_name2 varchar2(60),
	chat_room_start DATE DEFAULT sysdate NOT NULL,
	chat_room_type char(1) CHECK(chat_room_type IN ('P', 'G') NOT NULL,
	chat_room_last TIMESTAMP NOT NULL DEFAULT sysdate
);
CREATE SEQUENCE chat_room_seq;

-- 채팅방 참여자
CREATE TABLE chat_join(
	member_id varchar2(20) CHECK(regexp_like(member_id, '^[a-z][a-z0-9]{8,20}$')) NOT NULL,
	chat_room_no NUMBER REFERENCES chat_room(chat_room_no) ON DELETE CASCADE,
	chat_join_time DATE DEFAULT sysdate NOT NULL
);

-- 채팅 메세지
CREATE TABLE CHAT_MESSAGE(
	chat_message_no NUMBER PRIMARY KEY,
	member_id varchar2(20) CHECK(regexp_like(member_id, '^[a-z][a-z0-9]{8,20}$')) NOT NULL,
	chat_room_no REFERENCES chat_room(chat_room_no) ON DELETE CASCADE NOT NULL,
	chat_message_time DATE DEFAULT sysdate NOT NULL,
	chat_message_content varchar2(900) NOT NULL,
	attachment_no number,
	chat_message_type NUMBER CHECK(chat_message_type IN (1, 4, 5, 6, 10)) NOT NULL
);
CREATE SEQUENCE chat_message_seq;

-- 채팅 읽음 확인
CREATE TABLE chat_read(
	chat_room_no REFERENCES chat_room(chat_room_no) ON DELETE CASCADE,
	chat_message_no REFERENCES chat_message(chat_message_no) ON DELETE CASCADE,
	chat_sender varchar2(20) CHECK(regexp_like(chat_sender, '^[a-z][a-z0-9]{8,20}$')) NOT NULL,
	chat_receiver varchar2(20) CHECK(regexp_like(chat_receiver, '^[a-z][a-z0-9]{8,20}$')) NOT NULL,
	chat_read_time DATE DEFAULT sysdate
);

-- 1대1 채팅방
CREATE TABLE chat_room_priv(
	chat_room_priv_no REFERENCES chat_room(chat_room_no) ON DELETE CASCADE NOT NULL,
	chat_room_priv_i REFERENCES member(member_id) ON DELETE CASCADE NOT NULL,
	chat_room_priv_u REFERENCES member(member_id) ON DELETE SET NULL,
	PRIMARY KEY(chat_room_priv_i, chat_room_priv_u)
);
