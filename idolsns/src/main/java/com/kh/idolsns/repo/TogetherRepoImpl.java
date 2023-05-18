package com.kh.idolsns.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.TogetherPostDto;

@Repository
public class TogetherRepoImpl implements TogetherPostRepo{

	@Autowired
	private SqlSession sqlSession; 
	
	@Override
	public void insert(TogetherPostDto togetherPostDto) {
		sqlSession.insert("togetherPost.insert",togetherPostDto);		
	}

	@Override
	public TogetherPostDto selectOne(Long postNo) {
		return sqlSession.selectOne("togetherPost.selectOne",postNo);
	}

	@Override
	public void delete(Long postNo) {
		sqlSession.delete("togetherPost.delete",postNo); 
	}

}
