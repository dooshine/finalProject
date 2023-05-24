package com.kh.idolsns.dto;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class FundPostImageDto {
	private Long postNo;
	private String memberId;
	private String fundTitle;
	private String fundShortTitle;
	private Date postStart;
	private Date postEnd;
	private Date postTime;
	private int fundGoal;
	private int fundSponsorCount;
	private String fundState;
	private String postType;
	private String postContent;
	private Integer attachmentNo; // 없는 경우 null이 나오도록 처리
	
	
	//이미지의 URL을 반환하는 메소드
	public String getImageURL() {
		if(attachmentNo == null) return "https://via.placeholder.com/150x150";
		else return "/download?attachmentNo="+attachmentNo;
	}
}
