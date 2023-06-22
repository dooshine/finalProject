package com.kh.idolsns.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.FreePostDto;

@Repository
public class FreePostRepoImpl implements FreePostRepo {

	@Autowired
	private SqlSession sqlSession; 
	
	@Override
	public void insert(FreePostDto freePostDto) {
		sqlSession.insert("freePost.insert",freePostDto); 		
	}

	@Override
	public FreePostDto selectOne(Long postNo) {
		return sqlSession.selectOne("freePost.selectOne",postNo);
		
	}

	@Override
	public void delete(Long postNo) {
		sqlSession.delete("freePost.delete",postNo);		
	}

}
