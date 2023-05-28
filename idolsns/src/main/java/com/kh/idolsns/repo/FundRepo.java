package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.FundDto;

public interface FundRepo {
	Long sequence();
	void insert(FundDto dto);
	
	void fundCancel(long fundNo); //후원 취소
	
	
	List<FundDto> selectAll();
	List<FundDto> selectByMember(String memberId);
	List<FundDto> selectByPostNo(Long postNo);
	Integer selectTotal(Long postNo);
	FundDto find(Long fundNo);
	int count(Long postNo);
	
}
