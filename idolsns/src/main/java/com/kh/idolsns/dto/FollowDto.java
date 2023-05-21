package com.kh.idolsns.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 팔로우 DTO
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class FollowDto {
    private Long followNo;
    private String memberId;
    private String followTargetType;
    private String followTargetPrimaryKey;
    private Date followTime;
}
