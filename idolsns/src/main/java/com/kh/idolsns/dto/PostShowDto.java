package com.kh.idolsns.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class PostShowDto {

	private long postNo;
	private String memberId;
	private Date postTime;
	private String postType;
	private String postContent;
	private long tagNo; 
	private String tagType;
	private String tagName;
	private String mapPlace;
	private String fundTitle;

}