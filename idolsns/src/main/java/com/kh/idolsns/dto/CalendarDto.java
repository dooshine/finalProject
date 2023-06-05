package com.kh.idolsns.dto;
import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor
@AllArgsConstructor @Builder
public class CalendarDto {

	private int calendarNo;
	private String memberId;
	private String calendarTitle;
	private Date calendarStart;
	private Date calendarEnd;
	private String calendarMemo;
	
}
