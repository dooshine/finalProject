package com.kh.idolsns.repo;

import com.kh.idolsns.dto.PostLikeDto;

public interface PostLikeRepo {
	void insert(PostLikeDto postLikeDto);
	void delete(PostLikeDto postLikeDto); 
	Long count(Long postNo); 
	Boolean check(PostLikeDto postLikeDto);
	void deleteByPostNo(Long postNo);
}
