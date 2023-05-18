package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.ReportDto;
import com.kh.idolsns.vo.SearchVO;

// 신고 Repo
public interface ReportRepo {
    // 신고 생성
    void insert(ReportDto reportDto);
    // 신고 체크(중복 확인)
    boolean reportExist(ReportDto reportDto);
    // 신고 단일조회
    ReportDto selectOne(ReportDto reportDto);
    // 신고 목록조회
    List<ReportDto> selectList(SearchVO searchVO);
    // 신고 횟수 조회 (전체기간 - 전체 100회 이상 제재)
    Integer selectAllReportCnt(ReportDto reportDto);
    // 신고 횟수 조회 (지정기간 - 한달 30회 이상 제재)
    Integer selectTermReportCnt(ReportDto reportDto);
    // 신고 사유 수정
    boolean update(ReportDto reportDto);
    // 신고 삭제(신고 취소)
    boolean delete(Long reportNo);
}
