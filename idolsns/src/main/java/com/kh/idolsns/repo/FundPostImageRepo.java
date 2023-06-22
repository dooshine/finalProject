package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.FundDto;
import com.kh.idolsns.dto.FundListWithTagDto;
import com.kh.idolsns.dto.FundPostImageDto;
import com.kh.idolsns.dto.FundWithNickDto;
import com.kh.idolsns.dto.PostImageDto;
import com.kh.idolsns.dto.TagDto;
import com.kh.idolsns.vo.FundDetailVO;
import com.kh.idolsns.vo.FundSearchVO;

public interface FundPostImageRepo {

	public List<PostImageDto> selectAttachList(Long postNo);
	public FundDetailVO selectOne(Long postNo);
	public List<FundPostImageDto> selectList();
	public List<FundDto> selectFundList(Long postNo);
	public List<TagDto> selectTagList(Long postNo);
	
	
	public List<FundPostImageDto> selectListByPaging(int page);
	public List<FundPostImageDto> selectListByPaging(int page, String searchKeyword);
	public List<FundListWithTagDto> selectListWithTag(int page, FundSearchVO vo);
	public List<FundWithNickDto> selectFundWithNickList(Long postNo);
}
