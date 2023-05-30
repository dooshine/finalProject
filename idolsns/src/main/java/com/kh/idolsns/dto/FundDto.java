package com.kh.idolsns.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class FundDto {
	
	private Long fundNo;
	private Long postNo;
	private int fundPrice;
	private int fundRemain;
	private Date fundTime;
	private String memberId;
	private String fundTitle;
	
	
	//펀딩 상태
	public String getFundStatus() {
		if(fundPrice == fundRemain) {
			return "참여 중";
		}
		else {
			return "펀딩 취소";
		}
		
	}
	
		
}
