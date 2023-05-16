package com.kh.idolsns.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class PostImageDto {

	private int attachmentNo;
	private Long postNo;
	
	//이미지의 URL을 반환하는 메소드
		public String getImageURL() {
			return "/download?attachmentNo="+attachmentNo;
		}
}
