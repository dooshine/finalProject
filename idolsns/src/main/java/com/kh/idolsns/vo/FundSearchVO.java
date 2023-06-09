package com.kh.idolsns.vo;

import java.util.List;

import lombok.Data;

@Data
public class FundSearchVO {
	private String searchKeyword;
	private List<String> orderList;
}
