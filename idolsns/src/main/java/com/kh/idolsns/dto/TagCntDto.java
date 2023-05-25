package com.kh.idolsns.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 태그 사용횟수 DTO
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TagCntDto {
    private Long tagCnt;
    private String tagType;
    private String tagName;
}
