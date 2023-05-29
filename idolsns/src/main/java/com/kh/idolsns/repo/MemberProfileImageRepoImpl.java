package com.kh.idolsns.repo;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.MemberProfileImageDto;

@Repository
public class MemberProfileImageRepoImpl implements MemberProfileImageRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(MemberProfileImageDto memberProfileImageDto) {
		sqlSession.insert("memberProfileImage.add", memberProfileImageDto);
	}

	@Override
	public MemberProfileImageDto MemberImageExist(String memberId) {
		return sqlSession.selectOne("memberProfileImage.memberImageExist", memberId);
	}


}
