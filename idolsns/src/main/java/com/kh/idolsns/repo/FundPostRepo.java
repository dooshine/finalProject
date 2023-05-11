package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.FundPostDto;

public interface FundPostRepo {
	
	void insert(FundPostDto dto);
	List<FundPostDto> selectList();
	FundPostDto selectOne(Long postNo);
	boolean update(FundPostDto dto);

}
