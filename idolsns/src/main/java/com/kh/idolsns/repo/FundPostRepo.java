package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.FundPostDto;
import com.kh.idolsns.dto.PostImageDto;

public interface FundPostRepo {
	
	void insert(FundPostDto dto);
	List<FundPostDto> selectList();
	FundPostDto selectOne(Long postNo);
	boolean update(FundPostDto dto);
	void connect(PostImageDto postImageDto);
	boolean sponsorCount(FundPostDto fundPostDto);
	void updateFundState();

	FundPostDto find(Long postNo);
}
