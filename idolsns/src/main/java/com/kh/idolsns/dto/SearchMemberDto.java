package com.kh.idolsns.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class SearchMemberDto {
    private String memberId;
    private String memberNick;
    private int attachmentNo;

    public String getProfileSrc(){
        return attachmentNo==0 ? "/static/image/profileDummy.png" : "/download/?attachmentNo=" + this.attachmentNo;
    }
}
