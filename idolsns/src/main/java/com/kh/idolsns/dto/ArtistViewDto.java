package com.kh.idolsns.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 대표페이지 DTO
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ArtistViewDto {
    // 대표페이지 번호(PK)
    private int artistNo;
    // 대표페이지 이름
    private String artistName;
    // 대표페이지 영어이름
    private String artistEngName;
    // 대표페이지 영어이름(소문자)
    private String artistEngNameLower;
    // 대표페이지 팔로우 수
    private Integer followCnt;
    // 대표페이지 대표이미지
    private Integer attachmentNo;
}
