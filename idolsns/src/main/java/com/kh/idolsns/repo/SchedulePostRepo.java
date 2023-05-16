package com.kh.idolsns.repo;

import com.kh.idolsns.dto.SchedulePostDto;

public interface SchedulePostRepo {
	public void insert(SchedulePostDto scheduleDto);
	public SchedulePostDto selectOne(Long postNo);
	public void delete(Long postNo); 
}
