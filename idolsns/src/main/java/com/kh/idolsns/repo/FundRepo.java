package com.kh.idolsns.repo;

import com.kh.idolsns.dto.FundDto;

public interface FundRepo {
	void insert(FundDto fundDto);
	Long sequence();
}
