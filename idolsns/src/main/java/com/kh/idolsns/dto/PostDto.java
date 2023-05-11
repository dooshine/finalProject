package com.kh.idolsns.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class PostDto {

	private int postNo;
	private String memberId;
	private String postType;
	private Date postTime;
	private String postConten;
}
