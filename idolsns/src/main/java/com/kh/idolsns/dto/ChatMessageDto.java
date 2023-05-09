package com.kh.idolsns.dto;
import java.sql.Date;
import lombok.Data;

@Data
public class ChatMessageDto {

	private int chatRoomNo;
	private long chatMessageNo;
	
	private String memberId;
	private Date chatMessageTime;
	
	// 메세지 내용
	private String messageContent;
	
}
