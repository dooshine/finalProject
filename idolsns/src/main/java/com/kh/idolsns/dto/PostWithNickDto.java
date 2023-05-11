package com.kh.idolsns.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 통합게시물 DTO
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PostWithNickDto {
    // 통합게시물 번호
    private Long postNo;
    // 통합게시물 작성자
    private String memberId;
    // 통합게시물 글종류
    private String postType;
    // 통합게시물 작성시간
    private Date postTime;
    // 통합게시물 내용
    private String postContent;
    // 통합게시물 +닉네임
    private String memberNick;
}
