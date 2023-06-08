package com.kh.idolsns.repo;
import java.util.List;
import com.kh.idolsns.dto.ChatMessageDto;

public interface ChatMessageRepo {

	int sequence();
	void sendMessage(ChatMessageDto dto);
	List<ChatMessageDto> messageList(ChatMessageDto dto);
	void deleteMessage(long chatMessageNo);
	void sendPic(ChatMessageDto dto);
	
}
