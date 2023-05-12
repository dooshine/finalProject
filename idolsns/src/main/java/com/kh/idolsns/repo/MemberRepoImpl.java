package com.kh.idolsns.repo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.vo.AdminMemberSearchVO;

@Repository
public class MemberRepoImpl implements MemberRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public MemberDto selectOne(String memberId) {
		return sqlSession.selectOne("member.selectOne", memberId);
	}

	// 관리자 회원목록 조회
	@Override
	public List<MemberDto> adminSelectList(AdminMemberSearchVO adminMemberSearchVO) {
		return sqlSession.selectList("member.selectList", adminMemberSearchVO);
	}

}
