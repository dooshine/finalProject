package com.kh.idolsns.repo;
import com.kh.idolsns.dto.ChatRoomPrivDto;

public interface ChatRoomPrivRepo {

	void createRoom(ChatRoomPrivDto dto);
	ChatRoomPrivDto findRoom(ChatRoomPrivDto dto);
	void leaveRoom(ChatRoomPrivDto dto);
	ChatRoomPrivDto checkPriv(ChatRoomPrivDto dto);
	
}
