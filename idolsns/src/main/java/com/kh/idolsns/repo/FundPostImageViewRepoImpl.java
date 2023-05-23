package com.kh.idolsns.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.FundPostImageViewDto;

@Repository
public class FundPostImageViewRepoImpl implements FundPostImageViewRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public FundPostImageViewDto selectOne(Long postNo) {
		return sqlSession.selectOne("fundPostImageView.selectOne", postNo);
	}

}
