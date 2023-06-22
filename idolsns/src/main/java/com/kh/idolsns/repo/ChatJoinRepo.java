package com.kh.idolsns.repo;
import java.util.List;
import com.kh.idolsns.dto.ChatJoinDto;

public interface ChatJoinRepo {

	void joinChatRoom(ChatJoinDto dto);
	List<ChatJoinDto> findChatRoomById(String memberId);
	List<Integer> findChatRoomNoById(String memberId);
	boolean doseAlreadyIn(ChatJoinDto dto);
	List<ChatJoinDto> findMembersByRoomNo(int chatRoomNo);
	long findJoinTime(int chatRoomNo, String memberId);
	void leaveRoom(ChatJoinDto dto);
	
}
