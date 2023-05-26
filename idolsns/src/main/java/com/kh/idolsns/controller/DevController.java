package com.kh.idolsns.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.repo.MemberRepo;

@Controller
@RequestMapping("/dev")
public class DevController {
    
    @Autowired
    private MemberRepo memberRepo;

    // 로그인 버튼
    @GetMapping("/login")
    public String login(@RequestParam String memberId ,HttpSession session, HttpServletRequest request){
        MemberDto memberDto = memberRepo.selectOne(memberId);
        session.setAttribute("memberId", memberDto.getMemberId());
        session.setAttribute("memberLevel", memberDto.getMemberLevel());
        return "redirect:" + request.getHeader("Referer");
    }

    // 팔로우 통합
    @GetMapping("/follow")
    public String follow(){
        return "/dev/dev_follow";
    }

    // 내가 팔로우한 사람들 목록
    @GetMapping("/followMember")
    public String followMember(){
        return "/dev/dev_followMember";
    }

    // 팔로우 수 확인 예제
    @GetMapping("/memberFollowCnt")
    public String followCnt(){
        return "/dev/dev_memberFollowCnt";
    }
}
