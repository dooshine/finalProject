package com.kh.idolsns.dto;

import java.sql.Date;

import com.fasterxml.jackson.databind.deser.std.DateDeserializers.DateDeserializer;
import lombok.Data;

@Data
public class MemberDto {

	private String memberId;
	private String memberPw;
	private String memberNick;
	private int memberPoint;
	private String memberEmail;
	private String memberAgree;
	private Date memberJoin;
	private String memberLevel;
	private Date memberLogin;
}
