package com.kh.idolsns.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.kh.idolsns.configuration.CustomHomepageProperties;
import com.kh.idolsns.dto.ReportDto;
import com.kh.idolsns.dto.SanctionDto;
import com.kh.idolsns.repo.ReportRepo;
import com.kh.idolsns.repo.SanctionRepo;

@Service
public class ReportService {
    
    @Autowired
    private CustomHomepageProperties customHomepageProperties;

    @Autowired
    private ReportRepo reportRepo;

    @Autowired
    private SanctionRepo sanctionRepo;

    // 신고 생성
    public void report(@ModelAttribute ReportDto reportDto){
        // reportDto로 해당 존재 확인, 존재하지 않으면 insert, 존재하면 update
        if(reportRepo.reportExist(reportDto)){
            reportRepo.update(reportDto);
        } else {
            reportRepo.insert(reportDto);

            // # 신고 카운트
            // 신고 전체카운트 제재 
            int reportTotalCnt = reportRepo.selectAllReportCnt(reportDto);
            if(reportTotalCnt == customHomepageProperties.getSANCTION_CRITERIA_TOTAL_1()){
                // 1단계 제재

                // 누적 제재 생성
                sanctionRepo.insert(SanctionDto.builder().sanctionTargetType(reportDto.getReportTargetType()).sanctionTargetPrimaryKey(reportDto.getReportTargetPrimaryKey()).sanctionFor("총 신고 " + customHomepageProperties.getSANCTION_CRITERIA_TOTAL_1() + "회 누적").sanctionTerm(customHomepageProperties.getSANCTION_TERM_TOTAL_1()).build());
            }
            // 신고 기간카운트 제재
            // int reportTermCnt = reportRepo.select

        }
    }
}
