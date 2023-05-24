-- 알림
CREATE TABLE noti(
	noti_no number PRIMARY KEY,
	member_id REFERENCES member(member_id) ON DELETE CASCADE NOT NULL,
	noti_type number NOT NULL,
	noti_time date DEFAULT sysdate NOT NULL
);
CREATE SEQUENCE noti_seq;
