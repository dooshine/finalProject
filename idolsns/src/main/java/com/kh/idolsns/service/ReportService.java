package com.kh.idolsns.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.kh.idolsns.dto.ReportDto;
import com.kh.idolsns.repo.ReportRepo;

@Service
public class ReportService {
    
    @Autowired
    private ReportRepo reportRepo;

    // 신고 생성
    public void report(@ModelAttribute ReportDto reportDto){
        // reportDto로 해당 존재 확인, 존재하지 않으면 insert, 존재하면 update
        if(reportRepo.reportExist(reportDto)){
            reportRepo.update(reportDto);
        } else {
            reportRepo.insert(reportDto);

            // 신고 카운트 조사
            // 신고 카운트 전체 100개 시 제재 
            int reportCnt = reportRepo.selectAllReportCnt(reportDto);
            if(reportCnt == 100){
                // 1단계 제재
            } 
        }
    }
}
