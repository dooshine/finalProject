package com.kh.idolsns.repo;

import com.kh.idolsns.dto.MemberDto;

public interface MemberRepo {
	MemberDto selectOne(String memberId);
	
	
	//포인트 충전 
	void chargePoint(String memberId, int memberPoint);
	
	//포인트 차감 (충전 취소)
	void decreasePoint(String memberId, int memberPoint);
	
	
	
}
