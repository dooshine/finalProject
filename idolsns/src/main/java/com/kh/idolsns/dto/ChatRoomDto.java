package com.kh.idolsns.dto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
@AllArgsConstructor @Builder
public class ChatRoomDto {

	private int chatRoomNo;
	private String chatRoomName;
	private long chatRoomStart;
	private char chatRoomType;
	
}
