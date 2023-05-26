package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.FollowDto;

// 팔로우 추상체
public interface FollowRepo {
    // 팔로우 생성
    void createFollow(FollowDto followDto);
    // 팔로우 개별조회
    FollowDto selectFollowOne(FollowDto followDto);
    // 팔로우 삭제
    void deleteFollow(FollowDto followDto);

    // 팔로우 리스트 조회
    List<FollowDto> selectFollowList(FollowDto followDto);
}
