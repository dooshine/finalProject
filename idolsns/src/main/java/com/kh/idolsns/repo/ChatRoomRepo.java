package com.kh.idolsns.repo;
import java.util.List;
import com.kh.idolsns.dto.ChatRoomDto;

public interface ChatRoomRepo {

	int sequence();
	void createRoom(ChatRoomDto dto);
	ChatRoomDto findRoom(int roomNo);
	void deleteRoom(ChatRoomDto dto);
	void changeName(ChatRoomDto dto);
	List<ChatRoomDto> findRooms(List<Integer> chatRoomNoList);
	
}
