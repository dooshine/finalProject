package com.kh.idolsns.repo;

import com.kh.idolsns.dto.MemberDto;

public interface MemberRepo {
	void insert(MemberDto memberDto);
	MemberDto selectOne(String memberId);
	MemberDto findId(String memberEmail);
	boolean delete(String memberId);
	boolean updatePw(String memberId, String memberPw);
	boolean updateNick(String memberId, String memberNick);
}
