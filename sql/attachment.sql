-- 첨부 파일
CREATE TABLE attachment (
	attachment_no number primary key,
	attachment_name	varchar2(100) NULL,
	attachment_type	varchar2(10) NULL,
	attachment_size	number NULL
);

create sequence attachment_seq;
