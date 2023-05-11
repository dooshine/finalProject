package com.kh.idolsns.repo;
import java.util.List;
import com.kh.idolsns.dto.ChatRoomPrivateDto;

public interface ChatRoomPrivateRepo {

	void createPrivateRoom(ChatRoomPrivateDto dto);
	ChatRoomPrivateDto findRoom(int privateRoomNo);
	List<ChatRoomPrivateDto> listPrivateRoom();
	
}
