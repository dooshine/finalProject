package com.kh.idolsns.dto;
import java.sql.Date;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
@AllArgsConstructor @Builder
@JsonIgnoreProperties
public class ChatRoomDto {

	private int chatRoomNo;
	private String chatRoomName1;
	private String chatRoomName2;
	private Date chatRoomStart;
	private char chatRoomType;
	private Date chatRoomLast;
	
}
