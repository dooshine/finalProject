package com.kh.idolsns.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class FundPostDto {
	
	private int postNo;
	private String memberId;
	private String fundTitle;
	private Date postStart;
	private Date postEnd;
	private int fundGoal;
	private int fundSponsorCount;
	private String fundState;

}
