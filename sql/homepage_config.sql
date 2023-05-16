// 홈페이지 설정 테이블 생성
create table homepage_config(
  hompepage_config_no number primary key,
  hompepage_config_report_all_1 number,
  hompepage_config_report_all_2 number,
  hompepage_config_report_all_3 number,
  hompepage_config_report_term number
);

-- 홈페이지 설정 시퀀스(캐시 X)
CREATE SEQUENCE homepage_config_seq
INCREMENT BY 1 START WITH 1 NOMAXVALUE
MINVALUE 1 NOCYCLE NOCACHE  NOORDER;
--신고 시퀀스 삭제
drop sequence homepage_config_seq;


insert into homepage_config