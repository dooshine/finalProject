package com.kh.idolsns.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class FundDto {
	
	private Long fundNo;
	private Long postNo;
	private int fundPrice;
	private String fundId;
	private Date fundTime;
}
