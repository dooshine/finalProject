package com.kh.idolsns.dto;
import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
@AllArgsConstructor @Builder
public class ChatJoinDto {

	private int chatRoomNo;
	private String memberId;
	private Date chatJoinTime;
	
}
