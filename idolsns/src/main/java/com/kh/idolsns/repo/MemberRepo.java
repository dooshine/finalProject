package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.MemberDto;

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
}
