package com.kh.idolsns.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.SanctionDto;

@Repository
public class SanctionRepoImpl implements SanctionRepo{

    @Autowired
    private SqlSession sqlSession;

    // 제재 생성
    public void insert(SanctionDto sanctionDto) {
        sqlSession.insert("sanction.insert", sanctionDto);
    }
    
}
