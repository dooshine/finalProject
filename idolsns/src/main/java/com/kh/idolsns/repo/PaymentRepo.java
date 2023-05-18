package com.kh.idolsns.repo;

import java.util.List;

import com.kh.idolsns.dto.PaymentDto;

public interface PaymentRepo {
	int sequence();
	void save(PaymentDto dto);
	List<PaymentDto> selectAll();
	List<PaymentDto> selectByMember(String memberId);
	PaymentDto find(int paymentNo);
	PaymentDto find2(String paymentTid);
	
	
	void cancelRemain(int paymentNo); //전체 취소
	

}
