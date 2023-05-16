package com.kh.idolsns.dto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
@AllArgsConstructor @Builder
public class ChatJoinDto {

	private int chatRoomNo;
	private String memberId;
	private long chatJoinTime;
	
}
