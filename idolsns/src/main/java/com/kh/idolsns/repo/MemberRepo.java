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
	
	

	boolean delete(String memberId);
	boolean updatePw(String memberId, String memberPw);
	boolean updateNick(String memberId, String memberNick);
	MemberDto findId(String memberEmail);
	List<MemberDto> selectAll();
	MemberDto joinNick(String memberNick);
	MemberDto joinEmail(String memberEmail);
	// 관리자 회원목록 조회
	List<MemberDto> adminSelectList(AdminMemberSearchVO adminMemberSearchVO);

}
