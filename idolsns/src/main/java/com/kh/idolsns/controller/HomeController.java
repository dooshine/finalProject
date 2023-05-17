package com.kh.idolsns.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.idolsns.dto.PostDto;
import com.kh.idolsns.repo.PostRepo;

@Controller
public class HomeController {
    
    @GetMapping("/")
    public String home(){
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
    public String postMain() {
    	return "post/postMain";
    }
}
