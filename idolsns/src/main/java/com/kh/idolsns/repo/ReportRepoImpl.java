package com.kh.idolsns.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.ReportDto;
import com.kh.idolsns.vo.SearchVO;

@Repository
public class ReportRepoImpl implements ReportRepo{

    @Autowired
    private SqlSession sqlSession;
    
    // 신고 생성
    @Override
    public void insert(ReportDto reportDto) {
        sqlSession.insert("report.insert", reportDto);
    }

    // 신고 체크(중복확인)
    @Override
    public boolean reportExist(ReportDto reportDto) {
        return sqlSession.selectOne("report.reportExist", reportDto) != null;
    }

    // 신고 단일조회
    @Override
    public ReportDto selectOne(ReportDto reportDto) {
        return sqlSession.selectOne("report.selectOne", reportDto);
    }

    // 신고 목록조회
    @Override
    public List<ReportDto> selectList(SearchVO searchVO) {
        return sqlSession.selectList("report.selectList", searchVO);
    }

    // 신고 횟수 조회 (전체기간 - 전체 100회 이상 제재)
    @Override
    public Integer selectAllReportCnt(ReportDto reportDto) {
        return sqlSession.selectOne("report.selectAllReportCnt", reportDto);
    }

    // 신고 횟수 조회 (지정기간 - 한달 30회 이상 제재)
    @Override
    public Integer selectTermReportCnt(ReportDto reportDto) {
        return sqlSession.selectOne("report.selectTermReportCnt", reportDto);
    }

    // 신고 사유 수정
    @Override
    public boolean update(ReportDto reportDto) {
        return sqlSession.update("report.update", reportDto) > 0;
    }
    
    // 신고 삭제
    @Override
    public boolean delete(Long reportNo) {
        return sqlSession.delete("report.delete", reportNo) > 0;
    }
    
}
