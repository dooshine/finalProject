package com.kh.idolsns.vo;

import java.util.List;

import com.kh.idolsns.dto.FundListWithTagDto;
import com.kh.idolsns.dto.FundPostImageDto;

import lombok.Data;

@Data
public class FundListVO {
	private List<FundListWithTagDto> fundListWithTagDtos;
	private List<FundPostImageDto> fundPostImageDtos;
}
