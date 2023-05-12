package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.ReportDto;
import com.kh.idolsns.vo.SearchVO;

// 신고 Repo
public interface ReportRepo {
    // 신고 생성
    void insert(ReportDto reportDto);
    // 신고 체크(중복 확인)
    ReportDto checkReport(ReportDto reportDto);
    // 신고 단일조회
    ReportDto selectOne(ReportDto reportDto);
    // 신고 목록조회
    List<ReportDto> selectList(SearchVO searchVO);
    // 신고 삭제(신고 취소)
    boolean delete(Long reportNo);
}
