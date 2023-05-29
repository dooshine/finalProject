package com.kh.idolsns.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class ReplyDto {
	private Long replyNo;
	private Long postNo;
	private String replyId;
	private String replyContent;
	private Date replyTime;
	private Long replyGroupNo;
}
