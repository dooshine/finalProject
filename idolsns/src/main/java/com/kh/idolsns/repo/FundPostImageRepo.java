package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.FundDto;
import com.kh.idolsns.dto.FundPostImageDto;
import com.kh.idolsns.dto.PostImageDto;
import com.kh.idolsns.vo.FundDetailVO;

public interface FundPostImageRepo {
	List<PostImageDto> selectAttachList(Long postNo);
	FundDetailVO selectOne(Long postNo);
	List<FundPostImageDto> selectList();
	List<FundDto> selectFundList(Long postNo);
	
	List<FundPostImageDto> selectListByPaging(int page);
}
