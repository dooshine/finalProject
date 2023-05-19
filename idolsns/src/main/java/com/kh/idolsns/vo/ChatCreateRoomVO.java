package com.kh.idolsns.vo;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.kh.idolsns.dto.ChatRoomDto;
import com.kh.idolsns.dto.ChatRoomPrivDto;
import lombok.Data;

@Data @JsonIgnoreProperties
public class ChatCreateRoomVO {

	private String memberId;
	private ChatRoomDto chatRoomDto;
	private List<String> memberList;
	private ChatRoomPrivDto chatRoomPrivDto;
	
}
