package com.kh.idolsns.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.dto.TagCntDto;
import com.kh.idolsns.dto.TagDto;
import com.kh.idolsns.repo.AdminRepo;
import com.kh.idolsns.vo.AdminMemberSearchVO;
import com.kh.idolsns.vo.TagCntSearchVO;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminRepo adminRepo;

    // 태그 목록 조회
    @Override
    public List<TagDto> adminTagSelectList() {
        return adminRepo.adminTagSelectList();
    }
    // 태그 타입 수정
    @Override
    public void updateTagTypeByName(String tagType, List<String> tagNameList) {
        for(String tagName : tagNameList){
            adminRepo.updateTagTypeByName(TagDto.builder().tagType(tagType).tagName(tagName).build());
        }
    }
    // 태그 삭제
    @Override
    public void deleteTagByName(List<String> tagNameList) {
        for(String tagName : tagNameList){
            adminRepo.adminTagDelete(tagName);
        }
    }
    // 태그Cnt 조회
    @Override
    public List<TagCntDto> adminTagCntSelectList(TagCntSearchVO tagCntSearchVO) {
        return adminRepo.adminTagCntSelectList(tagCntSearchVO);
    }

    // 회원(member) 목록 조회
    @Override
    public List<MemberDto> adminSelectMemberList(AdminMemberSearchVO adminMemberSearchVO) {
        return adminRepo.adminSelectMemberList(adminMemberSearchVO);
    }
}