package com.kh.idolsns.repo;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.idolsns.dto.CalendarDto;

@Repository
public class CalendarRepoImpl implements CalendarRepo {

	@Autowired
	private SqlSession sql;

	@Override
	public int sequence() {
		return sql.selectOne("calendar.sequence");
	}
	@Override
	public void insert(CalendarDto dto) {
		sql.insert("calendar.insert", dto);
	}
	@Override
	public List<CalendarDto> selectList(String memberId) {
		return sql.selectList("calendar.selectList", memberId);
	}
	@Override
	public CalendarDto selectOne(int calendarNo) {
		return sql.selectOne("calendar.selectOne", calendarNo);
	}
	@Override
	public void delete(int calendarNo) {
		sql.delete("calendar.delete", calendarNo);
	}
	
}
