package com.kh.idolsns.vo;

import java.util.List;

import com.kh.idolsns.dto.FundPostListDto;
import com.kh.idolsns.dto.PostImageDto;

import lombok.Data;

@Data
public class FundDetailVO {
	private FundPostListDto fundPostListDto;
	private List<PostImageDto> attachmentNos;
}
