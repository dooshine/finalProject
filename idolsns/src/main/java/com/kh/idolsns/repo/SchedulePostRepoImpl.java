package com.kh.idolsns.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.SchedulePostDto;

@Repository
public class SchedulePostRepoImpl implements SchedulePostRepo{

	@Autowired
	private SqlSession sqlSession; 
	
	@Override
	public void insert(SchedulePostDto scheduleDto) {
		sqlSession.insert("schedulePost.insert",scheduleDto); 
	}

	@Override
	public SchedulePostDto selectOne(Long postNo) {
		return sqlSession.selectOne("schedulePost.selectOne",postNo);
	}

	@Override
	public void delete(Long postNo) {
		sqlSession.delete("schedulePost.delete", postNo); 
	}

}
