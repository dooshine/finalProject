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
public class MemberProfileFollowDto {
    private String memberId;
	private String memberPw;
	private String memberNick;
	private int memberPoint;
	private String memberEmail;
	private String memberAgree;
	private Date memberJoin;
	private String memberLevel;
	private Date memberLogin;
	private Date memberExitDate;
    // 프로필사진 번호
    private int attachmentNo;
    // 팔로우 수
    private int memberFollowCnt;
    // 팔로워 수
    private int memberFollowerCnt;

	// 프로필이미지 src
	public String getProfileSrc(){
		return attachmentNo==0 ? "/static/image/profileDummy.png" : "/download/?attachmentNo=" + this.attachmentNo;
	}
}
