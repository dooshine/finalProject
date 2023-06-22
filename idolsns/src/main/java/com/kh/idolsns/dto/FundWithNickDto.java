package com.kh.idolsns.dto;

import lombok.Data;

@Data
public class FundWithNickDto {
	private Long postNo;
	private String memberId;
	private String memberNick;
	private int fundTotal;
	private int rank;
}
