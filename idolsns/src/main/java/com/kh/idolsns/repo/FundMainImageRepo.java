package com.kh.idolsns.repo;

import com.kh.idolsns.dto.FundMainImageDto;

public interface FundMainImageRepo {
	void insert(FundMainImageDto fundMainImageDto);
	FundMainImageDto selectOne(Long postNo);
}
