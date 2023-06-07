package com.kh.idolsns.restcontroller;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.NoHandlerFoundException;
import com.kh.idolsns.dto.ChatJoinDto;
import com.kh.idolsns.dto.ChatMessageDto;
import com.kh.idolsns.dto.ChatReadDto;
import com.kh.idolsns.dto.ChatRoomDto;
import com.kh.idolsns.dto.MemberDto;
import com.kh.idolsns.dto.MemberSimpleProfileDto;
import com.kh.idolsns.repo.ChatJoinRepo;
import com.kh.idolsns.repo.ChatMessageRepo;
import com.kh.idolsns.repo.ChatReadRepo;
import com.kh.idolsns.repo.ChatRoomRepo;
import com.kh.idolsns.repo.MemberRepo;
import com.kh.idolsns.repo.MemberSimpleProfileRepo;
import com.kh.idolsns.service.ChatRoomService;
import com.kh.idolsns.vo.ChatMemberJoinVO;
import com.kh.idolsns.vo.ChatMessageVO;
import com.kh.idolsns.vo.ChatRoomProcessVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/chat")
public class ChatRestController {

	@Autowired
	private ChatMessageRepo chatMessageRepo;
	@Autowired
	private ChatJoinRepo chatJoinRepo;
	@Autowired
	private MemberRepo memberRepo;
	@Autowired
	private ChatRoomService chatRoomService;
	@Autowired
	private ChatRoomRepo chatRoomRepo;
	@Autowired
	private ChatReadRepo chatReadRepo;
	@Autowired
	private MemberSimpleProfileRepo memberSimpleProfileRepo;
	
	// 채팅방 목록 불러오기
	@GetMapping("/chatRoom/{memberId}")
	public List<ChatRoomDto> chatRoomList(@PathVariable String memberId) {
		List<Integer> chatRoomNoList = chatJoinRepo.findChatRoomNoById(memberId);
		//log.debug("chatRoomNoList: " + chatRoomNoList);
		if(!chatRoomNoList.isEmpty()) return chatRoomRepo.findRooms(chatRoomNoList);
		else return Collections.emptyList();
	}
	
	// 메세지 불러오기
	@GetMapping("/message/{chatRoomNo}")
	public List<ChatMessageVO> roomMessage(@PathVariable int chatRoomNo) {
		List<ChatMessageDto> tempList = chatMessageRepo.messageList(chatRoomNo);
		List<ChatMessageVO> list = new ArrayList<>();
		for(ChatMessageDto chatMessageDto : tempList) {
			//log.debug("dto attachmentNo: " + chatMessageDto.getAttachmentNo());
			list.add(ChatMessageVO.builder()
							.chatMessageNo(chatMessageDto.getChatMessageNo())
							.chatRoomNo(chatRoomNo)
							.memberId(chatMessageDto.getMemberId())
							.chatMessageTime(chatMessageDto.getChatMessageTime().getTime())
							.chatMessageContent(chatMessageDto.getChatMessageContent())
							.attachmentNo(chatMessageDto.getAttachmentNo())
							.chatMessageType(chatMessageDto.getChatMessageType())
						.build()
			);
		}
		return list;
	}
	
	// 내 팔로우 목록 불러오기
	@GetMapping("/chatRoom/follow")
	public List<MemberDto> followList() {
		return memberRepo.selectAll();
	}
	
	// 채팅방 생성
	/*@PostMapping("/chatRoom")
	public void createRoom(@RequestBody ChatRoomProcessVO vo) {
		chatRoomService.createChatRoom(vo);
	}*/
	
	// 채팅방에 참여한 시간 내보내기
	@PostMapping("/chatRoom/join")
	public long getJoinTime(@RequestBody ChatMemberJoinVO vo) {
		return chatJoinRepo.findJoinTime(vo.getChatRoomNo(), vo.getMemberId());
	}
	
	// 채팅방 나가기, 삭제
	@PostMapping("/chatRoom/leave")
	public void leaveRoom(@RequestBody ChatRoomProcessVO vo) {
		chatRoomService.leaveChatRoom(vo);
	}
	
	// 채팅방 정보 불러오기
	@GetMapping("/chatRoom/chatRoomNo/{chatRoomNo}")
	public ChatRoomDto loadRoomInfo(@PathVariable int chatRoomNo) {
		return chatRoomRepo.findRoom(chatRoomNo);
	}
	
	// 채팅방 이름 변경
	@PutMapping("/chatRoom/changeName")
	public void changeName(@RequestBody ChatRoomDto chatRoomDto) throws NoHandlerFoundException {
		ChatRoomDto find = chatRoomRepo.findRoom(chatRoomDto.getChatRoomNo());
		if(find == null) throw new NoHandlerFoundException(null, null, null);
		chatRoomRepo.changeName(chatRoomDto);
	}
	
	// (이미 있는) 채팅방에 사용자 초대
	@PostMapping("/chatRoom/invite")
	public void inviteMember(@RequestBody ChatRoomProcessVO vo) {
		chatRoomService.inviteMember(vo);
	}
	
	// 채팅방 참여자 목록 조회 - 수정
	@GetMapping("/chatRoom/chatMember/{chatRoomNo}")
	public List<MemberSimpleProfileDto> loadChatMember(@PathVariable int chatRoomNo) {
		List<ChatJoinDto> memberList = chatJoinRepo.findMembersByRoomNo(chatRoomNo);
		List<String> memberIdList = new ArrayList<>();
		for(int i=0; i<memberList.size(); i++) {
			memberIdList.add(memberList.get(i).getMemberId());
		}
		return memberSimpleProfileRepo.profile(memberIdList);
	}
	
	// 메세지 읽음 처리
	@PutMapping("/message")
	public void readMessage(@RequestBody ChatReadDto dto) {
		chatReadRepo.readMessage(dto);
	}
	
	// 접속시 새 메세지 알림이 있는지 확인 (있으면 true 반환)
	@GetMapping("/message/noti/{memberId}")
	public boolean loadChatNoti(@PathVariable String memberId) {
		return chatReadRepo.newChatCount(memberId) > 0;
	}
	
	// 채팅방 각각 새 메세지 알림 있는지 확인
	@PostMapping("/message/noti")
	public List<ChatReadDto> chatNotiByRoom(@RequestBody ChatMemberJoinVO vo) {
		return chatReadRepo.newChatByRoom(vo.getChatRoomNoList(), vo.getMemberId());
	}
	
}
