package com.kh.idolsns.vo;

import java.sql.Date;

import lombok.Data;

//카카오페이 요청 결과를 저장하기 위한 클래스
@Data
public class KakaoPayReadyResponseVO {

	private String tid;
	private String next_redirect_pc_url;
	private Date created_at;
	
	
}
