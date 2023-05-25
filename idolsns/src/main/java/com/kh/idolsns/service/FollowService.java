package com.kh.idolsns.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.idolsns.dto.FollowDto;
import com.kh.idolsns.repo.FollowRepo;

// 팔로우 서비스
@Service
public class FollowService {

    @Autowired
    private FollowRepo followRepo;
    
    // 팔로우생성
    public void createFollow(FollowDto followDto){
        followRepo.createFollow(followDto);
    }

    // 팔로우여부 확인
    public boolean checkFollow(FollowDto followDto){
        FollowDto findFollowDto = followRepo.selectFollowOne(followDto);
        return findFollowDto == null ? false : true;
    }

    // 팔로우 삭제(팔로우한 사람, 팔로우 대상 타입, 팔로우 대상 PK)
    public void deleteFollow(FollowDto followDto) {
        followRepo.deleteFollow(followDto);
    }
    
    // 팔로우리스트 목록
    public List<FollowDto> selectFollowList(FollowDto followDto){
        return followRepo.selectFollowList(followDto);
    }

    // 팔로우한 회원 목록 좋회
    public List<String> selectFollowingMemberList(FollowDto followDto){
        // 회원목록만따로 빼기
        List<String> followingMemberList = new ArrayList<>();
        List<FollowDto> followDtoList = followRepo.selectFollowList(followDto);
        for(FollowDto dto : followDtoList){
            followingMemberList.add(dto.getFollowTargetPrimaryKey());
        }
        return followingMemberList;
    }
}
