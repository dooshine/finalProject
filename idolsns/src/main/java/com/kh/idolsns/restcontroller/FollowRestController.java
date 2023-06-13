package com.kh.idolsns.restcontroller;

import java.util.List;

import javax.security.auth.login.LoginException;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.FollowDto;
import com.kh.idolsns.dto.MemberFollowCntDto;
import com.kh.idolsns.dto.MemberFollowInfoDto;
import com.kh.idolsns.dto.MemberFollowProfileInfoDto;
import com.kh.idolsns.dto.TestDto;
import com.kh.idolsns.service.FollowService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin
@RestController
@RequestMapping("/rest/follow")
public class FollowRestController {
    
    @Autowired
    private FollowService followService;

    @Autowired
    private SqlSession sqlSession;

    // 페이지 팔로우여부 확인
    @GetMapping("/checkFollowPage")
    public boolean checkFollowPage(@ModelAttribute FollowDto followDto, HttpSession session){
        // 회원 아이디 설정
        String memberId = (String)session.getAttribute("memberId");
        followDto.setMemberId(memberId);
        // 팔로우 타입 설정
        followDto.setFollowTargetType("대표페이지");

        return followService.checkFollow(followDto);
    }
    // 회원 팔로우여부 확인
    @GetMapping("/checkFollowMember")
    public boolean checkFollowMember(@ModelAttribute FollowDto followDto, HttpSession session){
        // 회원 아이디 설정
        String memberId = (String)session.getAttribute("memberId");
        followDto.setMemberId(memberId);
        // 팔로우 타입 설정
        followDto.setFollowTargetType("회원");
        return followService.checkFollow(followDto);
    }

    


    // 팔로우생성
    @PostMapping("/")
    public void createFollow(@RequestBody FollowDto followDto, HttpSession session){
        String memberId = (String) session.getAttribute("memberId");
        if(memberId == null){
            return;
        }
        followService.createFollow(followDto);
    }
    // 팔로우(회원) 생성
    @PostMapping("/member")
    public void createFollowMember(@RequestBody FollowDto followDto, HttpSession session){
        // 회원 아이디
        String memberId = (String)session.getAttribute("memberId");
        followDto.setMemberId(memberId);
        // 팔로우 회원찾기 설정
        followDto.setFollowTargetType("회원");

        // 회원 팔로우 생성
        followService.createFollow(followDto);
    }




    // 팔로우한 회원 목록 조회
    @GetMapping("/member")
    public List<String> selectFollowMemberList(@ModelAttribute FollowDto followDto, HttpSession session){
        // 회원 아이디
        String memberId = (String)session.getAttribute("memberId");
        followDto.setMemberId(memberId);
        // 팔로우 회원찾기 설정
        followDto.setFollowTargetType("회원");

        // 본인이 팔로우 한 팔로우 리스트
        return followService.selectFollowPKList(followDto);
    }
    // 팔로우한 페이지 목록 조회
    @GetMapping("/page")
    public List<String> selectFollowPageList(@ModelAttribute FollowDto followDto, HttpSession session){
        // 회원 아이디
        String memberId = (String)session.getAttribute("memberId");
        followDto.setMemberId(memberId);
        // 팔로우 회원찾기 설정
        followDto.setFollowTargetType("대표페이지");

        // 본인이 팔로우 한 팔로우 리스트
        return followService.selectFollowPKList(followDto);
    }




    // 팔로우취소
    @DeleteMapping("/")
    public void deleteFollow(@RequestBody FollowDto followDto){
        followService.deleteFollow(followDto);
    }
    // 회원팔로우 취소
    @DeleteMapping("/member")
    public void deleteFollowMember(@RequestBody FollowDto followDto, HttpSession session){
        // 회원 아이디
        String memberId = (String)session.getAttribute("memberId");
        followDto.setMemberId(memberId);
        // 팔로우 회원찾기 설정
        followDto.setFollowTargetType("회원");
        // 팔로우 삭제
        followService.deleteFollow(followDto);
    }

    



    // 모든 회원 팔로우 통계 얻기
    @GetMapping("/memberFollowCnt")
    public List<MemberFollowCntDto> selectMemberFollowCnt(@RequestParam(required = false, defaultValue="") String memberId){
        return sqlSession.selectList("follow.selectMemberFollowCnt", memberId);
    } 
    // 특정 회원 팔로우 통계 얻기





    // 특정회원 팔로우 정보 불러오기
    @GetMapping("/memberFollowInfo")
    public MemberFollowInfoDto selectMemberFollowInfo(@RequestParam String memberId){
        MemberFollowInfoDto dto = sqlSession.selectOne("follow.selectMemberFollowInfo", memberId);
        return dto;
    }

    // 특정회원 팔로우 프로필 정보 불러오기
    @GetMapping("/memberFollowProfileInfo")
    public MemberFollowProfileInfoDto selectMemberFollowProfileInfo(@RequestParam String memberId){
        MemberFollowProfileInfoDto dto = sqlSession.selectOne("follow.selectMemberFollowProfileInfo", memberId);
        return dto;
    }


    
}
