package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.FundPostViewDto;

public interface FundPostViewRepo {
	List<FundPostViewDto> selectList();

	FundPostViewDto selectOne(Long postNo);
}
