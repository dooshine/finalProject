package com.kh.idolsns.repo;

import java.util.List;

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
    // 모든 리스트 불러오기
    List<PostDto> selectList();
    // 하나의 게시물 불러오기
    PostDto selectOne(Long postNo);
}
