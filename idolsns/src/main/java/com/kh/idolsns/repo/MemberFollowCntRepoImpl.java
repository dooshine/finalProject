package com.kh.idolsns.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.MemberFollowCntDto;

@Repository
public class MemberFollowCntRepoImpl implements MemberFollowCntRepo{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public MemberFollowCntDto followCnt(String memberId) {
		return sqlSession.selectOne("member.followCnt", memberId);
	}

}
