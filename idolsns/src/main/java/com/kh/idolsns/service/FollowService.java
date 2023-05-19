package com.kh.idolsns.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;

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
}
