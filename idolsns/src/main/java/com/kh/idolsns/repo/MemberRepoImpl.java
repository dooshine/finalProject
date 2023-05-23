package com.kh.idolsns.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public void insert(MemberDto memberDto) {
		sqlSession.insert("member.memberjoin", memberDto);
	}
	
	@Override
	public MemberDto selectOne(String memberId) {
		return sqlSession.selectOne("member.selectOne", memberId);
	}
	
	
	
	
	//포인트 충전
	@Override
	public void chargePoint(String memberId, int paymentTotal) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
	    params.put("paymentTotal", paymentTotal);
	    
	    sqlSession.update("member.chargePoint", params);
	}
	
	
	// 충전 취소 시 포인트 차감
	@Override
	public void decreasePoint(String memberId, int paymentTotal) {
		Map<String, Object> params = new HashMap<>();
	    params.put("memberId", memberId);
	    params.put("paymentTotal", paymentTotal);
	    
	    sqlSession.update("member.decreasePoint", params);
	}
	
	
	//펀딩 시 포인트 차감
	@Override
	public void minusPoint(String memberId, int fundPrice) {
		Map<String, Object> params = new HashMap<>();
	    params.put("memberId", memberId);
	    params.put("fundPrice", fundPrice);
	    
	    sqlSession.update("member.minusPoint", params);
		
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

	@Override
	public List<MemberDto> selectAll() {
		return sqlSession.selectList("member.selectAll");
	}

	@Override
	public MemberDto joinNick(String memberNick) {
		return sqlSession.selectOne("member.joinNick", memberNick);
	}

	@Override
	public MemberDto joinEmail(String memberEmail) {
		return sqlSession.selectOne("member.joinEmail", memberEmail);
	}

	// 관리자 회원목록 조회
	@Override
	public List<MemberDto> adminSelectList(AdminMemberSearchVO adminMemberSearchVO) {
		return sqlSession.selectList("member.selectList", adminMemberSearchVO);
	}

	//중복 검사
	@Override
	public int idDuplicatedCheck(String memberId) {
		return sqlSession.selectOne("member.idDuplicatedCheck", memberId);
	}

	@Override
	public int nickDuplicatedCheck(String memberNick) {
		return sqlSession.selectOne("member.nickDuplicatedCheck", memberNick);
	}

	@Override
	public int emailDuplicatedCheck(String memberEmail) {
		return sqlSession.selectOne("member.emailDuplicatedCheck", memberEmail);
	}

	//비밀번호 찾기_이메일 조회
	@Override
	public MemberDto emailExist(String memberId) {
		return sqlSession.selectOne("member.emailExist", memberId);
	}

	
	
	
	// (채팅)
	@Override
	public List<MemberDto> chatMembers(List<String> memberIdList) {
		return sqlSession.selectList("member.chatMembers", memberIdList);
	}
	
}
