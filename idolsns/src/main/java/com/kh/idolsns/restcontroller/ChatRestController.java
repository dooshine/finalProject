package com.kh.idolsns.restcontroller;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.kh.idolsns.dto.ChatMessageDto;
import com.kh.idolsns.repo.ChatMessageRepo;

@RestController
@RequestMapping("/chat")
public class ChatRestController {

	@Autowired
	private ChatMessageRepo chatMessageRepo;
	
	@GetMapping("/message/{chatRoomNo}")
	public List<ChatMessageDto> roomMessage(@PathVariable int chatRoomNo) {
		return chatMessageRepo.messageList(chatRoomNo);
	}
	
}
