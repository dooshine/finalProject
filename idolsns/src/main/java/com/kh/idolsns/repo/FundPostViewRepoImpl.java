package com.kh.idolsns.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.FundPostViewDto;

@Repository
public class FundPostViewRepoImpl implements FundPostViewRepo{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<FundPostViewDto> selectList() {
		return sqlSession.selectList("fundPostView.selectList");
	}

	@Override
	public FundPostViewDto selectOne(Long postNo) {
		return sqlSession.selectOne("fundPostView.detail", postNo);
	}
	

}
