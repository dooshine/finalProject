package com.kh.idolsns.service;
import com.kh.idolsns.vo.ChatMessageReceiveVO;
import com.kh.idolsns.vo.ChatRoomProcessVO;

public interface ChatRoomService {

	int createChatRoom(ChatMessageReceiveVO vo);
	void leaveChatRoom(ChatRoomProcessVO vo);
	void inviteMember(ChatRoomProcessVO vo);
	void reinviteMember(ChatRoomProcessVO vo);
	
}
