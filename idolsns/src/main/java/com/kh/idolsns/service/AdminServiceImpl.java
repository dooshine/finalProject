package com.kh.idolsns.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.idolsns.dto.TagCntDto;
import com.kh.idolsns.dto.TagDto;
import com.kh.idolsns.repo.AdminRepo;
import com.kh.idolsns.repo.TagRepo;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminRepo adminRepo;

    // 태그 목록 조회
    @Override
    public List<TagDto> adminTagSelectList() {
        return adminRepo.adminTagSelectList();
    }
    // 태그 삭제
    @Override
    public void deleteTag(List<Long> tagNoList) {
        for(Long tagNo : tagNoList){
            adminRepo.adminTagDelete(tagNo);
        }
    }
    // 태그Cnt 조회
    @Override
    public List<TagCntDto> adminTagCntSelectList() {
        return adminRepo.adminTagCntSelectList();
    }
    
}