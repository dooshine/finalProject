package com.kh.idolsns.repo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.PaymentDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class PaymentRepoImpl implements PaymentRepo {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("payment.sequence");
	}
	
	@Override
	public void save(PaymentDto dto) {
		sqlSession.insert("payment.save", dto);
	}
	

	@Override
	public List<PaymentDto> selectAll() {
		return sqlSession.selectList("payment.selectAll");
	}

	@Override
	public List<PaymentDto> selectByMember(String memberId) {
		return sqlSession.selectList("payment.selectByMember", memberId);
	}
	
	@Override
	public PaymentDto find(int paymentNo) {
		return sqlSession.selectOne("payment.find", paymentNo);
	}
	

	//전체취소
	@Override
	public void cancelRemain(int paymentNo) {
		sqlSession.update("payment.cancelRemain", paymentNo);
		
	}

	
	
	
	
	@Override
	public void chargePoint(String memberId, int memberPoint) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
	    params.put("memberPoint", memberPoint);
	    
	    sqlSession.update("payment.chargePoint", params);
	}
	
	
	// 충전 취소 시 포인트 차감
	@Override
	public void decreasePoint(String memberId, int memberPoint) {
		Map<String, Object> params = new HashMap<>();
	    params.put("memberId", memberId);
	    params.put("memberPoint", memberPoint);
	    sqlSession.update("payment.decreasePoint", params);
	}

	
	

	
}