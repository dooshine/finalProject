package com.kh.idolsns.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class ReplyShowVO {
	private Long replyNo;
	private Long postNo;
	private String replyId;
	private String replyContent;
	private Timestamp replyTime;
	private Long replyGroupNo;
	// 작성자 닉네임 
	private String memberNick;
	// 작성자 프로필 임지ㅣ
	private Integer attachmentNo;
	
}
