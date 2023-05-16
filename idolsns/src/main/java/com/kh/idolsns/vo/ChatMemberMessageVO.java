package com.kh.idolsns.vo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@JsonIgnoreProperties
@Data @NoArgsConstructor
@AllArgsConstructor @Builder
public class ChatMemberMessageVO {

	private String memberId;
	private String memberLevel;
	private String chatMessageContent;
	private long time;
	
}
