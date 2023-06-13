package com.kh.idolsns.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class MemberSearchVO {
    private String memberId;
    private Integer page;
    private Long size = 5L;

    public Long getEnd(){
        return this.page * this.size;
    }
    public Long getBegin(){
        return this.getEnd() - this.size + 1;
    }
}
