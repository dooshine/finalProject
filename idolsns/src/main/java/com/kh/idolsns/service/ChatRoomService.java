package com.kh.idolsns.service;
import com.kh.idolsns.vo.ChatMessageReceiveVO;
import com.kh.idolsns.vo.ChatRoomProcessVO;

public interface ChatRoomService {

	int createChatRoom(ChatRoomProcessVO vo);
	void leaveChatRoom(ChatRoomProcessVO vo);
	void inviteMember(ChatRoomProcessVO vo);
	//int createChatRoom(ChatMessageReceiveVO vo);
	
}
