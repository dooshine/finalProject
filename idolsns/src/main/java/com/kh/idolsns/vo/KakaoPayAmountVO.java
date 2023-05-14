package com.kh.idolsns.vo;

import lombok.Data;

@Data
public class KakaoPayAmountVO {

	private int total; //총금액
	private int tax_free; //비과세
	private int vat; //부가세
	private int point; //포인트 사용금액
	private int discount; //할인금액
	private int green_deposit; //환경보증금
	
	
	
	
	
	
	
}
