package com.kh.idolsns.vo;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

// 메세지 수신 양식
@Data @JsonIgnoreProperties
public class ChatMessageReceiveVO {

	private int type;
	private String chatMessageContent;
	private int chatRoomNo;
	
	private long chatMessageNo;
	private int attachmentNo;
	
	private String memberId;
	
	private List<Integer> joinRooms;
	
}
