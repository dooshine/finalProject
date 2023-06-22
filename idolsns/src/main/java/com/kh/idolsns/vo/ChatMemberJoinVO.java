package com.kh.idolsns.vo;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Data;

@Data
@JsonIgnoreProperties
public class ChatMemberJoinVO {

	private int chatRoomNo;
	private String memberId;
	
	private List<Integer> chatRoomNoList;
	
}
