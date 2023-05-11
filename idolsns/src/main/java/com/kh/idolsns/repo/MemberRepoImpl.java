package com.kh.idolsns.repo;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.MemberDto;

@Repository
public class MemberRepoImpl implements MemberRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(MemberDto memberDto) {
		sqlSession.insert("member.memberjoin", memberDto);
	}
	
	@Override
	public MemberDto selectOne(String memberId) {
		return sqlSession.selectOne("member.selectOne", memberId);
	}

	@Override
	public boolean delete(String memberId) {
		return sqlSession.delete("member.delete", memberId) > 0;
	}

	@Override
	public boolean updatePw(String memberId, String memberPw) {
		Map<String, Object> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("memberPw", memberPw);
		return sqlSession.update("member.password", param) > 0;
	}

	@Override
	public boolean updateNick(String memberId, String memberNick) {
		Map<String, Object> param = new HashMap<>();
		param.put("memberId", memberId);
		param.put("memberNick", memberNick);
		return sqlSession.update("member.nickname", param) > 0;
	}

	@Override
	public MemberDto findId(String memberEmail) {
		return sqlSession.selectOne("member.findId", memberEmail);
	}

}
