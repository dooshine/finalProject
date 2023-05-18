package com.kh.idolsns.restcontroller;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.kh.idolsns.dto.ChatMessageDto;
import com.kh.idolsns.repo.ChatMessageRepo;
import com.kh.idolsns.vo.ChatMessageVO;

@RestController
@RequestMapping("/chat/message")
public class ChatRestController {

	@Autowired
	private ChatMessageRepo chatMessageRepo;
	
	// 메세지 불러오기
	@GetMapping("/{chatRoomNo}")
	public List<ChatMessageVO> roomMessage(@PathVariable int chatRoomNo) {
		List<ChatMessageDto> tempList = chatMessageRepo.messageList(chatRoomNo);
		List<ChatMessageVO> list = new ArrayList<>();
		for(ChatMessageDto chatMessageDto : tempList) {
			list.add(ChatMessageVO.builder()
							.chatMessageNo(chatMessageDto.getChatMessageNo())
							.chatRoomNo(chatRoomNo)
							.memberId(chatMessageDto.getMemberId())
							.chatMessageTime(chatMessageDto.getChatMessageTime().getTime())
							.chatMessageContent(chatMessageDto.getChatMessageContent())
						.build()
			);
		}
		return list;
	}
	
	// 메세지 보내기(보낸 메세지 저장)
	/*@PostMapping("/")
	public void sendMessage(@ModelAttribute ChatMessageDto chatMessageDto) {
		chatMessageRepo.sendMessage(chatMessageDto);
	}*/
	
	// 자기가 보낸 메세지 삭제 (모든 멤버에게 삭제됨)
	@DeleteMapping("/{chatMessageNo}")
	public void deleteMessage(@PathVariable int chatMessageNo) {
		chatMessageRepo.deleteMessage(chatMessageNo);
	}
	
}
