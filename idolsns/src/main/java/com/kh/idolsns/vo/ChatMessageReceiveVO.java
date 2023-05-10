package com.kh.idolsns.vo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

// 메세지 수신 양식
//type = 1일 경우 채팅 메세지로 간주하며 content 항목이 필요
//type = 2일 경우 입장 메세지로 간주하며 roomNo 항목 필요
@Data @JsonIgnoreProperties
public class ChatMessageReceiveVO {

	private int type;
	private String content;
	private int chatRoomNo;
	
}
