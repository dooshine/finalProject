package com.kh.idolsns.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class KakaoPayApproveResponseVO {

	private String aid;
	private String tid;
	private String cid;
	private String sid;
	private String partner_order_id;
	private String partner_user_id;
	private String payment_method_type;
	
	private KakaoPayAmountVO amount;
	private KakaoPayCardInfoVO card_info;
	
	private String item_name;
	private String item_code;
	
	private int quantity;
	private Date created_at;			
	private Date approved_at;
	private String payload;
	
	
}
