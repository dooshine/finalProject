package com.kh.idolsns.vo;

import java.util.List;

import com.kh.idolsns.dto.FundDto;
import com.kh.idolsns.dto.FundPostImageDto;
import com.kh.idolsns.dto.PostImageDto;

import lombok.Data;

@Data
public class FundDetailVO {
	private FundPostImageDto fundPostImageDto;
	private List<PostImageDto> attachmentNos;
	private List<FundDto> fundDtos;
	private List<FundVO> fundVOs;
}
