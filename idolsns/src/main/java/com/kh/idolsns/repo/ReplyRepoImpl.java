package com.kh.idolsns.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	@Override
	public List<ReplyDto> getRepliesByPostNo(Long postNo) {
		return sqlSession.selectList("reply.list", postNo);
	}

	@Override
	public ReplyDto selectOne(Long replyNo) {
		return sqlSession.selectOne("reply.selectOne", replyNo);
	}

	@Override
	public boolean deleteReplies(Long groupNo) {
		return sqlSession.delete("reply.deleteReplies", groupNo) > 0;
	}

	@Override
	public boolean deleteRereply(Long replyNo) {
		return sqlSession.delete("reply.deleteRereply", replyNo) > 0;
	}

	@Override
	public boolean updateReply(Long replyNo, String replyContent) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("replyNo", replyNo);
		paramMap.put("replyContent", replyContent);
		return sqlSession.update("reply.updateReply", paramMap) > 0;
	}

}
