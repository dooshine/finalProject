package com.kh.idolsns.restcontroller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.ReportDto;
import com.kh.idolsns.repo.ReportRepo;

@CrossOrigin
@RestController
@RequestMapping("/rest/report")
public class ReportRestController {
    
    @Autowired
    private ReportRepo reportRepo;

    // 신고 생성
    @PostMapping("/")
    public void report(ReportDto reportDto, HttpSession session){
        // 신고자 아이디
        String memberId = (String)session.getAttribute("memberId");
        // 신고 대상 타입
        // 신고 대상 PK
        // 신고 이유
        // reportRepo()
    }
    
}
