package com.kh.idolsns.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.idolsns.dto.FixedTagDto;

@Service
public class FixedTagService {
    
    @Autowired
    private SqlSession sqlSession;

    public boolean isFixedTag(String fixedTagName){
        FixedTagDto dto = sqlSession.selectOne("fixedTag.selectFixedTagByName", fixedTagName);
        return dto != null;
    }
}
