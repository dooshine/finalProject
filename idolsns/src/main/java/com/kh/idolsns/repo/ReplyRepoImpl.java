package com.kh.idolsns.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.ReplyDto;

@Repository
public class ReplyRepoImpl implements ReplyRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void addReply(ReplyDto replyDto) {
		sqlSession.insert("reply.add", replyDto);
	}

	@Override
	public Long sequence() {
		return sqlSession.selectOne("reply.sequence");
	}

}
