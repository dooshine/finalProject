package com.kh.idolsns.vo;

import lombok.Data;

@Data
public class KakaoPayCardInfoVO {
	private String purchase_corp, purchasr_corp_code; //매입 카드사 정보
	private String issuer_corp, issuer_corp_code; //카드 발급사 정보
	private String kakaopay_purchase_corp, kakaopay_purchase_corp_code;
	private String kakaopay_issuer_corp, kakaopay_issuer_corp_code;
	private String bin;
	private String card_type;
	private String install_month;
	private String approved_id;
	private String card_mid;
	private String interest_free_install;
	private String card_item_code;
	
}
