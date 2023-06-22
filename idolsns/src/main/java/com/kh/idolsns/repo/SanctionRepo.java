package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.SanctionDto;
import com.kh.idolsns.vo.SanctionSearchVO;

// 제재 테이블
public interface SanctionRepo {
    // 제재 생성
    void insert(SanctionDto sanctionDto);

    // 제재 목록조회
    List<SanctionDto> selectListComplex(SanctionSearchVO sanctionSearchVO);
}
