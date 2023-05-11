package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.PostWithNickDto;
import com.kh.idolsns.vo.SearchVO;

public interface PostWithNickRepo {
    // 통합게시물+닉네임 상세조회
    PostWithNickDto selectOne(Long postNo);
    // 통합게시물+닉네임 목록조회
    List<PostWithNickDto> selectList(SearchVO searchVO);
}
