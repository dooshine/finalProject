package com.kh.idolsns.repo;

import com.kh.idolsns.dto.MemberProfileImageDto;

public interface MemberProfileImageRepo {

	void insert(MemberProfileImageDto memberProfileImageDto);
	MemberProfileImageDto MemberImageExist(String memberId);
}
