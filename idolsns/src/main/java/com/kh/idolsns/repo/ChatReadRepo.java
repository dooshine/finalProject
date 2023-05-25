package com.kh.idolsns.repo;
import com.kh.idolsns.dto.ChatReadDto;

public interface ChatReadRepo {

	void saveMessage(ChatReadDto dto);
	
}
