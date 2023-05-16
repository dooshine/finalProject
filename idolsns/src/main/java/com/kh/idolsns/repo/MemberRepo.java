package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.vo.AdminMemberSearchVO;

public interface MemberRepo {
	void insert(MemberDto memberDto);
	MemberDto selectOne(String memberId);
	boolean delete(String memberId);
	boolean updatePw(String memberId, String memberPw);
	boolean updateNick(String memberId, String memberNick);
	MemberDto findId(String memberEmail);
	List<MemberDto> selectAll();
	MemberDto joinNick(String memberNick);
	MemberDto joinEmail(String memberEmail);
	
	//중복 검사
	int idDuplicatedCheck(String memberId);
	int nickDuplicatedCheck(String memberNick);
	int emailDuplicatedCheck(String memberEmail);
	
	// 관리자 회원목록 조회
	List<MemberDto> adminSelectList(AdminMemberSearchVO adminMemberSearchVO);
}
