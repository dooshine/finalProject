package com.kh.idolsns.vo;

import java.util.List;

import com.kh.idolsns.dto.FundWithNickDto;

import lombok.Data;

@Data
public class FundVO {
	private List<FundWithNickDto> fundWithNickDtos;
	private int fundSponsorCount;
	private int fundTotal;
	
}
