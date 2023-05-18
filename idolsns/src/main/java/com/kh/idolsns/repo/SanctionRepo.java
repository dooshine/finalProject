package com.kh.idolsns.repo;

import com.kh.idolsns.dto.SanctionDto;

// 제재 테이블
public interface SanctionRepo {
    // 제재 생성
    void insert(SanctionDto sanctionDto);
}
