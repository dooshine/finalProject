package com.kh.idolsns.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.FundMainImageDto;

@Repository
public class FundMainImageRepoImpl implements FundMainImageRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(FundMainImageDto fundMainImageDto) {
		sqlSession.insert("fundMainImage.add", fundMainImageDto);
	}

	@Override
	public FundMainImageDto selectOne(Long postNo) {
		return sqlSession.selectOne("fundMainImage.detail", postNo);
	}
	
	

}
