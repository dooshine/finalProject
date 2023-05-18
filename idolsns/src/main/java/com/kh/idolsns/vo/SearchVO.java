package com.kh.idolsns.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class SearchVO {

    // 게시판 종류
    private String postType;
    
}
