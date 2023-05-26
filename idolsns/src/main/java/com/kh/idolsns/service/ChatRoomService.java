package com.kh.idolsns.service;
import com.kh.idolsns.vo.ChatRoomProcessVO;

public interface ChatRoomService {

	void createChatRoom(ChatRoomProcessVO vo);
	void leaveChatRoom(ChatRoomProcessVO vo);
	void inviteMember(ChatRoomProcessVO vo);
	
}
