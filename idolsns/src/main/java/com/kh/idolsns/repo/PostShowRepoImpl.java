package com.kh.idolsns.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.vo.PostShowVO;

@Repository
public class PostShowRepoImpl implements PostShowRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public PostShowVO selectOne(Long postNo) {
		return sqlSession.selectOne("postShow.selectOne",postNo); 
	}

}
