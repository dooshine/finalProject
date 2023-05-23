package com.kh.idolsns.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.MapDto;

@Repository
public class MapRepoImpl implements MapRepo {

	@Autowired
	private SqlSession sqlSession; 
	
	@Override
	public void insert(MapDto mapDto) {
		// TODO Auto-generated method stub
		sqlSession.insert("map.insert",mapDto); 
	}

	@Override
	public MapDto selectOne(Long postNo) {
		// TODO Auto-generated method stub
		sqlSession.selectOne("map.select",postNo); 
		return null;
	}

	@Override
	public void delete(Long postNo) {
		// TODO Auto-generated method stub
		sqlSession.delete("map.delete",postNo); 
	}

}
