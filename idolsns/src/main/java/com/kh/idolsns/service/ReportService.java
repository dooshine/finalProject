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
        // reportDto로 해당 정보 존재하는지 확인 후
        // 존재하지 않으면 insert, 존재하면 update
        if(reportRepo.reportExist(reportDto)){
            reportRepo.update(reportDto);
        } else {
            reportRepo.insert(reportDto);
        }
    }
}
