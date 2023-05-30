package com.kh.idolsns.dto;

import lombok.Builder;
import lombok.Data;

@Data @Builder
public class MemberProfileImageDto {

	private  String memberId;
	private  int attachmentNo;
}
