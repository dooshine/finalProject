package com.kh.idolsns.service;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.idolsns.constant.WebSocketConstant;
import com.kh.idolsns.dto.ChatJoinDto;
import com.kh.idolsns.dto.ChatMessageDto;
import com.kh.idolsns.dto.ChatReadDto;
import com.kh.idolsns.repo.AttachmentRepo;
import com.kh.idolsns.repo.ChatJoinRepo;
import com.kh.idolsns.repo.ChatMessageRepo;
import com.kh.idolsns.repo.ChatReadRepo;
import com.kh.idolsns.vo.ChatMemberVO;
import com.kh.idolsns.vo.ChatMessageReceiveVO;
import com.kh.idolsns.vo.ChatMessageVO;
import com.kh.idolsns.vo.ChatRoomProcessVO;
import com.kh.idolsns.vo.ChatRoomVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	private ChatJoinRepo chatJoinRepo;
	@Autowired
	private ChatMessageRepo chatMessageRepo;
	@Autowired
	private ChatReadRepo chatReadRepo;
	@Autowired
	private AttachmentRepo attachmentRepo;
	@Autowired
	private ChatRoomService chatRoomService;
	
	// 저장소
	private Map<Integer, ChatRoomVO> chatRooms = Collections.synchronizedMap(new HashMap<>());
	// 메세지 해석기
	private ObjectMapper mapper = new ObjectMapper();
	
	// 방 존재 여부 확인
	public boolean roomExist(int chatRoomNo) {
		return chatRooms.containsKey(chatRoomNo);
	}
	
	// 방 저장
	public void createRoom(int chatRoomNo) {
		if(roomExist(chatRoomNo)) return;
		chatRooms.put(chatRoomNo, new ChatRoomVO());
	}
	
	// 방 제거 - 확인해보기
	public void deleteRoom(int chatRoomNo) {
		chatRooms.remove(chatRoomNo);
	}
	
	// 로그인하면 참여중인 모든 방에 입장 - 수정
	public void login(WebSocketSession session) {
		ChatMemberVO member = new ChatMemberVO(session);
		int chatRoomNo = WebSocketConstant.WAITING_ROOM;
		join(member, chatRoomNo);
	}
	
	// 방 입장 - 수정
	public void join(ChatMemberVO member, int chatRoomNo) {
		//chatRooms.put(chatRoomNo, new ChatRoomVO());
		// 방 생성
		createRoom(chatRoomNo);
		// 방 선택
		/*ChatRoomVO chatRoom = chatRooms.get(chatRoomNo);
		//log.debug("chatRooms: " + chatRooms);
		//log.debug("chatRoom: " + chatRoom);
		// 해당 방에 입장
		chatRoom.enter(member);*/
		// 대기실에 있다면 대기실에서 퇴장
		//boolean isWaitingRoom = chatRoomNo == WebSocketConstant.WAITING_ROOM;
		//log.debug("isWaitingRoom: " + isWaitingRoom);
		// 이미 참여중인 방인지 확인 - 필요 없을지도 (chatRoomService에서 처리중)
		/*ChatJoinDto joinDto = new ChatJoinDto();
		joinDto.setChatRoomNo(chatRoomNo);
		joinDto.setMemberId(member.getMemberId());
		boolean isJoin = chatJoinRepo.doseAlreadyIn(joinDto);*/
		// 이미 참여중이 아니면(처음 들어온 방이라면) db에 참여 등록 - 필요 없을지도 (chatRoomService에서 처리중)
		/*if(!isJoin) {
			ChatJoinDto dto = new ChatJoinDto();
			dto.setChatRoomNo(chatRoomNo);
			dto.setMemberId(member.getMemberId());
			chatJoinRepo.joinChatRoom(dto);
		}*/
		// 대기실 퇴장 후 실제 채팅방 입장
		//if(isWaitingRoom) {
			//exit(member, WebSocketConstant.WAITING_ROOM);
			ChatRoomVO chatRoom = chatRooms.get(chatRoomNo);
			chatRoom.enter(member);
			log.debug("chatRooms: " + chatRooms);
		//}
	}
	
	// 참여중인 방 퇴장
	public void exit(ChatMemberVO member, List<Integer> chatRoomNos) {
		for(int chatRoomNo : chatRoomNos) {
			if(!roomExist(chatRoomNo)) continue;
			ChatRoomVO chatRoom = chatRooms.get(chatRoomNo);
			chatRoom.leave(member);
		}
	}
	public void exit(ChatMemberVO member, int chatRoomNo) {
		if(!roomExist(chatRoomNo)) return;
		ChatRoomVO chatRoom = chatRooms.get(chatRoomNo);
		chatRoom.leave(member);
	}
	
	// 사용자가 존재하는 방의 번호를 찾는 기능
	public List<Integer> findRoomHasMember(ChatMemberVO member) {
		List<Integer> roomNos = new ArrayList<>();
		// 모든 방의 숫자 꺼내기
		for(int chatRoomNo : chatRooms.keySet()) {
			// 해당 방 객체 추출
			ChatRoomVO chatRoom = chatRooms.get(chatRoomNo);
			// 해당 방에 사용자가 있다면 방 번호 반환
			//if(chatRoom.memberExist(member)) return chatRoomNo;
			if(chatRoom.memberExist(member)) {
				roomNos.add(chatRoomNo);
			}
		}
		return roomNos;
	}
	
	// 사용자가 참여중인 방의 번호 찾기(db 기준)
	public List<Integer> findJoinRooms(ChatMemberVO member) {
		List<Integer> joinRooms = new ArrayList<>();
		joinRooms.addAll(chatJoinRepo.findChatRoomNoById(member.getMemberId()));
		return joinRooms;
	}
	
	// 메세지 전송
	public void broadcastMsg(ChatMemberVO member, int chatRoomNo, TextMessage jsonMessage, long chatMessageNo, int chatMessageType) throws IOException {
		if(!roomExist(chatRoomNo)) return;
		ChatRoomVO chatRoom = chatRooms.get(chatRoomNo);
		chatRoom.broadcast(jsonMessage);
		// 보낸 메세지 db 처리
		// [1] 메세지 테이블에 저장
		ChatMessageDto messageDto = new ChatMessageDto();
		messageDto.setChatMessageNo(chatMessageNo);
		messageDto.setChatRoomNo(chatRoomNo);
		messageDto.setMemberId(member.getMemberId());
		messageDto.setChatMessageType(chatMessageType);
		// chatMessageContent에 내용만 빼서 저장
		ObjectMapper objectMapper = new ObjectMapper();
		JsonNode jsonNode = objectMapper.readTree(jsonMessage.getPayload());
		String chatMessageContent = jsonNode.get("chatMessageContent").asText();
		messageDto.setChatMessageContent(chatMessageContent);
		chatMessageRepo.sendMessage(messageDto);
		// [2] 전송 테이블에 저장
		// 채팅방 사용자 저장
		if(chatMessageType == WebSocketConstant.CHAT) {
			List<ChatJoinDto> receiverList = chatJoinRepo.findMembersByRoomNo(chatRoomNo);
			String memberId = member.getMemberId();
			for(int i=0; i<receiverList.size(); i++) {
				// 수신자 = 발신자면 저장 x
				if(memberId.equals(receiverList.get(i).getMemberId())) continue;
				ChatReadDto readDto = new ChatReadDto();
				readDto.setChatRoomNo(chatRoomNo);
				readDto.setChatMessageNo(messageDto.getChatMessageNo());
				readDto.setChatSender(member.getMemberId());
				readDto.setChatReceiver(receiverList.get(i).getMemberId());
				chatReadRepo.saveMessage(readDto);
			}
		}
	}
	
	// 사진 전송
	public void broadcastPic(ChatMemberVO member, int chatRoomNo, TextMessage jsonMessage, long chatMessageNo, int attachmentNo) throws IOException {
		if(!roomExist(chatRoomNo)) return;
		ChatRoomVO chatRoom = chatRooms.get(chatRoomNo);
		chatRoom.broadcast(jsonMessage);
		// 보낸 메세지 db 처리
		// [1] 메세지 테이블에 저장
		ChatMessageDto messageDto = new ChatMessageDto();
		messageDto.setChatMessageNo(chatMessageNo);
		messageDto.setChatRoomNo(chatRoomNo);
		messageDto.setMemberId(member.getMemberId());
		messageDto.setAttachmentNo(attachmentNo);
		// chatMessageContent에 내용만 빼서 저장
		ObjectMapper objectMapper = new ObjectMapper();
		JsonNode jsonNode = objectMapper.readTree(jsonMessage.getPayload());
		String chatMessageContent = jsonNode.get("chatMessageContent").asText();
		messageDto.setChatMessageContent(chatMessageContent);
		chatMessageRepo.sendPic(messageDto);
		// [2] 전송 테이블에 저장
		// 채팅방 사용자 저장
		List<ChatJoinDto> receiverList = chatJoinRepo.findMembersByRoomNo(chatRoomNo);
		String memberId = member.getMemberId();
		for(int i=0; i<receiverList.size(); i++) {
			// 수신자 = 발신자면 저장 x
			if(memberId.equals(receiverList.get(i).getMemberId())) continue;
			ChatReadDto readDto = new ChatReadDto();
			readDto.setChatRoomNo(chatRoomNo);
			readDto.setChatMessageNo(messageDto.getChatMessageNo());
			readDto.setChatSender(member.getMemberId());
			readDto.setChatReceiver(receiverList.get(i).getMemberId());
			chatReadRepo.saveMessage(readDto);
		}
	}
	
	// 메세지 삭제 알림
	public void broadcastDelete(int chatRoomNo, TextMessage jsonMessage) throws IOException {
		if(!roomExist(chatRoomNo)) return;
		ChatRoomVO chatRoom = chatRooms.get(chatRoomNo);
		chatRoom.broadcast(jsonMessage);
	}
	
	// 메세지 삭제
	public void deleteMessage(long chatMessageNo) {
		chatMessageRepo.deleteMessage(chatMessageNo);
	}
	
	// 사진 삭제
	public void deletePic(int attachmentNo) {
		attachmentRepo.delete(attachmentNo);
	}
	
	// 이름 변경
	public void broadcastRename(int chatRoomNo, TextMessage jsonMessage) throws IOException {
		if(!roomExist(chatRoomNo)) return;
		ChatRoomVO chatRoom = chatRooms.get(chatRoomNo);
		chatRoom.broadcast(jsonMessage);
	}
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 수정
	@Override
	public void connectHandler(WebSocketSession session) {
		ChatMemberVO member = new ChatMemberVO(session);
		log.debug("member: " + member);
		/*int chatRoomNo = WebSocketConstant.WAITING_ROOM;*/
		//this.login(session);
		//this.join(member, 0);
		List<Integer> joinRooms = this.findJoinRooms(member);
		for(int i=0; i<joinRooms.size(); i++) {
			log.debug("joinRoom: " + joinRooms.get(i));
			this.join(member, joinRooms.get(i));
		}
	}
	@Override
	public void disconnectHandler(WebSocketSession session) {
		ChatMemberVO member = new ChatMemberVO(session);
		List<Integer> chatRoomNos = this.findRoomHasMember(member);
		this.exit(member, chatRoomNos);
		//int chatRoomNo = this.findRoomHasMember(member);
		//this.exit(member, chatRoomNo);
	}
	@Override
	public void receiveHandler(WebSocketSession session, TextMessage message) throws IOException {
		// 회원 정보 생성
		ChatMemberVO member = new ChatMemberVO(session);
		// 비회원 차단 - 확인해봐야 함
		if(!member.isMember()) return;
		// 메세지 수신 -> type을 분석하고 해당 타입에 맞는 처리
		ChatMessageReceiveVO receiveVO = mapper.readValue(message.getPayload(), ChatMessageReceiveVO.class);
		// 채팅 메세지인 경우
		if(receiveVO.getType() == WebSocketConstant.CHAT) {
			// 채팅방 찾기
			int chatRoomNo = receiveVO.getChatRoomNo();
			int chatMessageType = receiveVO.getType();
			// 채팅방이 없거나, 대기실인 경우 매세지 전송 불가
			if(chatRoomNo == -1) return;
			if(chatRoomNo == WebSocketConstant.WAITING_ROOM) return;
			// 메세지 해석 및 신규 메세지 생성, 전송
			ChatMessageVO msg = new ChatMessageVO();
			msg.setChatRoomNo(chatRoomNo);
			msg.setMemberId(member.getMemberId());
			msg.setChatMessageTime(System.currentTimeMillis());
			msg.setChatMessageContent(receiveVO.getChatMessageContent());
			msg.setChatMessageType(chatMessageType);
			// JSON으로 변환
			// 메세지 번호 생성
			int chatMessageNo = chatMessageRepo.sequence();
			msg.setChatMessageNo(chatMessageNo);
			String json = mapper.writeValueAsString(msg);
			TextMessage jsonMessage = new TextMessage(json);
			this.broadcastMsg(member, chatRoomNo, jsonMessage, chatMessageNo, chatMessageType);
		}
		// 이미지 메세지인 경우
		else if(receiveVO.getType() == WebSocketConstant.PIC) {
			int chatRoomNo = receiveVO.getChatRoomNo();
			if(chatRoomNo == -1) return;
			if(chatRoomNo == WebSocketConstant.WAITING_ROOM) return;
			ChatMessageVO msg = new ChatMessageVO();
			msg.setChatRoomNo(chatRoomNo);
			msg.setMemberId(member.getMemberId());
			msg.setChatMessageTime(System.currentTimeMillis());
			msg.setChatMessageContent(receiveVO.getChatMessageContent());
			msg.setAttachmentNo(receiveVO.getAttachmentNo());
			msg.setChatMessageType(receiveVO.getType());
			int chatMessageNo = chatMessageRepo.sequence();
			msg.setChatMessageNo(chatMessageNo);
			String json = mapper.writeValueAsString(msg);
			TextMessage jsonMessage = new TextMessage(json);
			this.broadcastPic(member, chatRoomNo, jsonMessage, chatMessageNo, receiveVO.getAttachmentNo());
		}
		// 채팅방 입장 메세지인 경우
		/*else if(receiveVO.getType() == WebSocketConstant.JOIN) {
			//log.debug("chatRooms: " + chatRooms);
			int chatRoomNo = receiveVO.getChatRoomNo();
			this.join(member, chatRoomNo);
			//chatReadRepo.readMessage();
			//log.debug("chatRooms: " + chatRooms);
		}*/
		// 메세지 삭제인 경우
		else if(receiveVO.getType() == WebSocketConstant.DELETE) {
			int chatRoomNo = receiveVO.getChatRoomNo();
			int attachmentNo = receiveVO.getAttachmentNo();
			//log.debug("attachmentNo: " + attachmentNo);
			long chatMessageNo = receiveVO.getChatMessageNo();
			this.deleteMessage(chatMessageNo);
			// 이미지 번호가 있으면 첨부파일 테이블에서 이미지 삭제
			if(attachmentNo > 0) this.deletePic(attachmentNo);
			String json = mapper.writeValueAsString(receiveVO);
			TextMessage jsonMessage = new TextMessage(json);
			this.broadcastDelete(chatRoomNo, jsonMessage);
		}
		// 채팅방 나가기, 초대인 경우
		else if(receiveVO.getType() == WebSocketConstant.LEAVE || receiveVO.getType() == WebSocketConstant.INVITE || receiveVO.getType() == WebSocketConstant.DATE) {
			int chatRoomNo = receiveVO.getChatRoomNo();
			int chatMessageType = receiveVO.getType();
			if(chatMessageType == WebSocketConstant.LEAVE) this.exit(member, chatRoomNo);
			// 초대인 경우 초대한 사람이 아니라 초대 받은 사람을 chatRoom에 enter 시켜야 해서 이 코드 확인 필요함
			/*else if(chatMessageType == WebSocketConstant.INVITE) {
				ChatRoomVO chatRoom = chatRooms.get(chatRoomNo);
				chatRoom.enter(member);
			}*/
			ChatMessageVO msg = new ChatMessageVO();
			msg.setChatRoomNo(chatRoomNo);
			msg.setMemberId(member.getMemberId());
			msg.setChatMessageTime(System.currentTimeMillis());
			msg.setChatMessageContent(receiveVO.getChatMessageContent());
			msg.setChatMessageType(chatMessageType);
			int chatMessageNo = chatMessageRepo.sequence();
			msg.setChatMessageNo(chatMessageNo);
			String json = mapper.writeValueAsString(msg);
			TextMessage jsonMessage = new TextMessage(json);
			this.broadcastMsg(member, chatRoomNo, jsonMessage, chatMessageNo, chatMessageType);
		}
		// 채팅방 이름 변경인 경우
		else if(receiveVO.getType() == WebSocketConstant.RENAME) {
			int chatRoomNo = receiveVO.getChatRoomNo();
			String json = mapper.writeValueAsString(receiveVO);
			TextMessage jsonMessage = new TextMessage(json);
			this.broadcastRename(chatRoomNo, jsonMessage);
		}
		// 로그인한 경우 참여중인 채팅방 전부 맵에 저장 - 수정(여기가 제일 문제)
		/*else if(receiveVO.getType() == WebSocketConstant.LOGIN) {
			for(int i=0; i<receiveVO.getJoinRooms().size(); i++) {
				int chatRoomNo = receiveVO.getJoinRooms().get(i);
			    if(!chatRooms.containsKey(chatRoomNo)) {
			    	chatRooms.put(chatRoomNo, new ChatRoomVO());
			    }
			    ChatRoomVO chatRoom = chatRooms.get(chatRoomNo);
			    chatRoom.enter(member);
			    //if(findRoomHasMember(member).contains(chatRoomNo)) {
			    //	exit(member, chatRoomNo);
			    //}
			}
			// 만약 없어지거나 나간 방이 map에 남아있으면 map에서 해당 방의 내 참여여부 삭제
			for(int i=0; i<findRoomHasMember(member).size(); i++) {
				if(!receiveVO.getJoinRooms().contains(findRoomHasMember(member).get(i))) {
					exit(member, findRoomHasMember(member).get(i));
				}
			}
			log.debug("chatRooms: " + chatRooms);
		}*/
		// 로그아웃한 경우(연결 끊긴 경우)
		/*else if(receiveVO.getType() == WebSocketConstant.LOGOUT) {
			for(int i=0; i<receiveVO.getJoinRooms().size(); i++) {
				exit(member, receiveVO.getJoinRooms().get(i));
			}
			log.debug("chatRooms: " + chatRooms);
		}*/
		// 새 방 생성인 경우
		else if(receiveVO.getType() == WebSocketConstant.NEW_ROOM) {
			ChatRoomProcessVO processVO = mapper.readValue(message.getPayload(), ChatRoomProcessVO.class);
			int chatRoomNo = chatRoomService.createChatRoom(processVO);
			log.debug("new roomNo: " + chatRoomNo);
			chatRooms.put(chatRoomNo, new ChatRoomVO());
			//this.createRoom(chatRoomNo);
			ChatRoomVO chatRoom = chatRooms.get(chatRoomNo);
			chatRoom.enter(member);
			log.debug("chatRooms after create: " + chatRooms);
			//join(member, chatRoomNo);
		}
	}

}
