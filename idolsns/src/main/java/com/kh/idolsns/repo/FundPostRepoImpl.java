package com.kh.idolsns.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.FundPostDto;

@Repository
public class FundPostRepoImpl implements FundPostRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(FundPostDto dto) {
		sqlSession.insert("fundPost.add", dto);
	}

	@Override
	public List<FundPostDto> selectList() {
		return sqlSession.selectList("fundPost.selectList");
	}

	@Override
	public FundPostDto selectOne(int postNo) {
		return sqlSession.selectOne("fundPost.selectOne", postNo);
	}

	@Override
	public boolean update(FundPostDto dto) {
		return sqlSession.update("fundPost.edit", dto) > 0;
	}

}
