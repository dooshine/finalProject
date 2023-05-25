package com.kh.idolsns.dto;
import lombok.Data;

@Data
public class ChatReadDto {

	private int chatRoomNo;
	private long chatMessageNo;
	
	private String chatSender;
	private String chatReceiver;
	
}
