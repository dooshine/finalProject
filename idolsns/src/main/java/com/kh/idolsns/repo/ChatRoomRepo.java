package com.kh.idolsns.repo;
import java.util.List;
import com.kh.idolsns.dto.ChatRoomDto;
import com.kh.idolsns.vo.ChatRoomVO;

public interface ChatRoomRepo {

	int sequence();
	boolean isRoomExist(List<ChatRoomVO> memberList);
	void createRoom(ChatRoomDto dto);
	ChatRoomDto findRoom(int roomNo);
	List<ChatRoomDto> listRoom();
	void deleteRoom(ChatRoomDto dto);
	
}
