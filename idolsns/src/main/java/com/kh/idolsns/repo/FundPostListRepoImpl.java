package com.kh.idolsns.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.FundPostListDto;
import com.kh.idolsns.dto.PostImageDto;
import com.kh.idolsns.vo.FundDetailVO;

@Repository
public class FundPostListRepoImpl implements FundPostListRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<PostImageDto> selectAttachList(Long postNo) {
		return sqlSession.selectList("fundpostlist.attachByPostNo", postNo);
	}

	@Override
	public FundPostListDto selectOne(Long postNo) {
		return sqlSession.selectOne("fundpostlist.fundByPostNo", postNo);
	}

	@Override
	public List<FundPostListDto> selectList() {
		return sqlSession.selectList("fundpostlist.list");
	}
	

}
