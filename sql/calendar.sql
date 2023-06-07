-- 캘린더
CREATE TABLE calendar(
	calendar_no NUMBER NOT NULL,
	member_id REFERENCES MEMBER(member_id) ON DELETE CASCADE NOT NULL,
	calendar_title VARCHAR2(90) NOT NULL,
	calendar_start DATE NOT NULL,
	calendar_end DATE NOT NULL,
	calendar_memo varchar2(300)
);
CREATE SEQUENCE calendar_seq;
