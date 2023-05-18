package com.kh.idolsns.repo;

import com.kh.idolsns.dto.FreePostDto;

public interface FreePostRepo {
	public void insert(FreePostDto freePostDto);
	public FreePostDto selectOne(Long postNo);
	public void delete(Long postNo);
}
