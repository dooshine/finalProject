package com.kh.idolsns.repo;

import com.kh.idolsns.dto.MemberDto;

public interface MemberRepo {
	MemberDto selectOne(String memberId);
}
