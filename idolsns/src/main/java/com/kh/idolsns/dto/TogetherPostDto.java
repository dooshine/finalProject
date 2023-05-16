package com.kh.idolsns.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class TogetherPostDto {
	private Long postNo;
	private String memberId;
	private Date togetherStart;
	private Date togetherEnd;
}
