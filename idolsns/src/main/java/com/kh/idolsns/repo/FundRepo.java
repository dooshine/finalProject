package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.FundDto;

public interface FundRepo {
	Long sequence();
	void insert(FundDto dto);
	List<FundDto> selectAll();
	List<FundDto> selectByMember(String memberId);
	FundDto selectOneWithTotal(Long postNo);
	FundDto find(Long fundNo);
	
}
