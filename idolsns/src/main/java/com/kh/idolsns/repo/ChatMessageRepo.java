package com.kh.idolsns.repo;
import java.util.List;
import com.kh.idolsns.dto.ChatMessageDto;
import com.kh.idolsns.vo.ChatMessageVO;

public interface ChatMessageRepo {

	int sequence();
	void sendMessage(ChatMessageDto dto);
	List<ChatMessageDto> messageList(ChatMessageVO vo);
	void deleteMessage(long chatMessageNo);
	void sendPic(ChatMessageDto dto);
	
}
