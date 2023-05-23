package com.kh.idolsns.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.idolsns.repo.MemberRepo;
import com.kh.idolsns.service.PostShowService;

@Controller
public class HomeController {
    	
	@Autowired
	private PostShowService postShowService; 
	
    @GetMapping("")
    public String home(HttpServletRequest request){
        System.out.println(request.getHeader("Referer"));
        return "home";
    }

    // 임시 파일 업로드 주소
    @GetMapping("/file")
    public String file(){
        return "temp_file";
    }

    // 임시 서머노트 & 파일 업로드 연계
    @GetMapping("/write")
    public String write(){
        return "temp_write";
    }
    
    @GetMapping("/postMain")
    public String postMain(Model model, HttpSession session) {
    	String memberId = (String)session.getAttribute("memberId");
    	model.addAttribute("memberId",memberId);
    	postShowService.postShow(37l);
    	return "post/postMain";
    }
}
