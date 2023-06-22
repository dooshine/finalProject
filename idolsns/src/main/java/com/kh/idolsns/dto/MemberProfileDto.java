package com.kh.idolsns.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// 회원 아이디+닉네임+프로필사진번호 DTO
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberProfileDto {
    private String memberId;
    private String memberNick;
    private Integer attachmentNo;

    // 대표이미지 src
    public String getProfileSrc(){
        return attachmentNo==null ? "/static/image/profileDummy.png" : "/download/?attachmentNo=" + this.attachmentNo;
    }
}
