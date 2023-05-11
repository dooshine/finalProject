package com.kh.idolsns.dto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
@AllArgsConstructor @Builder
public class ChatRoomPrivateDto {

	private int chatRoomPrivateNo;
	private String chatRoomPrivateI;
	private String chatRoomPrivateYou;
	
}
