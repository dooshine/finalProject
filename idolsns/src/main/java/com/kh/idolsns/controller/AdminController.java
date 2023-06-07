package com.kh.idolsns.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    

    // 관리자페이지 홈
    @GetMapping("/")
    public String adminHome(){
        return "/admin/adminHome";
    }
    // 관리자페이지 회원 목록
    @GetMapping("/member")
    public String adminMember(){
        return "/admin/adminMember";
    }
    // 관리자페이지 신고 목록
    @GetMapping("/report")
    public String adminReport(){
        return "/admin/adminReport";
    }
    // 관리자페이지 제재 목록
    @GetMapping("/sanction")
    public String adminSanction(){
        return "/admin/adminSanction";
    }
    // 관리자페이지 태그 목록
    @GetMapping("/tag")
    public String adminTag(){
        return "/admin/adminTag";
    }
    // 관리자페이지 태그 사용량
    @GetMapping("/tagCnt")
    public String tagCnt(){
        return "/admin/adminTagCnt";
    }
    // 관리자페이지 고정태그
    @GetMapping("/fixedTag")
    public String fixedTag(){
        return "/admin/adminFixedTag";
    }
    // 관리자페이지 대표페이지 관리
    @GetMapping("/artist")
    public String artist(){
        return "/admin/adminArtist";
    }

    // 관리자페이지 테스트
    @GetMapping("/test")
    public String test(){
        return "/admin/adminTest";
    }
}
