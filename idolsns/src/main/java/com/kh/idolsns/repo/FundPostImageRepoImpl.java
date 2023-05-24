package com.kh.idolsns.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.FundDto;
import com.kh.idolsns.dto.FundPostImageDto;
import com.kh.idolsns.dto.PostImageDto;
import com.kh.idolsns.vo.FundDetailVO;

@Repository
public class FundPostImageRepoImpl implements FundPostImageRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<PostImageDto> selectAttachList(Long postNo) {
		return sqlSession.selectList("fundpostlist.attachByPostNo", postNo);
	}

	@Override
	public FundDetailVO selectOne(Long postNo) {
		return sqlSession.selectOne("fundpostlist.fundPostByPostNo", postNo);
	}

	@Override
	public List<FundPostImageDto> selectList() {
		return sqlSession.selectList("fundpostlist.list");
	}

	@Override
	public List<FundDto> selectFundList(Long postNo) {
		return sqlSession.selectList("fundpostlist.fundByPostNo", postNo);
	}
	

}
