package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.FundPostDto;
import com.kh.idolsns.dto.PostImageDto;

public interface FundPostRepo {
	
	public void insert(FundPostDto dto);
	public List<FundPostDto> selectList();
	public FundPostDto selectOne(Long postNo);
	public boolean update(FundPostDto dto);
	public void connect(PostImageDto postImageDto);
	public boolean sponsorCount(FundPostDto fundPostDto);
	public void updateFundState();

	public FundPostDto find(Long postNo);
}
