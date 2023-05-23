package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.TagCntDto;
import com.kh.idolsns.dto.TagDto;

public interface AdminRepo {
    // 전체 tag 불러오기
	List<TagDto> adminTagSelectList();
    // tag 삭제하기
    boolean adminTagDelete(Long tagNo);
    // 태그 사용량 조회
    List<TagCntDto> adminTagCntSelectList();
}
