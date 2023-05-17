package com.kh.idolsns.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.FundDto;

@Repository
public class FundRepoImpl implements FundRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(FundDto fundDto) {
		sqlSession.insert("fund.add", fundDto);
	}

	@Override
	public Long sequence() {
		return sqlSession.selectOne("fund.sequence");
	}

}
