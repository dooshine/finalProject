package com.kh.idolsns.dto;
import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
@AllArgsConstructor @Builder
public class NotiDto {

	private int notiNo;
	private String memberId;
	private int notiType;
	private Date notiTime;
	
}
