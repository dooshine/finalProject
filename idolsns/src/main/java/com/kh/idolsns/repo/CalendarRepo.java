package com.kh.idolsns.repo;
import java.util.List;
import com.kh.idolsns.dto.CalendarDto;

public interface CalendarRepo {

	int sequence();
	void insert(CalendarDto dto);
	List<CalendarDto> selectList(String memberId);
	CalendarDto selectOne(int calendarNo);
	void delete(int calendarNo);
	void updateDate(CalendarDto dto);
	void updateContent(CalendarDto dto);
	
}
