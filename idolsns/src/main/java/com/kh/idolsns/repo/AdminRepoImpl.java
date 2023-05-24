package com.kh.idolsns.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.TagCntDto;
import com.kh.idolsns.dto.TagDto;
import com.kh.idolsns.vo.TagCntSearchVO;

@Repository
public class AdminRepoImpl implements AdminRepo {

    @Autowired
    private SqlSession sqlSession;

    // [admin] 전체 tag 불러오기
    @Override
    public List<TagDto> adminTagSelectList() {
        return sqlSession.selectList("admin.tagSelectList");
    }


    // 태그 수정
    @Override
    public boolean updateTagTypeByName(TagDto tagDto) {
        return sqlSession.update("admin.updateTagType", tagDto) > 0;
    }

    @Override
    public boolean adminTagDelete(String tagName) {
        return sqlSession.delete("admin.deleteByTagName", tagName) > 0;
    }

    @Override
    public List<TagCntDto> adminTagCntSelectList(TagCntSearchVO tagCntSearchVO) {
        return sqlSession.selectList("admin.tagCntSelectList", tagCntSearchVO);
    }
    
}
