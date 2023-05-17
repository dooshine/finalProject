package com.kh.idolsns.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.FundDto;

@Repository
public class FundRepoImpl implements FundRepo{

	
	
	@Autowired
	private SqlSession sqlSession;
	
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("fund.sequence");
	}

	

	@Override
	public void insert(FundDto dto) {
			sqlSession.insert("fund.add", dto);
		}

	
	@Override
	public List<FundDto> selectAll() {
		return sqlSession.selectList("fund.selectAll");
	}

	@Override
	public List<FundDto> selectByMember(String memberId) {
		return sqlSession.selectList("fund.selectByMember", memberId);
	}
	
	@Override
	public FundDto find(int fundNo) {
		return sqlSession.selectOne("fund.find", fundNo);
	}


		

	
}
