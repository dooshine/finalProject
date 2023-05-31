package com.kh.idolsns.dto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
@AllArgsConstructor @Builder
public class MemberSimpleProfileDto {

	private String memberId;
	private String memberNick;
	private Integer attachmentNo;

	// 대표이미지 src
    public String getProfileSrc(){
        return attachmentNo==null ? "/static/image/profileDummy.png" : "/download/?attachmentNo=" + this.attachmentNo;
    }
	
}
