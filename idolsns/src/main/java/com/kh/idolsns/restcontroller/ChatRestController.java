package com.kh.idolsns.restcontroller;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.kh.idolsns.dto.ChatJoinDto;
import com.kh.idolsns.dto.ChatMessageDto;
import com.kh.idolsns.dto.ChatRoomDto;
import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.repo.ChatJoinRepo;
import com.kh.idolsns.repo.ChatMessageRepo;
import com.kh.idolsns.repo.ChatRoomPrivRepo;
import com.kh.idolsns.repo.ChatRoomRepo;
import com.kh.idolsns.repo.MemberRepo;
import com.kh.idolsns.vo.ChatMessageVO;

@RestController
@RequestMapping("/chat")
public class ChatRestController {

	@Autowired
	private ChatMessageRepo chatMessageRepo;
	@Autowired
	private ChatRoomRepo chatRoomRepo;
	@Autowired
	private ChatJoinRepo chatJoinRepo;
	@Autowired
	private ChatRoomPrivRepo chatRoomPrivRepo;
	@Autowired
	private MemberRepo memberRepo;
	
	// 채팅방 목록 불러오기
	@GetMapping("/chatRoom/{memberId}")
	public List<ChatJoinDto> chatRoomList(@PathVariable String memberId) {
//		int chatRoomNo = chatJoinRepo.findChatRoomNoById(memberId);
		return chatJoinRepo.findChatRoomById(memberId);
	}
	
	// 채팅방 입장
	/*@GetMapping("/chatRoom/{chatRoomNo}")
	public ChatRoomDto enterRoom(@PathVariable int chatRoomNo) {
		return chatRoomRepo.findRoom(chatRoomNo);
	}*/
	
	// 메세지 불러오기
	@GetMapping("/message/{chatRoomNo}")
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
	
	// 내 팔로워 목록 불러오기 (현재 팔로우 기능 부재로 전체 회원 목록 불러오는 것으로 대체)
	@GetMapping("/chatRoom/follow")
	public List<MemberDto> followList() {
		return memberRepo.selectAll();
	}
	
	// 채팅방 생성
	@PostMapping("/chatRoom")
	public void createRoom(@RequestBody ChatRoomDto chatRoomDto, @PathVariable List<ChatJoinDto> members) {
		// 채팅방 테이블에 저장
		int chatRoomNo = chatRoomRepo.sequence();
		chatRoomDto.setChatRoomNo(chatRoomNo);
		chatRoomRepo.createRoom(chatRoomDto);
		// 참여자 테이블에 저장
		for(ChatJoinDto member : members) {
			ChatJoinDto.builder()
				.memberId(member.getMemberId())
				.chatJoinTime(member.getChatJoinTime())
				.chatRoomNo(member.getChatRoomNo())
			.build();
		}
	}
	
}
