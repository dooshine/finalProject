package com.kh.idolsns.vo;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class SanctionSearchVO {

    private int sanctionNo;
    private List<String> sanctionTargetTypes;
    private String sanctionTargetPrimaryKey;
    private String sanctionFor;
    // private Date sanction
}
