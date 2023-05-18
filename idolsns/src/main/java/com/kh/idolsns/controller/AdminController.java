package com.kh.idolsns.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.idolsns.configuration.CustomHomepageProperties;

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
}
