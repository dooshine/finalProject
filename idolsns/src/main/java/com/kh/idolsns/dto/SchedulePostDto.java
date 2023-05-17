package com.kh.idolsns.dto;



import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class SchedulePostDto {
	private Long postNo;
	private String memberId;
	private Date scheduleStart;
	private Date scheduleEnd;
}
