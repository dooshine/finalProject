package com.kh.idolsns.dto;
import java.sql.Date;
import lombok.Data;

@Data
public class ChatMessageDto {

	private long chatMessageNo;
	private int chatRoomNo;
	
	private String memberId;
	private Date chatMessageTime;
	
	private String chatMessageContent;
	
}
