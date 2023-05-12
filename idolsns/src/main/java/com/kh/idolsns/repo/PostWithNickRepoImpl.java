package com.kh.idolsns.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.PostWithNickDto;
import com.kh.idolsns.vo.SearchVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class PostWithNickRepoImpl implements PostWithNickRepo{
    
    @Autowired
    private SqlSession sqlSession;

    // 통합게시물+닉네임 상세조회
    @Override
    public PostWithNickDto selectOne(Long postNo) {
        return sqlSession.selectOne("postWithNick.selectOne", postNo);
    }
    // 통합게시물+닉네임 목록조회
    @Override
    public List<PostWithNickDto> selectList(SearchVO searchVO) {
        return sqlSession.selectList("postWithNick.selectList", searchVO);
    }
}
