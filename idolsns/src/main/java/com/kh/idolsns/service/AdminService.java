package com.kh.idolsns.service;

import java.util.List;

import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.dto.TagCntDto;
import com.kh.idolsns.dto.TagDto;
import com.kh.idolsns.vo.AdminMemberSearchVO;
import com.kh.idolsns.vo.TagCntSearchVO;

public interface AdminService {
    // 태그 목록 조회
    List<TagDto> adminTagSelectList();
    // 태그 타입 수정
    void updateTagTypeByName(String tagType, List<String> tagNameList);
    // 태그 삭제
    void deleteTagByName(List<String> tagNameList);
    // 태그Cnt 조회
    List<TagCntDto> adminTagCntSelectList(TagCntSearchVO tagCntSearchVO);
    
    // 회원(member) 목록 조회
    public List<MemberDto> adminSelectMemberList(AdminMemberSearchVO adminMemberSearchVO);
}
