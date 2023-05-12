package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.vo.AdminMemberSearchVO;

public interface MemberRepo {
	MemberDto selectOne(String memberId);
	// 관리자 회원목록 조회
	List<MemberDto> adminSelectList(AdminMemberSearchVO adminMemberSearchVO);
}
