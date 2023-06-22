package com.kh.idolsns.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 대표페이지 프로필 DTO
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ArtistProfileDto {
    private int artistNo;
    private String artistName;
    private String artistEngName;
    private String artistEngNameLower;
    private Integer attachmentNo;
    private Integer followerCnt;

    // 대표이미지 src
    public String getProfileSrc(){
        return attachmentNo==null ? "/static/image/profileDummy.png" : "/download/?attachmentNo=" + this.attachmentNo;
    }
}
