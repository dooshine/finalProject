package com.kh.idolsns.dto;
import java.sql.Date;
import lombok.Data;

@Data
public class ChatRoomDto {

	private int chatRoomNo;
	private String chatRoomName;
	private Date chatRoomStart;
	
}
