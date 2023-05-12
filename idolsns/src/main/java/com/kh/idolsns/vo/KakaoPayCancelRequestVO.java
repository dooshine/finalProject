package com.kh.idolsns.vo;

import lombok.Data;

@Data
public class KakaoPayCancelRequestVO {
	private String tid; //거래번호
	private int cancel_amount; //취소금액
	private int cancel_tax_free_amount = 0; //최소 비과세 금액(0으로 설정)


}
