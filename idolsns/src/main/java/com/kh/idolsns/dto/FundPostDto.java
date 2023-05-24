package com.kh.idolsns.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class FundPostDto {
	
	private Long postNo;
	private String memberId;
	private String fundTitle;
	private String fundShortTitle;
	private Date postStart;
	private Date postEnd;
	private int fundGoal;
	private int fundSponsorCount;
	private String fundState;

}
