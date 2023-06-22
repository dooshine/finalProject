package com.kh.idolsns.vo;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
@AllArgsConstructor @Builder
public class ChatMessageVO {

	private long chatMessageNo;
	private int chatRoomNo;
	
	private String memberId;
	private long chatMessageTime;
	
	private String chatMessageContent;
	private int attachmentNo;
	private int chatMessageType;
	
	private int page;
	
}
