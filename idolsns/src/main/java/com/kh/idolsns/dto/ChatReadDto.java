package com.kh.idolsns.dto;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties
public class ChatReadDto {

	private int chatRoomNo;
	private long chatMessageNo;
	
	private String chatSender;
	private String chatReceiver;
	
}
