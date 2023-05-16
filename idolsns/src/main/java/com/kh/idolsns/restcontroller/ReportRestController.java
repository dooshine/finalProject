package com.kh.idolsns.restcontroller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.ReportDto;
import com.kh.idolsns.repo.ReportRepo;
import com.kh.idolsns.service.ReportService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@CrossOrigin
@RestController
@RequestMapping("/rest/report")
public class ReportRestController {
    
    @Autowired
    private ReportRepo reportRepo;

    @Autowired
    private ReportService reportService;
    // 신고 생성
    @PostMapping("/")
    public void report(@RequestBody ReportDto reportDto){
        // 신고 생성
        reportService.report(reportDto);
    }
    
}
