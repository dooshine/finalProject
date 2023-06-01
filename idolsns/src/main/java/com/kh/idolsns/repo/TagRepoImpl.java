package com.kh.idolsns.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.TagDto;

@Repository
public class TagRepoImpl implements TagRepo{

	@Autowired
	private SqlSession sqlSession; 
	
	@Override
	public Long sequence() {
		return sqlSession.selectOne("tag.sequence");
	}

	@Override
	public void insert(TagDto tagDto) {
		sqlSession.insert("tag.insert",tagDto); 
	}

	@Override
	public boolean delete(Long tagNo) {
		return sqlSession.delete("tag.delete",tagNo) > 0 ; 
	}

	@Override
	public Long selectOne(String tagName) {
		return sqlSession.selectOne("tag.selectOne",tagName); 
	}

	@Override
	public List<String> selectAll(Long postNo) {		
		return sqlSession.selectList("tag.selectAll",postNo);
	}

	@Override
	public void deleteByPostNo(Long postNo) {
		sqlSession.delete("tag.deleteByPostNo",postNo);
	}

	@Override
	public List<String> selectFixedTagAll(Long postNo) {		
		return sqlSession.selectList("tag.selectFixedTagAll",postNo);
	}

	@Override
	public List<String> selectFreeTagAll(Long postNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("tag.selectFreeTagAll",postNo);
	}

}
