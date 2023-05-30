package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.FundDto;

public interface FundRepo {
	Long sequence();
	void insert(FundDto dto);
	
	void fundCancel(long fundNo); //후원 취소
	void fundCancel2(long fundNo); // 금액 되돌리기
	
	List<FundDto> selectAll();
	List<FundDto> selectByMember(String memberId);
	List<FundDto> selectByPostNo(Long postNo);
	Integer selectTotal(Long postNo);
	FundDto find(Long fundNo);

	
}
