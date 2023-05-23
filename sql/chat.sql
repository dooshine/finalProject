-- 단체 채팅방
CREATE TABLE chat_room(
	chat_room_no NUMBER PRIMARY KEY,
	chat_room_name varchar2(60),
	chat_room_start DATE DEFAULT sysdate NOT NULL,
	chat_room_type char(1) NOT NULL,
	chat_room_name_update char(1) DEFAULT 'N' NOT NULL
);
CREATE SEQUENCE chat_room_seq;

-- 채팅방 참여자
CREATE TABLE chat_join(
	member_id REFERENCES member(member_id) ON DELETE SET NULL,
	chat_room_no NUMBER REFERENCES chat_room(chat_room_no) ON DELETE CASCADE,
	chat_join_time DATE DEFAULT sysdate NOT NULL,
	PRIMARY KEY(chat_room_no, member_id)
);

-- 채팅 메세지
CREATE TABLE CHAT_MESSAGE(
	chat_message_no NUMBER PRIMARY KEY,
	member_id REFERENCES member(member_id) ON DELETE SET NULL,
	chat_room_no REFERENCES chat_room(chat_room_no) ON DELETE CASCADE NOT NULL,
	chat_message_time DATE DEFAULT sysdate NOT NULL,
	chat_message_content varchar2(900) NOT NULL,
	attachment_no number,
	chat_message_type NUMBER NOT NULL
);
CREATE SEQUENCE chat_message_seq;

-- 채팅 읽음 확인
CREATE TABLE chat_read(
	chat_room_no REFERENCES chat_room(chat_room_no) ON DELETE CASCADE,
	chat_message_no REFERENCES chat_message(chat_message_no) ON DELETE CASCADE,
	chat_sender REFERENCES member(member_id) ON DELETE SET NULL,
	chat_reciever varchar2(20) NOT NULL,
	chat_read_time DATE DEFAULT sysdate
);

-- 채팅 좋아요
CREATE TABLE chat_like(
	chat_message_no REFERENCES chat_message(chat_message_no) ON DELETE CASCADE NOT NULL,
	member_id REFERENCES member(member_id) ON DELETE CASCADE NOT NULL,
	PRIMARY KEY(chat_message_no, member_id)
);

-- 1대1 채팅방
CREATE TABLE chat_room_priv(
	chat_room_no REFERENCES chat_room(chat_room_no) ON DELETE CASCADE NOT NULL,
	chat_room_priv_i REFERENCES member(member_id) ON DELETE CASCADE NOT NULL,
	chat_room_priv_u REFERENCES member(member_id) ON DELETE SET NULL,
	PRIMARY KEY(chat_room_priv_i, chat_room_priv_u)
);
