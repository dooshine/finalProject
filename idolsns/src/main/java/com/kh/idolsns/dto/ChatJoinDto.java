package com.kh.idolsns.dto;
import java.sql.Date;
import lombok.Data;

@Data
public class ChatJoinDto {

	private int chatRoomNo;
	private String memberId;
	private Date chatJoinTime;
	
}
