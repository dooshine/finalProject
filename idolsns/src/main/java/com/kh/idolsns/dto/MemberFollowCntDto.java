package com.kh.idolsns.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 회원 팔로우 통계 테이블
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberFollowCntDto {
    
    // 회원 아이디
    private String memberId;
    // 회원 팔로우 수
    private int memberFollowCnt;
    // 회원 팔로워 수
    private int memberFollowerCnt;
    // 회원 대표페이지 팔로우 수
    private int memberPageCnt;
}
