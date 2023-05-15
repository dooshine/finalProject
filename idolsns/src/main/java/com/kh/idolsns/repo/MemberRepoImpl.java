package com.kh.idolsns.repo;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.vo.KakaoPayChargeRequestVO;

@Repository
public class MemberRepoImpl implements MemberRepo{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public MemberDto selectOne(String memberId) {
		return sqlSession.selectOne("member.selectOne", memberId);
	}
	
	
	
	
	//포인트 충전
	@Override
	public void chargePoint(String memberId, int paymentTotal) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
	    params.put("paymentTotal", paymentTotal);
	    
	    sqlSession.update("member.chargePoint", params);
	}
	
	
	// 충전 취소 시 포인트 차감
	@Override
	public void decreasePoint(String memberId, int paymentTotal) {
		Map<String, Object> params = new HashMap<>();
	    params.put("memberId", memberId);
	    params.put("paymentTotal", paymentTotal);
	    sqlSession.update("member.decreasePoint", params);
	}

	
	
	

}
