package com.kh.idolsns.service;
import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.idolsns.dto.ChatJoinDto;
import com.kh.idolsns.dto.ChatMessageDto;
import com.kh.idolsns.dto.ChatReadDto;
import com.kh.idolsns.dto.ChatRoomDto;
import com.kh.idolsns.repo.ChatJoinRepo;
import com.kh.idolsns.repo.ChatMessageRepo;
import com.kh.idolsns.repo.ChatReadRepo;
import com.kh.idolsns.repo.ChatRoomRepo;
import com.kh.idolsns.vo.ChatMemberMessageVO;
import com.kh.idolsns.vo.ChatMemberVO;
import com.kh.idolsns.vo.ChatMessageReceiveVO;
import com.kh.idolsns.vo.ChatRoomVO;
import com.kh.idolsns.websocket.WebSocketConstant;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	private ChatRoomRepo chatRoomRepo;
	@Autowired
	private ChatJoinRepo chatJoinRepo;
	@Autowired
	private ChatMessageRepo chatMessageRepo;
	@Autowired
	private ChatReadRepo chatReadRepo;
	
	// 저장소
	private Map<Integer, ChatRoomVO> chatRooms = Collections.synchronizedMap(new HashMap<>());
	
	// 메세지 해석기
	private ObjectMapper mapper = new ObjectMapper();
	
	// 방 존재 여부 확인
	public boolean roomExist(int chatRoomNo) {
		return chatRooms.containsKey(chatRoomNo);
	}
	
	// 방 생성
	public void createRoom(int chatRoomNo) {
		if(roomExist(chatRoomNo)) return;
		chatRooms.put(chatRoomNo, new ChatRoomVO());
		// db처리
		boolean isWatingRoom = chatRoomNo == WebSocketConstant.WAITING_ROOM;
		if(!isWatingRoom && chatRoomRepo.findRoom(chatRoomNo) == null) {
			ChatRoomDto dto = new ChatRoomDto();
			dto.setChatRoomNo(chatRoomNo);
			dto.setChatRoomName("나중에 바꾸기");
			chatRoomRepo.createRoom(dto);
		}
	}
	
	// 방 제거
	public void deleteRoom(int chatRoomNo) {
		chatRooms.remove(chatRoomNo);
	}
	
	// 방 입장
	public void join(ChatMemberVO member, int chatRoomNo) {
		// 방 생성
		createRoom(chatRoomNo);
		// 방 선택
		ChatRoomVO chatRoom = chatRooms.get(chatRoomNo);
		// 해당 방에 입장
		chatRoom.enter(member);
		// 참여자 등록(db 처리)
		boolean isWatingRoom = chatRoomNo == WebSocketConstant.WAITING_ROOM;
		if(isWatingRoom) return;
		ChatJoinDto joinDto = new ChatJoinDto();
		joinDto.setChatRoomNo(chatRoomNo);
		joinDto.setMemberId(member.getMemberId());
		boolean isJoin = chatJoinRepo.doseAlreadyIn(joinDto);
		if(isJoin) return;
		ChatJoinDto dto = new ChatJoinDto();
		dto.setChatRoomNo(chatRoomNo);
		dto.setMemberId(member.getMemberId());
		chatJoinRepo.joinChatRoom(dto);
		log.debug("{} 님이 {}번 방에 입장했습니다.", member.getMemberId(), chatRoomNo);
	}
	
	// 방 퇴장
	public void exit(ChatMemberVO member, int chatRoomNo) {
		if(!roomExist(chatRoomNo)) return;
		ChatRoomVO chatRoom = chatRooms.get(chatRoomNo);
		chatRoom.leave(member);
		// 참여자 삭제(db 처리) - 테스트 해보고 처리
		log.debug("{} 님이 {}번 방에 입장했습니다.", member.getMemberId(), chatRoomNo);
	}
	
	// 사용자가 존재하는 방의 번호를 찾는 기능
	public int findRoomHasMember(ChatMemberVO member) {
		// 모든 방의 숫자 꺼내기
		for(int chatRoomNo : chatRooms.keySet()) {
			// 해당 방 객체 추출
			ChatRoomVO chatRoom = chatRooms.get(chatRoomNo);
			// 해당 방에 사용자가 있다면 방 번호 반환
			if(chatRoom.memberExist(member)) return chatRoomNo;
		}
		return -1;
	}
	
	// 메세지 전송
	public void broadcast(ChatMemberVO member, int chatRoomNo, TextMessage jsonMessage) throws IOException {
		if(!roomExist(chatRoomNo)) return;
		ChatRoomVO chatroom = chatRooms.get(chatRoomNo);
		chatroom.broadcast(jsonMessage);
		// 보낸 메세지 db 처리
		// [1] 메세지 테이블에 저장
		ChatMessageDto messageDto = new ChatMessageDto();
		messageDto.setChatRoomNo(chatRoomNo);
		messageDto.setMemberId(member.getMemberId());
		messageDto.setChatMessageContent(jsonMessage.getPayload());
		chatMessageRepo.sendMessage(messageDto);
		// [2] 전송 테이블에 저장
		// 채팅방 사용자 저장
		List<ChatJoinDto> recieverList = chatJoinRepo.findMembersByRoomNo(chatRoomNo);
		String memberId = member.getMemberId();
		for(int i=0; i<recieverList.size(); i++) {
			if(memberId.equals(recieverList.get(i).getMemberId())) return;
			ChatReadDto readDto = new ChatReadDto();
			readDto.setChatRoomNo(chatRoomNo);
			readDto.setChatMessageNo(messageDto.getChatMessageNo());
			readDto.setChatSender(member.getMemberId());
			readDto.setChatReciever(recieverList.get(i).getMemberId());
			chatReadRepo.saveMessage(readDto);
		}
	}
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	@Override
	public void connectHandler(WebSocketSession session) {
		ChatMemberVO member = new ChatMemberVO(session);
		int chatRoomNo = WebSocketConstant.WAITING_ROOM;
		this.join(member, chatRoomNo);
	}
	@Override
	public void disconnectHandler(WebSocketSession session) {
		ChatMemberVO member = new ChatMemberVO(session);
		int chatRoomNo = this.findRoomHasMember(member);
		this.exit(member, chatRoomNo);
	}
	@Override
	public void receiveHandler(WebSocketSession session, TextMessage message) throws IOException {
		// 회원 정보 생성
		ChatMemberVO member = new ChatMemberVO(session);
		// 비회원 차단
		if(!member.isMember()) return;
		// 메세지 수신 -> type을 분석하고 해당 타입에 맞는 처리
		ChatMessageReceiveVO receiveVO = mapper.readValue(message.getPayload(), ChatMessageReceiveVO.class);
		// 채팅 메세지인 경우
		if(receiveVO.getType() == WebSocketConstant.CHAT) {
			// 채팅방 찾기
			int chatRoomNo = this.findRoomHasMember(member);
			// 채팅방이 없거나, 대기실인 경우 매세지 전송 불가
			if(chatRoomNo == -1) return;
			if(chatRoomNo == WebSocketConstant.WAITING_ROOM) return;
			// 메세지 해석 및 신규 메세지 생성, 전송
			ChatMemberMessageVO msg = new ChatMemberMessageVO();
			msg.setChatMessageContent(receiveVO.getContent());
			msg.setTime(System.currentTimeMillis());
			msg.setMemberId(member.getMemberId());
			msg.setMemberLevel(member.getMemberLevel());
			// JSON으로 변환
			String json = mapper.writeValueAsString(msg);
			TextMessage jsonMessage = new TextMessage(json);
			this.broadcast(member, chatRoomNo, jsonMessage);
		}
		// 채팅방 입장 메세지인 경우
		else if(receiveVO.getType() == WebSocketConstant.JOIN) {
			int chatRoomNo = receiveVO.getRoomNo();
			this.join(member, chatRoomNo);
		}
	}

}
