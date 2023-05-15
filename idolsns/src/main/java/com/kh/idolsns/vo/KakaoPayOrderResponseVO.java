package com.kh.idolsns.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class KakaoPayOrderResponseVO {
	private String tid; //거래번호
	private String cid; //가맹점번호
	private String status; //결제 상태
	private String partner_order_id;
	private String partner_user_id;
	private String payment_method_type; //결제수단(card/money)
	
	private KakaoPayAmountVO amount;
	private KakaoPayAmountVO canceled_amount;
	private KakaoPayAmountVO cancel_available_amount;
	
	private String item_name;
	private String item_code;
	private int quantity;
	
	private Date created_at;
	private Date approved_at;
	private Date canceled_at;
	

}
