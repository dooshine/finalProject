package com.kh.idolsns.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.SanctionDto;
import com.kh.idolsns.vo.SanctionSearchVO;

@Repository
public class SanctionRepoImpl implements SanctionRepo{

    @Autowired
    private SqlSession sqlSession;

    // 제재 생성
    @Override
    public void insert(SanctionDto sanctionDto) {
        sqlSession.insert("sanction.insert", sanctionDto);
    }

    // 제재 
    @Override
    public List<SanctionDto> selectListComplex(SanctionSearchVO sanctionSearchVO) {
        return sqlSession.selectList("sanction.selectListComplex", sanctionSearchVO);
    }
    
}
