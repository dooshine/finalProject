package com.kh.idolsns.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 고정 태그 DTO
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class FixedTagDto {
    private int fixedTagNo;
    private String fixedTagName;
}
