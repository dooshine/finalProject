package com.kh.idolsns.vo;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.kh.idolsns.dto.ChatRoomDto;
import com.kh.idolsns.dto.ChatRoomPrivDto;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Data
@JsonIgnoreProperties
public class ChatRoomProcessVO {
	
	private int type;
	private String memberId;
	private ChatRoomDto chatRoomDto;
	private List<String> memberList;
	private ChatRoomPrivDto chatRoomPrivDto;
	private int chatRoomNo;
	private int chatMessageType;
	
}
