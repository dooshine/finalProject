package com.kh.idolsns.service;

import java.util.List;

import org.springframework.web.bind.annotation.RequestBody;

import com.kh.idolsns.dto.TagCntDto;
import com.kh.idolsns.dto.TagDto;

public interface AdminService {
    // 태그 목록 조회
    List<TagDto> adminTagSelectList();
    // 태그 삭제
    void deleteTag(@RequestBody List<Long> tagNoList);
    // 태그Cnt 조회
    List<TagCntDto> adminTagCntSelectList();

}
