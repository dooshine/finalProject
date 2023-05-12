package com.kh.idolsns.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 신고DTO
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ReportDto {
    // 신고 번호(시퀀스)
    private Long reportNo;
    // 신고자 아이디
    private String memberId;
    // 신고 대상 타입
    private String reportTargetType;
    // 신고 대상 PK
    private String reportTargetPrimaryKey;
    // 신고 이유
    private String reportFor;
    // 신고 시간
    private Date reportTime;
}
