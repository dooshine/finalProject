package com.kh.idolsns.repo;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.PostDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class PostRepoImpl implements PostRepo{

    @Autowired
    private SqlSession sqlSession;

    // 통합게시물 시퀀스 발행
    @Override
    public Long sequence() {
        return sqlSession.selectOne("post.sequence");
    }

    // 통합게시물 등록
    @Override
    public void insert(PostDto postDto) {
        // 1. 작성자 아이디 추출
        sqlSession.insert("post.insert", postDto);
    }

    // 통합게시물 수정
    @Override
    public boolean update(PostDto postDto) {
        return sqlSession.update("post.update", postDto) > 0;
    }

    // 통합게시물 삭제
    @Override
    public boolean delete(Long postNo) {
        return sqlSession.delete("post.delete", postNo) > 0;
    }
}
