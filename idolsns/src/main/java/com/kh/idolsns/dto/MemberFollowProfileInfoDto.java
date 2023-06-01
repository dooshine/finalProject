package com.kh.idolsns.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 멤버 팔로우 프로필 정보 DTO
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberFollowProfileInfoDto {
    // 유저 이름
    private String memberId;
    // 내가 팔로우한 사람 목록
    private List<MemberProfileDto> followMemberList;
    // 나를 팔로우한 사람 목록
    private List<MemberProfileDto> followerMemberList;
    // 내가 팔로우한 페이지 목록
    private List<ArtistProfileDto> followPageList;
}
