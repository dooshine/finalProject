package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.vo.AdminMemberSearchVO;


public interface MemberRepo {
	void insert(MemberDto memberDto);
	MemberDto selectOne(String memberId);

	
	
	//포인트 충전 
	void chargePoint(String memberId, int paymentTotal);
	
	//포인트 차감 (충전 취소)
	void decreasePoint(String memberId, int paymentTotal);
	
	
	//포인트 차감 (펀딩 시)
	void minusPoint(String memberId, int fundPrice);
	

	boolean delete(String memberId);
	boolean updatePw(String memberId, String memberPw);
	boolean updateNick(String memberId, String memberNick);
	MemberDto findId(String memberEmail);
	List<MemberDto> selectAll();
	MemberDto joinNick(String memberNick);
	MemberDto joinEmail(String memberEmail);
	MemberDto emailExist(String memberId);
	boolean editPassword(String memberEmail, String memberPw);
	boolean deleteMemberProc(String memberId);
	boolean exitDate(String memberId);
	
	//중복 검사
	int idDuplicatedCheck(String memberId);
	int nickDuplicatedCheck(String memberNick);
	int emailDuplicatedCheck(String memberEmail);
	
	// 관리자 회원목록 조회
	List<MemberDto> adminSelectList(AdminMemberSearchVO adminMemberSearchVO);
	
	
	
	// (채팅) 회원 아이디 리스트로 상세조회
	List<MemberDto> chatMembers(List<String> memberIdList);

}
