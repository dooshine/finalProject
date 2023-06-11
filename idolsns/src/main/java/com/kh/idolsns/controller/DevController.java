package com.kh.idolsns.controller;

import java.util.Map;

import javax.security.auth.login.LoginException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.dto.TestDto;
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

    // 멤버 프로필 예제
    @GetMapping("/memberProfile")
    public String getMemberProfile(){
        return "/dev/dev_getMemberProfile";
    }

    // css 예제
    @GetMapping("/css")
    public String css(){
        return "/dev/dev_dooCss";
    }


    // test 예제
    @GetMapping("/restInterceptorTest")
    public String test(){
        return "/dev/dev_restInterceptorTest";
    }

    // [테스트] 상태코드 전달하기
    @GetMapping("/restInterceptor")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> test(HttpSession session) throws LoginException{
    // public ResponseEntity<TestDto> test(HttpSession session) throws LoginException{
        String memberId = (String)session.getAttribute("memberId");

        // (X) Interceptor로 간섭하지 않음
        // if(memberId == null){
        //     throw new LoginException();
        // }
        if(memberId == null){
            return ResponseEntity.status(500).build();
        } else {
            return ResponseEntity.ok().body(Map.of("no", 1, "name", "김통깨"));
            // return ResponseEntity.ok().body(TestDto.builder().no(1).name("김통깨").build());
        }
    }
}
