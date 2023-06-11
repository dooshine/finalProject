package com.kh.idolsns.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.kh.idolsns.dto.MemberSimpleProfileDto;
import com.kh.idolsns.repo.MemberRepo;
import com.kh.idolsns.service.PostShowService;
import com.kh.idolsns.vo.PostShowVO;

@Controller
public class HomeController {
    	
	@Autowired
	private PostShowService postShowService; 
	
    @GetMapping("")
    public String home(HttpServletRequest request, Model model,
    		@ModelAttribute MemberSimpleProfileDto profileDto){
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
//    	postShowService.postShowOne(48l);    	
    	return "post/postMain";
    }
    
}
