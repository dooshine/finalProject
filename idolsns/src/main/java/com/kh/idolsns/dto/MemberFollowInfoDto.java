package com.kh.idolsns.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class MemberFollowInfoDto {

    // 유저 이름
    private String memberId;
    // 내가 팔로우한 사람 목록
    private List<String> followMemberList;
    // 나를 팔로우한 사람 목록
    private List<String> followerMemberList;
    // 내가 팔로우한 페이지 목록
    private List<String> followPageList;
}
