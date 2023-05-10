package com.kh.idolsns.repo;
import java.util.List;
import com.kh.idolsns.dto.ChatRoomDto;

public interface ChatRoomRepo {

	void createRoom(ChatRoomDto dto);
	ChatRoomDto findRoom(int roomNo);
	List<ChatRoomDto> listRoom();
	
}
