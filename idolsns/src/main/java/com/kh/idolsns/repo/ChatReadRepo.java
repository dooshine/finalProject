package com.kh.idolsns.repo;
import com.kh.idolsns.dto.ChatReadDto;
import com.kh.idolsns.vo.ChatMessageVO;

public interface ChatReadRepo {

	void saveMessage(ChatReadDto dto);
	void readMessage(ChatReadDto dto);
	
}
