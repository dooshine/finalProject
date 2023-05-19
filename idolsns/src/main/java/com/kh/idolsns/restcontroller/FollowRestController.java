package com.kh.idolsns.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.FollowDto;
import com.kh.idolsns.service.FollowService;

@CrossOrigin
@RestController
@RequestMapping("/rest/follow")
public class FollowRestController {
    
    @Autowired
    private FollowService followService;

    // 팔로우여부 확인
    @GetMapping("/check")
    public boolean check(@ModelAttribute FollowDto followDto){
        return followService.checkFollow(followDto);
    }

    // 팔로우생성
    @PostMapping("/")
    public void createFollow(@RequestBody FollowDto followDto){
        followService.createFollow(followDto);
    }

    // 팔로우취소
    @DeleteMapping("/")
    public void deleteFollow(@RequestBody FollowDto followDto){
        followService.deleteFollow(followDto);
    }
}
