package com.kh.idolsns.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.TagCntDto;
import com.kh.idolsns.dto.TagDto;

@Repository
public class AdminRepoImpl implements AdminRepo {

    @Autowired
    private SqlSession sqlSession;

    // [admin] 전체 tag 불러오기
    @Override
    public List<TagDto> adminTagSelectList() {
        return sqlSession.selectList("adminTag.selectAll");
    }

    @Override
    public boolean adminTagDelete(Long tagNo) {
        return sqlSession.delete("tag", tagNo) > 0;
    }

    @Override
    public List<TagCntDto> adminTagCntSelectList() {
        return sqlSession.selectList("tagCnt.selectList");
    }
    
}
