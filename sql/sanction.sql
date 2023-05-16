-- 제재 테이블
create table sanction(
    -- 제재 PK(시퀀스)
    sanction_seq number primary key,
    -- 제재 대상 종류
    sacntion_target_type varchar2(9) not null check (sacntion_target_type in ('게시물', '댓글', '회원')),
    -- 제재 대상 PK
    sacntion_target_primary_key varchar2(20) not null,
    -- 제재 일자
    sanction_expire date not null
);


-- 제재 시퀀스 생성
CREATE SEQUENCE sanction_seq
INCREMENT BY 1 START WITH 1 NOMAXVALUE
MINVALUE 1 NOCYCLE NOCACHE  NOORDER;
-- 제재 시퀀스 삭제
drop sequence sanction_seq;