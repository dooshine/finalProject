package com.kh.idolsns.repo;
import java.util.List;
import com.kh.idolsns.dto.ChatJoinDto;

public interface ChatJoinRepo {

	void joinChatRoom(ChatJoinDto dto);
	List<ChatJoinDto> findChatRoomById(String memberId);
	int findChatRoomNoById(String memberId);
	boolean doseAlreadyIn(ChatJoinDto dto);
	List<ChatJoinDto> findMembersByRoomNo(int chatRoomNo);
	
}
