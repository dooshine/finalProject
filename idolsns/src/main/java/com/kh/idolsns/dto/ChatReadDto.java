package com.kh.idolsns.dto;
import java.sql.Date;
import lombok.Data;

@Data
public class ChatReadDto {

	private int chatRoomNo;
	private long chatMessageNo;
	
	private String chatSender;
	private String chatReceiver;
	
	private Date chatReadTime;
	
}
