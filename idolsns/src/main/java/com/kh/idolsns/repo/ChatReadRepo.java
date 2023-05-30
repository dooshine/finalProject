package com.kh.idolsns.repo;
import java.util.List;
import com.kh.idolsns.dto.ChatReadDto;

public interface ChatReadRepo {

	void saveMessage(ChatReadDto dto);
	void readMessage(ChatReadDto dto);
	int newChatCount(String memberId);
	List<ChatReadDto> newChatByRoom(List<Integer> chatRoomNoList, String memberId);
	
}
