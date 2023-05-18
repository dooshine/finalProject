package com.kh.idolsns.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor

// 제재 DTO
public class SanctionDto {
    private int sanctionNo;
    private String sanctionTargetType;
    private String sanctionTargetPrimaryKey;
    private String sanctionFor;
    private int sanctionTerm;
    private Date sanctionStart;
    private Date sanctionEnd;
}
