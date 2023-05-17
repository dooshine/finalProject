package com.kh.idolsns.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TagDto {
	// 태그 번호
	private Long tagNo;
	// 통합 게시글 번호
	private Long postNo;
	// 태그 타입
	private String tagType;
	// 태그 명
	private String tagName;
}
