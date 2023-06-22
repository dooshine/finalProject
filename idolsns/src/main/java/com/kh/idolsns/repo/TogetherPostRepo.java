package com.kh.idolsns.repo;

import com.kh.idolsns.dto.TogetherPostDto;

public interface TogetherPostRepo {
	public void insert(TogetherPostDto togetherPostDto);
	public TogetherPostDto selectOne(Long postNo);
	public void delete(Long postNo); 
}
