package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.FundPostListDto;
import com.kh.idolsns.dto.PostImageDto;

public interface FundPostListRepo {
	List<PostImageDto> selectAttachList(Long postNo);
	FundPostListDto selectOne(Long postNo);
	List<FundPostListDto> selectList();
}
