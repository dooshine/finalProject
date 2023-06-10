package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.FollowDto;
import com.kh.idolsns.dto.MemberDto;


public interface MemberRepo {
	void insert(MemberDto memberDto);
	MemberDto selectOne(String memberId);

	
	
	//포인트 충전 
	void chargePoint(String memberId, int paymentTotal);
	
	//포인트 차감 (충전 취소)
	void decreasePoint(String memberId, int paymentTotal);
	
	//포인트 차감 (펀딩 시)
	void minusPoint(String memberId, int fundPrice);
	
	//포인트 돌려받음 (펀딩 취소 시)
	void plusPoint(String memberId, int fundPrice);
	
	
	

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
	boolean cancleExit(String memberId);
	void clean();
	void memberExit(String memberId);
	int memberExitFind(String memberId);
	//팔로우 리스트 멤버별 프로필 조회
	List<FollowDto> followListProfile(String memberId);
	//팔로워 리스트 멤버별 프로필 조회
	List<FollowDto> followerListProfile(String followTargetPrimaryKey);
	//팔로워 리스트 멤버별 프로필 조회
	List<FollowDto> pageListProfile(String memberId);
	//팔로우 취소
	boolean deleteFollow(long followNo);
	
	//중복 검사
	int idDuplicatedCheck(String memberId);
	int nickDuplicatedCheck(String memberNick);
	int emailDuplicatedCheck(String memberEmail);
	
	
	
	
	
	// (채팅) 회원 아이디 리스트로 상세조회
	List<MemberDto> chatMembers(List<String> memberIdList);

}
