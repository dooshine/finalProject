package com.kh.idolsns.vo;

import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class FundSearchVO {
	private String searchKeyword;
	private String orderList;
	private String fundState;
}
