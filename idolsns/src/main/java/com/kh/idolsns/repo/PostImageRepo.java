package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.PostImageDto;

public interface PostImageRepo {

	void insert(PostImageDto postImageDto);
	List<PostImageDto> selectList(Long postNo);
    List<String> selectAttachNoList(Long postNo);
    void deleteByPostNo(Long postNo);
}
