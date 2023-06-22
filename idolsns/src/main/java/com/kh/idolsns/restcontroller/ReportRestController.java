package com.kh.idolsns.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.idolsns.dto.MemberProfileFollowDto;
import com.kh.idolsns.dto.ReportDto;
import com.kh.idolsns.repo.ReportRepo;
import com.kh.idolsns.service.AdminService;
import com.kh.idolsns.service.ReportService;
import com.kh.idolsns.vo.AdminMemberSearchVO;
import com.kh.idolsns.vo.SearchVO;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@CrossOrigin
@RestController
@RequestMapping("/rest/report")
public class ReportRestController {
    
    @Autowired
    private ReportRepo reportRepo;

    // 테스트 repo(지울예정)
    @Autowired
    private AdminService adminService;

    @Autowired
    private ReportService reportService;
    // 신고 생성
    @PostMapping("/")
    public void report(@RequestBody ReportDto reportDto){
        // 신고 생성
        reportService.report(reportDto);
    }

    // 신고 목록 조회
    @PostMapping("/list")
    public List<ReportDto> selectList(@RequestBody SearchVO searchVO){
        return reportRepo.selectList(searchVO);
    }

    // 신고 삭제
    @DeleteMapping("/")
    public void delete(@RequestBody List<Long> reportNoList) {
        reportService.delete(reportNoList);
    }


    // 테스트
    @PostMapping("/test")
    public List<MemberProfileFollowDto> test(@RequestBody AdminMemberSearchVO adminMemberSearchVO){
        // System.out.println(adminMemberSearchVO);
        return adminService.adminSelectMemberList(adminMemberSearchVO);
    }
}
