package com.kh.idolsns.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

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

    // 페이지 팔로우여부 확인
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


    // # 회원
    // 팔로우(회원) 생성
    @PostMapping("/member")
    public void createFollowMember(@RequestBody FollowDto followDto, HttpSession session){
        // 회원 아이디
        String memberId = (String)session.getAttribute("memberId");
        followDto.setMemberId(memberId);
        // 팔로우 회원찾기 설정
        followDto.setFollowTargetType("회원");
        System.out.println(followDto);

        // 회원 팔로우 생성
        followService.createFollow(followDto);
    }

    // 팔로우한 회원 목록 조회
    @GetMapping("/member")
    public List<FollowDto> selectFollowingMemberList(@ModelAttribute FollowDto followDto, HttpSession session){
        // 회원 아이디
        String memberId = (String)session.getAttribute("memberId");
        followDto.setMemberId(memberId);
        // 팔로우 회원찾기 설정
        followDto.setFollowTargetType("회원");

        System.out.println(followDto);
        // 본인이 팔로우 한 팔로우 리스트
        return followService.selectFollowList(followDto);
    }

    // 팔로우한 페이지 목록 조회
    @GetMapping("/page")
    public List<FollowDto> selectFollowingPageList(@ModelAttribute FollowDto followDto, HttpSession session){
        // 회원 아이디
        String memberId = (String)session.getAttribute("memberId");
        followDto.setMemberId(memberId);
        // 팔로우 회원찾기 설정
        followDto.setFollowTargetType("대표페이지");

        System.out.println(followDto);
        // 본인이 팔로우 한 팔로우 리스트
        return followService.selectFollowList(followDto);
    }
}
