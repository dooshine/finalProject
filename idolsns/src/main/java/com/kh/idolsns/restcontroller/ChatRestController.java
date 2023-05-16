package com.kh.idolsns.restcontroller;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
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
	
	// 메세지 불러오기
	@GetMapping("/message/{chatRoomNo}")
	public List<ChatMessageDto> roomMessage(@PathVariable int chatRoomNo) {
		return chatMessageRepo.messageList(chatRoomNo);
	}
	
	// 자기가 보낸 메세지 삭제 (모든 멤버에게 삭제됨)
	@DeleteMapping("/message/{chatMessageNo}")
	public void deleteMessage(@PathVariable int chatMessageNo, String memberId) {
		chatMessageRepo.deleteMessage(chatMessageNo, memberId);
	}
	
}
