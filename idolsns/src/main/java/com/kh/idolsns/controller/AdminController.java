package com.kh.idolsns.controller;

import javax.servlet.http.HttpServletRequest;

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
    // 관리자페이지 회원리스트
    @GetMapping("/member")
    public String adminMember(){
        return "/admin/adminMember";
    }
    // 관리자페이지 신고리스트
    @GetMapping("/report")
    public String adminReport(){
        return "/admin/adminReport";
    }
    // 관리자페이지 제재리스트
    @GetMapping("/sanction")
    public String adminSanction(){
        return "/admin/adminSanction";
    }
    // 관리자페이지 태그리스트
    @GetMapping("/tag")
    public String adminTag(){
        return "/admin/adminTag";
    }
    // 관리자페이지 태그카운트
    @GetMapping("/tagCnt")
    public String tagCnt(){
        return "/admin/adminTagCnt";
    }
}
