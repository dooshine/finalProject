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
	private Date fundTime;
	private String memberId;
	private String fundTitle;
}
