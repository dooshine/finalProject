package com.kh.idolsns.repo;

import javax.servlet.http.HttpSession;

import com.kh.idolsns.dto.PostDto;

public interface PostRepo {
    // 통합게시물 시퀀스 발행
    Long sequence();
    // 통합게시물 게시물 등록
    void insert(PostDto postDto);
    // 통합게시물 업데이트
    boolean update(PostDto postDto);
    // 통합게시물 삭제
    boolean delete(Long postNo);
}
