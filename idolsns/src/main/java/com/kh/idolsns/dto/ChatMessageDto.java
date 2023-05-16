package com.kh.idolsns.dto;
import lombok.Data;

@Data
public class ChatMessageDto {

	private long chatMessageNo;
	private int chatRoomNo;
	
	private String memberId;
	private long chatMessageTime;
	
	private String chatMessageContent;
	
}
