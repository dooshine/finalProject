package com.kh.idolsns.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class FundPostViewDto {
	
	private Long postNo;
	private String memberId;
	private String postType;
	private Date postTime;
	private String postContent;
	private String fundTitle;
	private Date postStart;
	private Date postEnd;
	private int fundGoal;
	private int fundSponsorCount;
	private String fundState;

}
