package com.kh.idolsns.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class FundPostImageViewDto {

	private Long postNo;
	private Long fundNo;
	private String memberId;
	private String fundTitle;
	private Date postStart;
	private Date postEnd;
	private Date fundTime;
	private Date postTime;
	private int fundGoal;
	private int fundSponsorCount;
	private String fundState;
	private int fundPrice;
	private int attachmentNo;
	private String postType;
	private String postContent;
}
