package com.kh.idolsns.dto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
@AllArgsConstructor @Builder
public class ChatRoomPrivDto {

	private int chatRoomPrivNo;
	private String chatRoomPrivI;
	private String chatRoomPrivU;
	
}
