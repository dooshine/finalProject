package com.kh.idolsns.vo;

import lombok.Data;

//결제 승인 요청을 위한 데이터
@Data
public class KakaoPayApproveRequestVO {
	private String tid; //거래번호
	private String partner_order_id; //주문번호
	private String partner_user_id; //주문자
	private String pg_token; //인증토큰(반쪽짜리 팬던트)
}

