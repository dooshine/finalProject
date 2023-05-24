package com.kh.idolsns.service;
import com.kh.idolsns.vo.ChatRoomVO;

public interface ChatRoomService {

	void createChatRoom(ChatRoomVO vo);
	void leaveChatRoom(ChatRoomVO vo);
	void inviteMember(ChatRoomVO vo);
	
}
